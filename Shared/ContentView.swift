//
//  ContentView.swift
//  Shared
//
//  Created by 颜松柏 on 2022/7/17.
//

import SwiftUI

struct ContentView: View {
//    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dataModel : DataModel

//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(dataModel.items) { item in
                    VStack {
                        HStack {
                            Text(item.date).foregroundColor(.darkGray)
                            Text(item.modelName).foregroundColor(.themeColor).bold()
                            Spacer()
                            Image("location").resizable().frame(width: 20, height: 20, alignment: Alignment.center)
                            Text(item.city).foregroundColor(.gray)
                        }
                        HStack {
                            ForEach(item.tags) { tag in
                                Text(tag.tag)
                                    .padding()
                                    .frame(maxHeight: 24, alignment: .center)
                                    .font(.system(size: 12))
                                    .background(Color.themeColor)
                                    .foregroundColor(.white)
                                    .clipShape(Capsule())
                            }
                            Spacer()
                        }
                        GridView(modelItem: item)
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(8.0)
                }
            }
            .padding()
            .background(Color.lightGray)
            .toolbar {
                ToolbarItem {
                    Button(action: moreItem) {
                        Label("Add Item", systemImage: "wand.and.rays")
                    }
                }
            }
//            .environmentObject(dataModel)
                .navigationBarTitle("Woody的相机", displayMode: .inline)
                .navigationViewStyle(.stack)
        }
        .navigationViewStyle(.stack)
    }

    private func moreItem() {
        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()

//            do {
////                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
        }
    }
}

//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(DataModel())
    }
}
