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
    case confirmSignUp(currentUser: User)
    case session(user: User)
}

final class ModelMain: ObservableObject {
    @Published var authState: AuthState = .signUpSignIn
    var currentUser : User?
    
    private init() {
        configureAmplify()
        Task.detached{
            await self.getCurrentAuthUser()
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
            let userAuth = try await Amplify.Auth.getCurrentUser()
            let userO = await self.getUser(userID: userAuth.userId)
            if let user = userO{
                self.authState = .session(user: user)
                self.currentUser = user
                
            }
            return userAuth
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
                if let unwUserId = userId{
                    self.currentUser = User(id: unwUserId ,userAt: username, userEmail: email, username: username, followingUsers: 0, isContentCreator: false, followingUsersAts: nil, followedUsers: 0, followedUsersAts: nil, bioDescription: "", posts: nil)
                }
                
                if let currentUser = self.currentUser{
                    self.authState = .confirmSignUp(currentUser: currentUser)
                }
                
            } else {
                print("SignUp Complete")
            }
        } catch let error as AuthError {
            print("An error occurred while registering a user \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
    func confirm(currentUser: User, code: String) async{
        do{
            if let username = currentUser.username{
                let confirmResult = try await Amplify.Auth.confirmSignUp(for: username, confirmationCode: code)
                print("Confirm sign up result completed: \(confirmResult.isSignUpComplete)")
                
            }
            self.authState = .signUpSignIn
            
            await self.createUser(currentUser: currentUser)
            
            
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
                    let userID = user.userId
                    self.currentUser = await self.getUser(userID: userID)
                    if let user = self.currentUser{
                        self.authState = .session(user: user)
                        print(self.currentUser?.username ?? "")
                    }
                    
                    
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
    
    func getUserByUserAt(username: String) async -> String? {
        let query = """
            query GetUserByUserAtQuery {
              userByUserAt(userAt: "\(username)") {
                items {
                  id
                }
              }
            }
        """
        
        do {
            
            let result = try await Amplify.API.query(
                request: GraphQLRequest<UserResponseID>(
                    document: query,
                    responseType: UserResponseID.self
                )
            )
            
            switch result {
            case .success(let data):
                if let items = data.userByUserAt?.items {
                    for item in items {
                        if let id = item.id {
                            print("ID: \(id)")
                            return id
                        } else {
                            print("ID is nil")
                        }
                    }
                }
                
            case .failure(let errorResponse):
                print("Response contained errors: \(errorResponse)")
            }
        } catch let error as APIError {
            print("Failed with error: \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
        
        return nil
    }
    
    func getUser(userID: String) async -> User?{
        do {
            let result = try await Amplify.API.query(
                request: .get(User.self,
                              byId: "\(userID)")
            )
            switch result {
            case .success(let model):
                guard let model = model else {
                    print("Could not find model")
                    return nil
                }
                print("Successfully retrieved model")
                return model
            case .failure(let error):
                print("Got failed result with \(error)")
            }
        } catch let error as APIError {
            print("Failed to query User - \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
        return nil
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
    
    func createUser(currentUser: User) async {
        let model = currentUser
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
    
    
    func createPost(postContent: String, graphicalResource: String, whoClaimed: String, geoGraphicaPostPos: GeoGraphicalData, timePosted: Date, timeToPublish: Date) async {
        
        var postStatus : PostStatus = .past
        
        if Date() < timeToPublish{
            postStatus = .upcoming
        }else if timeToPublish < Date(){
            postStatus = .live
        }
        if let postOwner = self.currentUser{
            let model = Post(
                postOwner: postOwner,
                postContent: postContent,
                postStatus: postStatus,
                graphicalResource: graphicalResource,
                whoClaimed: "",
                geoGraphicalPostPosition: geoGraphicaPostPos,
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
    
    func getUsersPost() async -> List<Post>{
        
        if let posts = self.currentUser?.posts{
            
            return posts
        }
        return List()
    }
    
    func getUserWithPosts(userID: String) async -> User? {
        do {
            let user = try await Amplify.DataStore.query(User.self, byId: userID)
            return user
        } catch {
            print("Error fetching user: \(error)")
            return nil
        }
    }

    
}

struct UserResponseID: Codable {
    let userByUserAt: UserByUserAtResponse?
    
    struct UserByUserAtResponse: Codable {
        let items: [Item]?
        
        struct Item: Codable {
            let id: String?
        }
    }
}
