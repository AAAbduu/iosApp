//
//  Model.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 6/11/23.
//  This class holds all operations needed with the backend, it is a Singleton class so only 1 instance is created and shared though all the app.

import Foundation
import Amplify
import AWSAPIPlugin
import AWSDataStorePlugin
import AWSCognitoAuthPlugin
import AWSS3StoragePlugin
import PhotosUI

enum AuthState {
    case signUpSignIn
    case confirmSignUp(currentUser: User)
    case session(user: User)
}

final class ModelMain: ObservableObject {
    @Published var authState: AuthState = .signUpSignIn
    @Published var currentUser : User?
    @Published var currentBannerImage: UIImage? = nil
    @Published var currentProfileImage: UIImage? = nil
        
    /**
        A function that initializes the singleton class.
     */
    
    private init() {
        configureAmplify()
        Task.detached{
            await self.getCurrentAuthUser()
            DispatchQueue.main.async{
                self.getBannerImage()
                self.getProfileImage()
            }
        }
        
    }
    
    // Singleton instance
    static let shared = ModelMain()
    
    /**
     Initial configuration required by Amplify.
     */
    
    private func configureAmplify() {
        let dataStorePlugin = AWSDataStorePlugin(modelRegistration: AmplifyModels())
        
        do {
            try Amplify.add(plugin: dataStorePlugin)
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSS3StoragePlugin())
            try Amplify.add(plugin: AWSAPIPlugin(modelRegistration: AmplifyModels()))
            try Amplify.configure()
            
            print("Initialized Amplify");
        } catch {
            print("Could not initialize Amplify: \(error)")
        }
    }
    
    
    /**
     Function to retrieve the current Auth session.
     */
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
    /**
     Function to retrieve the current authenticated user
     */
    func getCurrentAuthUser() async -> AuthUser?{
        do{
            let userAuth = try await Amplify.Auth.getCurrentUser()
            let userO = await self.getUser(userID: userAuth.userId)
            if let user = userO{
                DispatchQueue.main.async{
                    self.authState = .session(user: user)
                    self.currentUser = user
                }
                
            }
            return userAuth
        }catch{
            DispatchQueue.main.async{
                self.authState = .signUpSignIn
            }
        }
        return nil
    }
    
    /**
     A function to signup new users within the app.

     - Parameters:
        - username: The desired username for the new user.
        - password: The password for the new user.
        - email: The email address for the new user.

     This function uses Amplify's Auth module to sign up a new user with the provided credentials.

     - Important:
        - The function is marked as `async` to handle asynchronous operations.
        - The user's email and preferred username are added as attributes for the signup process.

     - Throws:
        - `AuthError`: If an error occurs during the signup process.

     - Note:
        - After a successful signup, the function may require additional steps such as confirming the user's identity.
        - The function updates the `authState` property upon successful signup or logs any encountered errors.

     Example Usage:
     ```swift
     await signup(username: "john_doe", password: "password123", email: "john.doe@example.com")
     */
    func signup(username: String, password: String, email: String) async{

        
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
                    DispatchQueue.main.async{
                        self.authState = .confirmSignUp(currentUser: currentUser)
                    }
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
    
    /**
     Confirms the signup of a user with the provided confirmation code.

     - Parameters:
        - currentUser: The user object representing the current user.
        - code: The confirmation code received by the user.

     This function uses Amplify's Auth module to confirm the signup of a user with the given confirmation code.

     - Important:
        - The function updates the `authState` property to `.signUpSignIn` after successful confirmation.
        - Calls the `createUser` function to handle additional user creation tasks.

     - Throws:
        - `AuthError`: If an error occurs during the confirmation process.

     Example Usage:
     ```swift
     await confirm(currentUser: user, code: "123456")
     */
    func confirm(currentUser: User, code: String) async{
        do{
            if let username = currentUser.username{
                let confirmResult = try await Amplify.Auth.confirmSignUp(for: username, confirmationCode: code)
                print("Confirm sign up result completed: \(confirmResult.isSignUpComplete)")
                
            }
            DispatchQueue.main.async{
                self.authState = .signUpSignIn
            }
            
            await self.createUser(currentUser: currentUser)
            
            
        } catch let error as AuthError {
            print("An error occurred while confirming sign up \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
        
    }
    /**
     Signs in a user with the provided username and password.

     - Parameters:
        - username: The username of the user.
        - password: The password associated with the user.

     This function uses Amplify's Auth module to sign in a user with the provided credentials.

     - Important:
        - If the sign-in is successful, updates the `authState` property to `.session(user: User)`.
        - Retrieves the current authenticated user and updates the `currentUser` property.

     - Throws:
        - `AuthError`: If an error occurs during the sign-in process.

     Example Usage:
     ```swift
     await signIn(username: "john_doe", password: "password123")
     */
    
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
                        DispatchQueue.main.async{
                            self.authState = .session(user: user)
                            print(self.currentUser?.username ?? "")
                        }
                    }
                    
                    
                } else {
                    // Handle the case where 'getCurrentAuthUser()' returns nil (no authenticated user).
                    DispatchQueue.main.async{
                        self.authState = .signUpSignIn
                    }
                }
            }
        } catch let error as AuthError {
            print("Sign in failed \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    /**
     Retrieves the user ID associated with a given username.

     - Parameter:
        - username: The username to query for.

     This function uses Amplify's API module to perform a GraphQL query and retrieve the user ID based on the provided username.

     - Returns:
        - The user ID if found; otherwise, `nil`.

     - Throws:
        - `APIError`: If an error occurs during the API query.
     */
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
    /**
     Retrieves a user object based on the provided user ID.

     - Parameter:
        - userID: The unique identifier of the user.

     This function uses Amplify's API module to perform a GraphQL query and retrieve a user object based on the provided user ID.

     - Returns:
        - The user object if found; otherwise, `nil`.

     - Throws:
        - `APIError`: If an error occurs during the API query.
     */
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
    
    /**
     Signs out the user locally from the app.

     This function uses Amplify's Auth module to locally sign out the user.

     - Important:
        - Resets local state variables like `currentBannerImage` and `currentProfileImage`.
        - Updates the `authState` property to `.signUpSignIn` after a successful sign-out.

     - Note:
        - Differentiates between complete sign-out, partial sign-out with errors, and sign-out failure.
     */
    func signOutLocally() async {
        let result = await Amplify.Auth.signOut()
        guard let signOutResult = result as? AWSCognitoSignOutResult
        else {
            print("Signout failed")
            return
        }
        
        print("Local signout successful: \(signOutResult.signedOutLocally)")
        currentBannerImage = nil
        currentProfileImage = nil
        switch signOutResult {
        case .complete:
            // Sign Out completed fully and without errors.
            print("Signed out successfully")
            DispatchQueue.main.async{
                self.authState = .signUpSignIn
            }
            
            
            
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
    
    /**
     Creates a new user in the backend using the provided User model.

     - Parameter:
        - currentUser: The User model representing the new user.

     This function uses Amplify's API module to perform a GraphQL mutation and create a new user in the backend.

     - Throws:
        - `APIError`: If an error occurs during the API mutation.
     */
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
    
    /**
     Creates a new post in the backend using the provided parameters.

     - Parameters:
        - postContent: The content of the post.
        - graphicalResourceKey: The key for the graphical resource associated with the post.
        - whoClaimed: The claimant of the post.
        - geoGraphicaPostPos: The geographical position of the post.
        - timePosted: The timestamp when the post was created.
        - timeToPublish: The timestamp when the post is scheduled to be published.

     This function uses Amplify's API module to perform a GraphQL mutation and create a new post in the backend.

     - Important:
        - Determines the post status (past, upcoming, or live) based on the provided timestamps.

     - Throws:
        - `APIError`: If an error occurs during the API mutation.
     */
    func createPost(postContent: String, graphicalResourceKey: String, whoClaimed: String, geoGraphicaPostPos: GeoGraphicalData, timePosted: Date, timeToPublish: Date) async {
        
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
                graphicalResourceKey: graphicalResourceKey,
                whoClaimed: nil,
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
    
    /**
     Retrieves the posts associated with the current user.

     - Returns:
        - A List of posts if available; otherwise, an empty List.
     */
    func getUsersPost() async -> List<Post>{
        
        if let posts = self.currentUser?.posts{
            
            return posts
        }
        return List()
    }
    
    /**
     Retrieves a user object with associated posts based on the provided user ID.

     - Parameter:
        - userID: The unique identifier of the user.

     - Returns:
        - The user object if found; otherwise, `nil`.
     */
    func getUserWithPosts(userID: String) async -> User? {
        do {
            let user = try await Amplify.DataStore.query(User.self, byId: userID)
            return user
        } catch {
            print("Error fetching user: \(error)")
            return nil
        }
    }
    
    /**
     Uploads data to the storage bucket with the specified key.

     - Parameters:
        - key: The unique identifier for the data in the storage bucket.
        - data: The data to be uploaded.

     - Returns:
        - The key of the uploaded data if successful; otherwise, `nil`.

     */
    func uploadToBucket(key: String, data: Data)async -> String?{
        do {
            //let dataString = "MyData"
            //let data = Data(dataString.utf8)
            let uploadTask = Amplify.Storage.uploadData(
                key: key,
                data: data
            )
            
            Task {
                for await progress in await uploadTask.progress {
                    print("Progress: \(progress)")
                }
            }
            
            let value = try await uploadTask.value
            print("Completed: \(value)")
            return value
        } catch let error as StorageError {
            print("Failed: \(error.errorDescription). \(error.recoverySuggestion)")
        } catch {
            print("Unexpected error: \(error)")
        }
        return nil
    }
    
    /**
     Updates the user information in the backend using the provided updated User model.

     - Parameter:
        - updatedModel: The updated User model.

     This function uses Amplify's API module to perform a GraphQL mutation and update the user information in the backend.

     - Throws:
        - `APIError`: If an error occurs during the API mutation.

     */
    func updateUser(updatedModel: User) async {
        do {
            let result = try await Amplify.API.mutate(request: .update(updatedModel))
            switch result {
            case .success(let model):
                print("Successfully updated User: \(model)")
            case .failure(let error):
                print("Got failed result with \(error.errorDescription)")
            }
        } catch let error as APIError {
            print("Failed to update User - \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
    /**
     Deletes data from the storage bucket with the specified key.

     - Parameter:
        - key: The unique identifier for the data in the storage bucket.
     */
    func deleteFromBucket(key: String) async {
        
        do {
            let removedKey = try await Amplify.Storage.remove(key: key)
            print("Deleted \(removedKey)")
        } catch let error as StorageError {
            print("Failed: \(error.errorDescription). \(error.recoverySuggestion)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
    /**
     Retrieves data from the storage bucket with the specified key.

     - Parameter:
        - key: The unique identifier for the data in the storage bucket.

     - Returns:
        - The retrieved data if successful; otherwise, `nil`.
     */
    func getFromBucket(key: String) async-> Data?{
        do {
            let downloadTask = Amplify.Storage.downloadData(
                key: key
            )
            
            Task {
                for await progress in await downloadTask.progress {
                    print("Progress: \(progress)")
                }
            }
            
            let value = try await downloadTask.value
            print("Completed: \(value)")
            return value
            
        } catch let error as StorageError {
            print("Failed: \(error.errorDescription). \(error.recoverySuggestion)")
        } catch {
            print("Unexpected error: \(error)")
        }
        return nil
        
    }
    
    /**
     Lists the keys of items stored in the storage bucket.
     */
    func listBucketKeys() async{
        let options = StorageListRequest.Options(pageSize: 1000)
        
        do {
            let listResult = try await Amplify.Storage.list(options: options)
            
            listResult.items.forEach { item in
                print("Key: \(item.key)")
            }
        } catch {
            print("Error listing items from storage: \(error)")
        }
    }
   
    /**
     Updates the current user information, including profile and banner images.

     - Note:
        - Calls `getUser` to fetch the updated user information and updates local state variables.

     */
    func updateCurrentUser(){
        let wCurrentID = self.currentUser?.id
        
        if let currentID = wCurrentID{
            Task{
                let updatedUser = await self.getUser(userID: currentID)
                DispatchQueue.main.async{
                    self.currentUser = updatedUser
                    self.getBannerImage()
                    self.getProfileImage()
                }
            }
        }
    }
    
    /**
     Updates the post information in the backend using the provided updated Post model.

     - Parameter:
        - post: The updated Post model.

     This function uses Amplify's API module to perform a GraphQL mutation and update the post information in the backend.

     - Throws:
        - `APIError`: If an error occurs during the API mutation.
    */
    func updatePost(post: Post) async {
        do {
            let result = try await Amplify.API.mutate(request: .update(post))
            switch result {
            case .success(let model):
                print("Successfully updated Post: \(model)")
            case .failure(let error):
                print("Got failed result with \(error.errorDescription)")
            }
        } catch let error as APIError {
            print("Failed to update User - \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    /**
     Retrieves a post object based on the provided Post model.
     */
    func getPost(post: Post) async -> Post?{
        do {
            let result = try await Amplify.API.query(
                request: .get(Post.self,
                byId: post.id)
            )
            switch result {
            case .success(let model):
                guard let model = model else {
                    print("Could not find model")
                    return nil
                }
                print("Successfully retrieved model: \(model)")
                return model
            case .failure(let error):
                print("Got failed result with \(error)")
            }
        } catch let error as APIError {
            print("Failed to query Post - \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
        return nil
    }
    
    /**
     Retrieves the banner image associated with the current user.

    - Note:
       - Calls `getFromBucket` to fetch the banner image data and updates the `currentBannerImage` property.
     */
    func getBannerImage(){
        if let banerKey = self.currentUser?.bannerImageKey{
            Task{
                let banerData = await self.getFromBucket(key: banerKey)
                if let bData = banerData{
                    let image = UIImage(data: bData)
                    DispatchQueue.main.async{
                        self.currentBannerImage = image
                    }
                }
            }
        }
    }
    
    func getProfileImage() {
        if let profileKey = self.currentUser?.profileImageKey{
            Task{
                let profileData = await self.getFromBucket(key: profileKey)
                if let pData = profileData{
                    let image = UIImage(data: pData)
                    DispatchQueue.main.async{
                        self.currentProfileImage = image
                    }
                }
            }
        }
    }
    
    /**
     Retrieves the banner image associated with the provided user.

     - Parameter:
        - user: The user for whom the banner image should be retrieved.

     - Returns:
        - The retrieved banner image if successful; otherwise, `nil`.
     */
    func getAnyBannerImage(user: User) async -> UIImage? {
        if let bannerKey = user.bannerImageKey {
            let bannerData = await getFromBucket(key: bannerKey)
            if let imageData = bannerData {
                return UIImage(data: imageData)
            }
        }
        return nil
    }
    
    /**
     Retrieves the profile image associated with the provided user.

     - Parameter:
        - user: The user for whom the profile image should be retrieved.

     - Returns:
        - The retrieved profile image if successful; otherwise, `nil`.
     */
    func getAnyProfileImage(user: User) async -> UIImage? {
        if let profileKey = user.profileImageKey {
            let profileData =  await getFromBucket(key: profileKey)
            if let imageData = profileData {
                return UIImage(data: imageData)
            }
        }
        return nil
    }
    
    /**
     Retrieves the current Ether (ETH) to USD exchange rate using an external API.

     - Returns:
        - The ETH to USD exchange rate if successful; otherwise, `0.0`.
     */
    func ethPriceConversionAPI() async -> Double{
        let url = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=USD&api_key=\(ProcessInfo.processInfo.environment["CRYPTO_EXCHANGE_API_KEY"])")
        if let unwUrl = url{
            do{
                let (data, _) = try await URLSession.shared.data(from: unwUrl)
                let decoded = try JSONDecoder().decode(EthResponse.self, from: data)
                print(decoded)
                return decoded.USD
            }catch{
                print("Error")
            }
        }
        return 0.0
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

struct EthResponse: Decodable{
    let USD: Double
}
