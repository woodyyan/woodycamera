import SwiftUI

struct AboutView: View {
    @State private var isShowingCopy = false

    var body: some View {
        NavigationView {
            VStack {
                Image("whitelogo")
                    .resizable()
                    .frame(width: 74, height: 54)
                    .background(
                        ZStack {
                            Circle()
                                .fill(Color.themeColor).frame(width: 150, height: 150)
                            Circle()
                                .strokeBorder(Color.themeColor, lineWidth: 1).frame(width: 160, height: 160)
                        }
                    )
                    .padding(.bottom, 80)
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
        .navigationBarTitle("关于", displayMode: .inline)
        .navigationBarHidden(false)
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
