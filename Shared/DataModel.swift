//#-learning-task(dataModel)
import Foundation
import SwiftUI

/*#-code-walkthrough(3.dataModel)*/
class DataModel: ObservableObject {
    
    @Published var items: [ModelItem] = []
    
    var allItems: [ModelItem] = []
    
    init() {
        let api = Api<PhotoResponse>()
        Task {
            let response = await api.get(key: "database/woodycamera.json")
            if let photoResponse = response {
                DispatchQueue.main.async {
                    for model in photoResponse.models {
                        let modelItem = ModelItem()
                        modelItem.images = model.urls.map { ImageItem(url: URL(string: $0)!, tag: model.urls.firstIndex(of: $0)!) }
                        modelItem.index = model.index
                        modelItem.city = model.city
                        modelItem.date = model.date
                        modelItem.modelName = model.modelName
                        modelItem.tags = model.tags.map{ TagItem(tag: $0) }
                        self.items.append(modelItem)
                    }
                    self.items.sort(by: { $0.index > $1.index })
                    self.allItems = self.items
                }
            } else {
                setUpDefaultData()
            }
        }
    }
    
    func setUpDefaultData() {
        for _ in 0..<1 {
            let modelItem = ModelItem()
            if let urls = Bundle.main.urls(forResourcesWithExtension: "JPG", subdirectory: nil) {
                for url in urls {
                    modelItem.images.append(ImageItem(url: url, tag: urls.firstIndex(of: url)!))
                }
            }
            modelItem.city = "深圳"
            modelItem.date = "2022-7-3"
            modelItem.modelName = "九九诗"
            modelItem.tags.append(TagItem(tag: "日系"))
            modelItem.tags.append(TagItem(tag: "小清新"))
            modelItem.tags.append(TagItem(tag: "夏日"))
            self.items.append(modelItem)
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

