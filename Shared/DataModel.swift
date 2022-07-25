//#-learning-task(dataModel)
import Foundation
import SwiftUI

/*#-code-walkthrough(3.dataModel)*/
class DataModel: ObservableObject {
    
    @Published var items: [ModelItem] = []
    
    var allItems: [ModelItem] = []
    
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
        
        let url = URL(string: "https://woodycamera-1256194296.cos.ap-guangzhou.myqcloud.com/woodycarema.json")!
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForResource = 60
        let task = URLSession(configuration: config).dataTask(with: url) { [self](data, response, error) in
            guard let data = data else {
                print(error ?? "网络错误")
                setUpDefaultData()
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let models = json["models"] as? [Any] {
                        DispatchQueue.main.async {
                            for model in models {
                                if let modelJson = model as? [String: Any] {
                                    let index = modelJson["index"] as! Int
                                    let urls = modelJson["urls"] as! [String]
                                    let modelName = modelJson["modelName"] as! String
                                    let city = modelJson["city"] as! String
                                    let tags = modelJson["tags"] as! [String]
                                    let date = modelJson["date"] as! String
                                    
                                    let modelItem = ModelItem()
                                    for url in urls {
                                        modelItem.images.append(ImageItem(url: URL(string: url)!, tag: urls.firstIndex(of: url)!))
                                    }
                                    modelItem.index = index
                                    modelItem.city = city
                                    modelItem.date = date
                                    modelItem.modelName = modelName
                                    for tag in tags {
                                        modelItem.tags.append(TagItem(tag: tag))
                                    }
                                    self.items.append(modelItem)
                                }
                            }
                            self.items.sort(by: { $0.index > $1.index })
                            self.allItems = self.items
                        }
                    }
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
                setUpDefaultData()
            }
        }
        task.resume()
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

