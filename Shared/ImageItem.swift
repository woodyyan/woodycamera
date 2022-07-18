import SwiftUI
//#-learning-task(item)

/*#-code-walkthrough(2.itemModel)*/
struct ImageItem: Identifiable {
    /*#-code-walkthrough(2.itemModel)*/

    /*#-code-walkthrough(2.id)*/
    let id = UUID()
    /*#-code-walkthrough(2.id)*/
    /*#-code-walkthrough(2.url)*/
    let url: URL
    /*#-code-walkthrough(2.url)*/

}

extension ImageItem: Equatable {
    static func ==(lhs: ImageItem, rhs: ImageItem) -> Bool {
        return lhs.id == rhs.id && lhs.id == rhs.id
    }
}
