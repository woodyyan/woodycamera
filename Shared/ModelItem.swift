import SwiftUI


class ModelItem: ObservableObject, Identifiable {
    let id = UUID()
    @Published var images: [ImageItem] = []
    @Published var modelName = "Woody"
    @Published var city = "深圳"
    @Published var tags: [String] = []
    @Published var date = "2022-7-17"
}

extension ModelItem: Equatable {
    static func ==(lhs: ModelItem, rhs: ModelItem) -> Bool {
        return lhs.id == rhs.id && lhs.id == rhs.id
    }
}
