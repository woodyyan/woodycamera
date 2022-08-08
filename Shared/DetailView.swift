import SwiftUI
import LBJImagePreviewer

struct DetailView: View {
    let modelItem: ModelItem
    @State var selection = 0
    @State private var zoomed: Bool = false
    @State private var isSharePresented: Bool = false

    var body: some View {
        TabView(selection: $selection) {
            ForEach(modelItem.images) { item in
                ZStack {
                    AsyncImage(url: getLocalImageUrl(url: item.url)) { image in
                        image.resizable()
                            .scaledToFit()
                            .aspectRatio(contentMode: self.zoomed ? .fill : .fit)
                            .onTapGesture { // 注册点击事件
                                withAnimation{ // 添加动画效果
                                    self.zoomed.toggle() // toggle方法可以取Bool值得反值
                                }
                            }
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
                    self.isSharePresented = true
                } label: {
                    Label("Share", systemImage: "square.and.arrow.up")
                                        .foregroundColor(.themeColor)
                }
                .sheet(isPresented: $isSharePresented, onDismiss: {
                    print("Dismiss")
                }, content: {
                    ActivityViewController(activityItems: [UIImage(data:try! Data(contentsOf: self.getLocalImageUrl(url: self.modelItem.images[self.selection].url))) as Any])
                })
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func saveImage(image: UIImage, filename: String) -> Bool {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return false
        }
        let directory = getDocumentsDirectory()
        do {
            try data.write(to: directory.appendingPathComponent(filename))
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func getLocalImageUrl(url: URL) -> URL {
        let path = getDocumentsDirectory().appendingPathComponent(url.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: path.path) {
            return path
        }
        
        self.getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            if saveImage(image: UIImage(data: data)!, filename: url.lastPathComponent) {
                print("Save success")
            }
        }
        return url
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let dataPath = documentsDirectory.appendingPathComponent("images")
        if !FileManager.default.fileExists(atPath: dataPath.path) {
            do {
                try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
        return dataPath
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
