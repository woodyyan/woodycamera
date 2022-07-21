import SwiftUI

struct FindWoodyView: View {

    var body: some View {
        ScrollView {
            Label("Woody的相机", systemImage: "camera")
            VStack {
                Text("拍照有免费的和付费的，欢迎找Woody了解。")
                    .padding()
            }
            Text("如果你想找Woody拍照，下面是Woody的联系方式哦。")
                .padding()
            HStack {
                Spacer()
                VStack {
                    Label("这是Woody的微信二维码", systemImage: "qrcode.viewfinder")
                    Image("wechat")
                    Divider()
                    Label("这是Woody的微信号", systemImage: "message").padding()
                    Text("colorguitar")
                        .padding()
                        .foregroundColor(.themeColor)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.themeColor, lineWidth: 1)
                        )
                    Button(action: {
                        UIPasteboard.general.string = "colorguitar"
                    }, label: {
                        Text("（点击复制）").font(.system(size: 14))
                    })
                }.padding()
                    .border(Color.themeColor, width: 1)
                Spacer()
            }
        }
    }
}

struct FindView_Previews: PreviewProvider {
    static var previews: some View {
        FindWoodyView()
    }
}
