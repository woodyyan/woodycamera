import SwiftUI

struct MoreView: View {
    @State private var isSharePresented: Bool = false
    
    @ViewBuilder
    var body: some View {
        VStack {
            Image("logo")
            List {
                Section(header: Text("账户")) {
                    
                    NavigationLink(destination: MyView()) {
                        Label("我的", systemImage: "person.circle")
                    }
                    
                    NavigationLink(destination: Text("ddd")) {
                        Label("收藏", systemImage: "heart.circle")
                    }
                }
                Section(header: Text("拍照")) {
                    let imageName = "Illustration" + String(Int.random(in: 1...17))
                    NavigationLink(destination: UrgeWoodyView(imageName: imageName)) {
                        Label("催更", systemImage: "paperplane.circle")
                    }
                    NavigationLink(destination: FindWoodyView()) {
                        Label("想找Woody拍照", systemImage: "camera")
                    }
                    Button {
                        self.isSharePresented = true
                    } label: {
                        Label("推荐「Woody的相机」给朋友", systemImage: "square.and.arrow.up")
                    }
                    .sheet(isPresented: $isSharePresented, onDismiss: {
                        print("Dismiss")
                    }, content: {
                        ActivityViewController(activityItems: [URL(string: "https://apps.apple.com/us/app/woody%E7%9A%84%E7%9B%B8%E6%9C%BA/id1636187969") as Any])
                    })
                }
                Section(header: Text("关于")) {
                    NavigationLink(destination: AboutView()) {
                        Label("关于", systemImage: "info.circle")
                    }
                }
            }
        }
    }
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView()
    }
}
