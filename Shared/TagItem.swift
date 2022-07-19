import SwiftUI

struct TagItem: Identifiable {

    let id = UUID()
    let tag: String

}

extension TagItem: Equatable {
    static func ==(lhs: TagItem, rhs: TagItem) -> Bool {
        return lhs.id == rhs.id && lhs.id == rhs.id
    }
}
