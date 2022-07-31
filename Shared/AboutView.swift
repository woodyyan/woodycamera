import SwiftUI

struct AboutView: View {
    @State private var isShowingCopy = false

    var body: some View {
        VStack {
            Spacer()
            Image("logo")
            HStack {
                line
                Label("Woody的相机", systemImage: "camera")
                    .minimumScaleFactor(0.8)
                    .lineLimit(1)
                line
            }
            
            Text("Woody是一个会弹吉他的摄影师，闲暇之余会拍点照片，有时候拍人，有时候拍景。如果你想拍照，欢迎来找Woody，如果你顺便也想弹吉他唱歌，也可以找Woody。")
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.themeColor, lineWidth: 1)
                ).padding()
            
            Button("推荐「Woody的相机」给朋友") {
                let pasteboard = UIPasteboard.general
                let content = "拍照吗？来「Woody的相机」，下载地址：https://apps.apple.com/us/app/woody%E7%9A%84%E7%9B%B8%E6%9C%BA/id1636187969"
                pasteboard.string = content
                isShowingCopy = true
            }
            .alert("复制成功，去粘贴给好友吧。", isPresented: $isShowingCopy) {
                Button("好", role: .cancel) { }
            }
            
            Spacer()
            Text("不会弹吉他的程序员不是好摄影师")
                .foregroundColor(.darkGray)
                .font(.system(size: 14))
                .padding()
            Text("Ⓒ 2022 Woody All rights reserved.")
                .font(.system(size: 12))
                .foregroundColor(.gray)
        }
    }
    
    var line: some View {
        VStack { Divider().background(Color.themeColor) }.padding()
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
