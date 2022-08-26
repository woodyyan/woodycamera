//
//  MyView.swift
//  woodycamera
//
//  Created by 颜松柏 on 2022/8/9.
//

import Foundation
import SwiftUI
import AuthenticationServices

struct MyView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var isPresented = false
    @State var isLogedOut = false
    @State var name = "你"
    @State var day = "1"
    @State var count = "1"
    
    @ViewBuilder
    var body: some View {
        VStack {
            Image("Illustration16").padding().padding(.leading)
            Text("欢迎「\(name)」").font(Font.custom("AppleGothic", size: 24))
            HStack {
                Text("第")
                Text("\(day)").font(Font.custom("AppleGothic", size: 40)).foregroundColor(.themeColor)
                Text("天")
            }.padding(.leading).padding(.trailing).padding(.top).padding()
            Text("你已经来「Woody的相机」第N天了")
            HStack {
                Text("第")
                Text("\(count)").font(Font.custom("AppleGothic", size: 40)).foregroundColor(.themeColor)
                Text("个")
            }.padding(.leading).padding(.trailing).padding(.top).padding(.top).padding()
            Text("你是第N个关注Woody的用户")
            Spacer()
            Button {
                UserDefaults.standard.set(nil, forKey: "userId")
                self.isLogedOut = true
            } label: {
                Text("退出登录")
            }.padding()
                .alert("退出成功", isPresented: $isLogedOut) {
                    Button("好的", role: .cancel) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
        }.onAppear {
            if UserDefaults.standard.string(forKey: "userId") == nil {
                self.isPresented = true
            } else {
                name = UserDefaults.standard.string(forKey: "givenName") ?? "你"
                day = UserDefaults.standard.string(forKey: "count") ?? "1"
                count = UserDefaults.standard.string(forKey: "day") ?? "1"
            }
        }.sheet(isPresented: $isPresented) {
            LoginView()
        }
    }
    
    func getUserInfo() -> String {
        return "ddd"
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
    }
}
