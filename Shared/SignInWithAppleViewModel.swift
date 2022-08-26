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
        UserDefaults.standard.set(credential.user, forKey: "userId")
        if let email = credential.email {
            UserDefaults.standard.set(email, forKey: "email")
        }
        if let familyName = credential.fullName?.familyName {
            UserDefaults.standard.set(familyName, forKey: "familyName")
        }
        if let givenName = credential.fullName?.givenName {
            UserDefaults.standard.set(givenName, forKey: "givenName")
        }
        //TODO
        // Give Call Back to UI
        self.loginCallback?(true)
    }
    
    private func signInExistingUser(credential: ASAuthorizationAppleIDCredential) {
        print(credential.user)
        UserDefaults.standard.set(credential.user, forKey: "userId")
        // API Call - Pass the user identity, authorizationCode and identity token
        //TODO
        // Give Call Back to UI
        self.loginCallback?(true)
    }
    
    private func signinWithUserNamePassword(credential: ASPasswordCredential) {
        print(credential.user)
        print(credential.password)
        // API Call - Sign in with Username and password
        // Give Call Back to UI
        self.loginCallback?(true)
    }
}
