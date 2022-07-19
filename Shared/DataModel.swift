//#-learning-task(dataModel)
import Foundation

/*#-code-walkthrough(3.dataModel)*/
class DataModel: ObservableObject {
    
    @Published var items: [ModelItem] = []
    
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
        
        for _ in 0..<2 {
            let modelItem = ModelItem()
            if let urls = Bundle.main.urls(forResourcesWithExtension: "jpg", subdirectory: nil) {
                for url in urls {
                    modelItem.images.append(ImageItem(url: url))
                }
            }
            modelItem.city = "深圳"
            modelItem.date = "2022-7-21"
            modelItem.modelName = "九九诗"
            modelItem.tags.append("森系")
            modelItem.tags.append("小清新")
            modelItem.tags.append("情绪")
            items.append(modelItem)
        }
    }
}

extension URL {
    /// Indicates whether the URL has a file extension corresponding to a common image format.
    var isImage: Bool {
        let imageExtensions = ["jpg", "jpeg", "png", "gif", "heic"]
        return imageExtensions.contains(self.pathExtension)
    }
}

