import AuthenticationServices

class SignInWithAppleViewModel: NSObject, ASAuthorizationControllerDelegate {
    var loginCallback: ((Bool)->Void)?
    
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIdCredential as ASAuthorizationAppleIDCredential:
            if let _ = appleIdCredential.email, let _ = appleIdCredential.fullName {
                // Apple has autherized the use with Apple ID and password
                registerNewUser(credential: appleIdCredential)
            } else {
                // User has been already exist with Apple Identity Provider
                signInExistingUser(credential: appleIdCredential)
            }
            break
            
        case let passwordCredential as ASPasswordCredential:
            print("\n ** ASPasswordCredential ** \n")
            signinWithUserNamePassword(credential: passwordCredential)
            break
            
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("\n -- ASAuthorizationControllerDelegate -\(#function) -- \n")
        print(error)
        self.loginCallback?(false)
        // Give Call Back to UI
    }
}

extension SignInWithAppleViewModel {
    private func registerNewUser(credential: ASAuthorizationAppleIDCredential) {
        // API Call - Pass the email, user full name, user identity provided by Apple and other details.
        print(credential.user)
        
        guard let email = credential.email else {
            return
        }
        UserDefaults.standard.set(email, forKey: "email")
        guard let familyName = credential.fullName?.familyName else {
            return
        }
        UserDefaults.standard.set(familyName, forKey: "familyName")
        guard let givenName = credential.fullName?.givenName else {
            return
        }
        UserDefaults.standard.set(givenName, forKey: "givenName")
        
        login(email: email, familyName: familyName, givenName: givenName, userId: credential.user)
    }
    
    private func signInExistingUser(credential: ASAuthorizationAppleIDCredential) {
        print(credential.user)
        // API Call - Pass the user identity, authorizationCode and identity token
        
        // Give Call Back to UI
        login(email: "empty", familyName: "familyName", givenName: "givenName", userId: credential.user)
        self.loginCallback?(true)
    }
    
    private func signinWithUserNamePassword(credential: ASPasswordCredential) {
        print(credential.user)
        print(credential.password)
        // API Call - Sign in with Username and password
        login(email: "empty", familyName: credential.user, givenName: credential.password, userId: credential.user)
        // Give Call Back to UI
        self.loginCallback?(true)
    }
    
    private func login(email: String, familyName: String, givenName: String, userId: String) {
        UserDefaults.standard.set(userId, forKey: "userId")
        Task {
            let api = Api<LoginResponse>()
            let parameters: [String: Any] = [
                "email": email,
                "familyName": familyName,
                "givenName": givenName,
                "userId": userId
            ]
            if let _ = await api.login(loginRequest: parameters) {
                self.loginCallback?(true)
            } else {
                print("登陆失败")
            }
        }
    }
}
