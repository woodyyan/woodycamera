import SwiftUI

struct DetailView: View {
    let modelItem: ModelItem
    @State var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            ForEach(modelItem.images) { item in
                ZStack {
//                    Color.blue
                    AsyncImage(url: item.url) { image in
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
//        .onAppear {
//            setupAppearance()
//        }
    }
    
//    func setupAppearance() {
//        UIPageControl.appearance().currentPageIndicatorTintColor = .black
//        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
//    }
}
