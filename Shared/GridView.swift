import SwiftUI
//#-learning-task(gridView)
//#-learning-task(addAnImage)

/*#-code-walkthrough(5.gridView)*/
struct GridView: View {
    var modelItem: ModelItem

    private static let initialColumns = 3
    /*#-code-walkthrough(6.isAddingPhoto)*/
    @State private var isAddingPhoto = false
    /*#-code-walkthrough(6.isAddingPhoto)*/
    /*#-code-walkthrough(6.isEditingPhotos)*/
    @State private var isEditing = false
    /*#-code-walkthrough(6.isEditingPhotos)*/

    @State private var gridColumns = Array(repeating: GridItem(.flexible()), count: initialColumns)
    @State private var numColumns = initialColumns
    
    private var columnsTitle: String {
        gridColumns.count > 1 ? "\(gridColumns.count) Columns" : "1 Column"
    }
    
    var body: some View {
        VStack {
                LazyVGrid(columns: gridColumns) {
                    ForEach(modelItem.images) { item in
                        GeometryReader { geo in
                            NavigationLink(destination: DetailView(modelItem: modelItem, selection: item.tag)) {
                                GridItemView(size: geo.size.width, item: item)
                            }
                        }
                        .cornerRadius(8.0)
                        .aspectRatio(1, contentMode: .fit)
                    }
                }
        }
        .environmentObject(modelItem)
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(modelItem: ModelItem())
    }
}
 
