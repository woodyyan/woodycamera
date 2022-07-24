import SwiftUI

struct UrgeWoodyView: View {
    @State private var showingAlert = false
    let urgeCount = 1

    @ViewBuilder
    var body: some View {
        VStack {
            Image("logo")
            if urgeCount > 0 {
                Text("😭 Woody已被催更\(urgeCount)次了，Woody最近可能比较忙。").padding()
            } else {
                Text("😊 还没有人催Woody，Woody可以继续偷懒一阵。").padding()
            }
            
            Button {
                showingAlert = true
            } label: {
                Label("Woody快更新！", systemImage: "camera")
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.themeColor, lineWidth: 1)
            )
            .alert("催更成功", isPresented: $showingAlert) {
                Button("好的", role: .cancel) { }
            } message: {
                Text("Woody已经收到你的催更")
            }
            Label("点它催Woody更新", systemImage: "hand.point.up")
                .font(.system(size: 14)).padding()
        }
    }
}

struct UrgeWoodyView_Previews: PreviewProvider {
    static var previews: some View {
        UrgeWoodyView()
    }
}
