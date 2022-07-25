import SwiftUI
import CachedAsyncImage

struct DetailView: View {
    let modelItem: ModelItem
    @State var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            ForEach(modelItem.images) { item in
                ZStack {
                    CachedAsyncImage(url: item.url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                }
                .tag(item.tag)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}
