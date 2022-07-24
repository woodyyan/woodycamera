import SwiftUI
//#-learning-task(gridItemView)

/*#-code-walkthrough(4.gridItemView)*/
struct GridItemView: View {
    /*#-code-walkthrough(4.gridItemView)*/
    /*#-code-walkthrough(4.properties)*/
    let size: Double
    let item: ImageItem
    /*#-code-walkthrough(4.properties)*/

    var body: some View {
        /*#-code-walkthrough(4.zStack)*/
        ZStack(alignment: .topTrailing) {
            /*#-code-walkthrough(4.zStack)*/
            /*#-code-walkthrough(4.asyncImage)*/
            AsyncImage(url: item.url.smallUrl) { image in
                /*#-code-walkthrough(4.asyncImage)*/
                /*#-code-walkthrough(4.imageView)*/
                image
                    .resizable()
                    .scaledToFill()
                /*#-code-walkthrough(4.imageView)*/
            } placeholder: {
                /*#-code-walkthrough(4.progressView)*/
                ProgressView()
                /*#-code-walkthrough(4.progressView)*/
            }
            .frame(width: size, height: size)
        }
    }
}

struct GridItemView_Previews: PreviewProvider {
    static var previews: some View {
        if let url = Bundle.main.url(forResource: "mushy1", withExtension: "jpg") {
            GridItemView(size: 50, item: ImageItem(url: url, tag: 3))
        }
    }
}

extension URL {
    var smallUrl: URL {
        return URL(string: self.absoluteString + "/zoomphoto")!
    }
}
