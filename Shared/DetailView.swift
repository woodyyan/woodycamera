import SwiftUI
import CachedAsyncImage

struct DetailView: View {
    let modelItem: ModelItem
    @State var selection = 0
    @State private var isSharePresented: Bool = false

    var body: some View {
        TabView(selection: $selection) {
            ForEach(modelItem.images) { item in
                ZStack {
                    CachedAsyncImage(url: item.url) { image in
                        image.resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                }
                .tag(item.tag)
            }
        }
        .toolbar {
            ToolbarItem {
                Button {
                    print(self.selection)
                    self.isSharePresented = true
                } label: {
                    Label("Share", systemImage: "square.and.arrow.up")
                                        .foregroundColor(.themeColor)
                }
                .sheet(isPresented: $isSharePresented, onDismiss: {
                    print("Dismiss")
                }, content: {
                    ActivityViewController(activityItems: [UIImage(data:try! Data(contentsOf: self.modelItem.images[self.selection].url)) as Any])
                })
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(modelItem: ModelItem())
    }
}

struct ActivityViewController: UIViewControllerRepresentable {

    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}
}
