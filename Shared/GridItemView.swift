import SwiftUI
import CachedAsyncImage

struct GridItemView: View {
    let size: Double
    let item: ImageItem

    var body: some View {
        ZStack(alignment: .topTrailing) {
            CachedAsyncImage(url: item.url.smallUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
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
