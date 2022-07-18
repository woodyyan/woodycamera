//#-learning-task(dataModel)
import Foundation

/*#-code-walkthrough(3.dataModel)*/
class DataModel: ObservableObject {
    /*#-code-walkthrough(3.dataModel)*/
    
    /*#-code-walkthrough(3.items)*/
    @Published var items: [ImageItem] = []
    /*#-code-walkthrough(3.items)*/
    
    init() {
        /*#-code-walkthrough(3.preloadItemsDocumentDirectory)*/
//        if let documentDirectory = FileManager.default.documentDirectory {
//            let urls = FileManager.default.getContentsOfDirectory(documentDirectory).filter { $0.isImage }
//            for url in urls {
//                let item = Item(url: url)
//                items.append(item)
//            }
//        }
        /*#-code-walkthrough(3.preloadItemsDocumentDirectory)*/
        
        /*#-code-walkthrough(3.preloadItemsBundleResources)*/
        if let urls = Bundle.main.urls(forResourcesWithExtension: "jpg", subdirectory: nil) {
            for url in urls {
                let item = ImageItem(url: url)
                items.append(item)
            }
        }
        /*#-code-walkthrough(3.preloadItemsBundleResources)*/
    }
}

extension URL {
    /// Indicates whether the URL has a file extension corresponding to a common image format.
    var isImage: Bool {
        let imageExtensions = ["jpg", "jpeg", "png", "gif", "heic"]
        return imageExtensions.contains(self.pathExtension)
    }
}

