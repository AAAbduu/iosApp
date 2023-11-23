//
//  Model.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 6/11/23.
//

import Foundation
import Amplify
import AWSAPIPlugin
import AWSDataStorePlugin
import AWSCognitoAuthPlugin

enum AuthState {
    case signUpSignIn
    case confirmSignUp(username: String)
    case session(user: AuthUser)
}

final class ModelMain: ObservableObject {
    @Published var authState: AuthState = .signUpSignIn
    var currentUser : AuthUser?
    
    private init() {
        configureAmplify()
        Task.detached{
            self.currentUser = await self.getCurrentAuthUser()
        }
    }
    
    // Singleton instance
    static let shared = ModelMain()
    
    private func configureAmplify() {
        let dataStorePlugin = AWSDataStorePlugin(modelRegistration: AmplifyModels())
        
        do {
            try Amplify.add(plugin: dataStorePlugin)
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSAPIPlugin(modelRegistration: AmplifyModels()))
            try Amplify.configure()
            print("Initialized Amplify");
        } catch {
            print("Could not initialize Amplify: \(error)")
        }
    }
    
    func fetchCurrentAuthSession() async {
        do {
            let session = try await Amplify.Auth.fetchAuthSession()
            print("Is user signed in - \(session.isSignedIn)")
            
        } catch let error as AuthError {
            print("Fetch session failed with error \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
    func getCurrentAuthUser() async -> AuthUser?{
        do{
            let user = try await Amplify.Auth.getCurrentUser()
            self.authState = .session(user: user)
            return user
        }catch{
            self.authState = .signUpSignIn
        }
        return nil
    }
    
    func signup(username: String, password: String, email: String) async{
        //check if username exists if it does, throw error
        //check if email is already in use
        
        let userAttributes = [AuthUserAttribute(.email, value: email), AuthUserAttribute(.preferredUsername, value: username)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        do {
            let signUpResult = try await Amplify.Auth.signUp(
                username: username,
                password: password,
                options: options
            )
            if case let .confirmUser(deliveryDetails, _, userId) = signUpResult.nextStep {
                print("Delivery details \(String(describing: deliveryDetails)) for userId: \(String(describing: userId))")
                self.authState = .confirmSignUp(username: username)
                
            } else {
                print("SignUp Complete")
            }
        } catch let error as AuthError {
            print("An error occurred while registering a user \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
    func confirm(username: String, code: String) async{
        do{
            let confirmResult = try await Amplify.Auth.confirmSignUp(for: username, confirmationCode: code)
            print("Confirm sign up result completed: \(confirmResult.isSignUpComplete)")
            self.authState = .signUpSignIn
            
            await self.createUser(username: username, userAt: "@prueba", isContentCreator: false, bioDescription: "", userEmail: "anawabduali@gmail.com")
            
            
        } catch let error as AuthError {
            print("An error occurred while confirming sign up \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
        
    }
    
    func signIn(username: String, password: String) async {
        do {
            let signInResult = try await Amplify.Auth.signIn(
                username: username,
                password: password
                )
            if signInResult.isSignedIn {
                print("Sign in succeeded")
                
                if let user = await getCurrentAuthUser() {
                    
                    self.authState = .session(user: user)
                    
                } else {
                    // Handle the case where 'getCurrentAuthUser()' returns nil (no authenticated user).
                    self.authState = .signUpSignIn
                }
            }
        } catch let error as AuthError {
            print("Sign in failed \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
    func signOutLocally() async {
        let result = await Amplify.Auth.signOut()
        guard let signOutResult = result as? AWSCognitoSignOutResult
        else {
            print("Signout failed")
            return
        }

        print("Local signout successful: \(signOutResult.signedOutLocally)")
        switch signOutResult {
        case .complete:
            // Sign Out completed fully and without errors.
            print("Signed out successfully")
            self.authState = .signUpSignIn
            
            

        case let .partial(revokeTokenError, globalSignOutError, hostedUIError):
            // Sign Out completed with some errors. User is signed out of the device.
            
            if let hostedUIError = hostedUIError {
                print("HostedUI error  \(String(describing: hostedUIError))")
            }

            if let globalSignOutError = globalSignOutError {
                // Optional: Use escape hatch to retry revocation of globalSignOutError.accessToken.
                print("GlobalSignOut error  \(String(describing: globalSignOutError))")
            }

            if let revokeTokenError = revokeTokenError {
                // Optional: Use escape hatch to retry revocation of revokeTokenError.accessToken.
                print("Revoke token error  \(String(describing: revokeTokenError))")
            }

        case .failed(let error):
            // Sign Out failed with an exception, leaving the user signed in.
            print("SignOut failed with \(error)")
        }
    }

    func createUser(username: String, userAt: String, isContentCreator: Bool, bioDescription: String, userEmail: String) async {
        let model = User(
            username: username,
            userAt: userAt,
            isContentCreator: isContentCreator,
            bioDescription: bioDescription,
            userEmail: userEmail,
            followingUsers: 0,
            usersFollowed: 0)
        do {
            let result = try await Amplify.API.mutate(request: .create(model))
            switch result {
            case .success(let model):
                print("Successfully created User: \(model)")
            case .failure(let graphQLError):
                print("Failed to create graphql \(graphQLError)")
            }
        } catch let error as APIError {
            print("Failed to create User - \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
    func createPost(graphicalResource: String, whoClaimed: String, geoGraphicaPostPos: GeoGraphicalData, timePosted: Date, timeToPublish: Date) async {
        
        var postStatus : PostStatus = .past
        
        if Date() < timeToPublish{
            postStatus = .upcoming
        }else if timeToPublish < Date(){
            postStatus = .live
        }
        
        if let userId = self.currentUser?.userId {
            var userID = userId
            var model = Post(
                userID: userID,
                postStatus: postStatus,
                graphicalResource: graphicalResource,
                whoClaimedUN: "",
                geographicalPostPosition: geoGraphicaPostPos,
                timePosted: Temporal.DateTime(timePosted),
                timeToPublish: Temporal.DateTime(timeToPublish))
            do {
                let result = try await Amplify.API.mutate(request: .create(model))
                switch result {
                case .success(let model):
                    print("Successfully created Post: \(model)")
                case .failure(let graphQLError):
                    print("Failed to create graphql \(graphQLError)")
                }
            } catch let error as APIError {
                print("Failed to create Post - \(error)")
            } catch {
                print("Unexpected error: \(error)")
            }
        }
    }
    
    func getDateFormatted(date: Date) -> String{
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds] 
        let dateString = formatter.string(from: date)
        return dateString
    }
}
