//
//  ContentView.swift
//  Shared
//
//  Created by 颜松柏 on 2022/7/17.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var dataModel = DataModel()

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    VStack {
                        HStack {
                            Text("2022-7-21").foregroundColor(.darkGray)
                            Text("九九诗").foregroundColor(.themeColor).bold()
                            Spacer()
                            Image("location").resizable().frame(width: 20, height: 20, alignment: Alignment.center)
                            Text("深圳").foregroundColor(.gray)
                        }
                        HStack {
                            Text("森系")
                                .padding()
                                .frame(maxHeight: 24, alignment: .center)
                                .font(.system(size: 12))
                                .background(Color.themeColor)
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                            Text("小清新")
                                .padding()
                                .frame(maxHeight: 24, alignment: .center)
                                .font(.system(size: 12))
                                .background(Color.themeColor)
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                            Spacer()
                        }
                        GridView()
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button(action: moreItem) {
                        Label("Add Item", systemImage: "wand.and.rays")
                    }
                }
            }.navigationBarTitle("Woody的相机", displayMode: .inline)
                .navigationViewStyle(.stack)
        }
        .environmentObject(dataModel)
            .navigationViewStyle(.stack)
    }

    private func moreItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
