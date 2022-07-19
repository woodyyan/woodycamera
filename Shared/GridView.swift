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
            /*#-code-walkthrough(5.gridImplementation)*/
                LazyVGrid(columns: gridColumns) {
                    /*#-code-walkthrough(5.gridImplementation)*/
                    /*#-code-walkthrough(5.forEach)*/
                    ForEach(modelItem.images) { item in
                        /*#-code-walkthrough(5.forEach)*/
                        /*#-code-walkthrough(5.geometryReader)*/
                        GeometryReader { geo in
                            /*#-code-walkthrough(5.geometryReader)*/
                            NavigationLink(destination: DetailView(item: item)) {
                                /*#-code-walkthrough(5.gridItemView)*/
                                /*#-code-walkthrough(5.gridParameters)*/
                                GridItemView(size: geo.size.width, item: item)
                                /*#-code-walkthrough(5.gridParameters)*/
                                /*#-code-walkthrough(5.gridItemView)*/
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
 
