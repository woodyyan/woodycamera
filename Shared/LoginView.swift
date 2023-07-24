import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    private let signInWithAppleViewModel = SignInWithAppleViewModel()
    
    @ViewBuilder
    var body: some View {
        VStack {
            Image("logo").resizable().frame(width: 50, height: 50)
            Text("登录「Woody的相机」").font(Font.custom("AppleGothic", size: 24)).padding(.bottom)
            Image("Illustration17").padding()
            Text("登录「Woody的相机」可以给喜欢的照片点赞，同时还可以收藏自己喜欢的照片。").font(.system(size: 14)).padding().padding(.leading).padding(.trailing).padding()
            QuickSignInWithApple()
                    .frame(width: 280, height: 60, alignment: .center)
                    .onTapGesture(perform: showAppleLoginView)
            Text("Ⓒ 2023 Woody Studio All rights reserved.")
                .font(.system(size: 12))
                .foregroundColor(.gray)
        }
    }
    
    func showAppleLoginView() {
        signInWithAppleViewModel.loginCallback = {(success) -> Void in
            if success {
                self.presentationMode.wrappedValue.dismiss()
            } else {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        // 1. Instantiate the AuthorizationAppleIDProvider
        let provider = ASAuthorizationAppleIDProvider()
        // 2. Create a request with the help of provider - ASAuthorizationAppleIDRequest
        let request = provider.createRequest()
        // 3. Scope to contact information to be requested from the user during authentication.
        request.requestedScopes = [.fullName, .email]
        // 4. A controller that manages authorization requests created by a provider.
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = signInWithAppleViewModel
        // 6. Initiate the authorization flows.
        controller.performRequests()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct QuickSignInWithApple: UIViewRepresentable {
    typealias UIViewType = ASAuthorizationAppleIDButton
    
    func makeUIView(context: Context) -> UIViewType {
        return ASAuthorizationAppleIDButton()
        // or just use UIViewType() 😊 Not recommanded though.
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
