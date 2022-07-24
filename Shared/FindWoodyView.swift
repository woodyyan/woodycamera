import SwiftUI

struct FindWoodyView: View {
    @State private var isShowingCopy = false

    var body: some View {
        ScrollView {
            Group {
                HStack {
                    line
                    Label("Woody的收费说明", systemImage: "dollarsign.circle")
                        .foregroundColor(.themeColor)
                        .minimumScaleFactor(0.6)
                        .lineLimit(1)
                    line
                }
                VStack(alignment: .leading, spacing: 6) {
                    Text("• 价格：688元")
                    Text("• 12张精修，底片>80张全送")
                    Text("• 想去哪里拍都可以，户外室内皆可")
                    Text("• 想拍什么风格都可以和Woody商量")
                    Text("• 拍摄时长：1-3小时")
                    Text("• 交付照片时间：7天内")
                    Text("• 如果是两个人要加100元噢")
                }.padding()
            }
            Group {
                HStack {
                    line
                    Label("Woody的优点", systemImage: "hand.thumbsup")
                        .foregroundColor(.themeColor)
                        .minimumScaleFactor(0.9)
                        .lineLimit(1)
                    line
                }
                VStack(alignment: .leading, spacing: 6) {
                    Text("• 人很好说话")
                    Text("• 超会引导")
                    Text("• 能帮你克服镜头恐惧症")
                    Text("• 拍摄+后期修图都是Woody")
                }.padding()
            }
            Group {
                HStack {
                    line
                    Label("Woody的提示", systemImage: "hand.point.right")
                        .foregroundColor(.themeColor)
                        .minimumScaleFactor(0.9)
                        .lineLimit(1)
                    line
                }
                VStack(alignment: .leading, spacing: 6) {
                    Text("• 不包服装")
                    Text("• 不包妆造，毕竟Woody不会化妆")
                    Text("• 如果是付费场地由你付费噢，除非正好Woody也想去这里")
                }.padding()
            }
            HStack {
                line
                Label("One More Thing", systemImage: "heart.circle")
                    .foregroundColor(.themeColor)
                    .minimumScaleFactor(0.7)
                    .lineLimit(1)
                line
            }
            Text("Woody每月都会做一次免费拍摄，如果你想参与这次免费拍摄，与Woody共创作品，可以联系Woody。")
                .padding()
                .padding()
            Group {
                HStack {
                    line
                    Label("Woody的联系方式", systemImage: "plus.message")
                        .foregroundColor(.themeColor)
                        .minimumScaleFactor(0.6)
                        .lineLimit(1)
                    line
                }
//                HStack {
//                    Spacer()
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
                            isShowingCopy = true
                        }, label: {
                            Text("（点击复制）").font(.system(size: 14))
                        }).alert("复制成功", isPresented: $isShowingCopy) {
                            Button("好", role: .cancel) {
                            }
                        }
                    }.padding()
            }
        }
    }
    
    var line: some View {
        VStack { Divider().background(Color.themeColor) }.padding()
    }
}

struct FindView_Previews: PreviewProvider {
    static var previews: some View {
        FindWoodyView()
    }
}
