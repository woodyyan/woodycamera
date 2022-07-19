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
                            HStack {
                                Image("location").resizable().frame(width: 16, height: 16, alignment: Alignment.center)
                                Text(item.city).font(.system(size: 14)).foregroundColor(.gray)
                                    .padding(.leading, -5)
                            }
                            .padding(.all, 5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.gray, lineWidth: 1)
                            )
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
                    Menu {
                        Button(action: {
                            print("dd")
                        }) {
                            Label("催更", systemImage: "paperplane.circle")
                        }
                        Button(action: {}) {
                            Label("想找Woody拍照", systemImage: "camera")
                        }
                        Button(action: {}) {
                            Label("关于", systemImage: "info.circle")
                        }
                    }
                label: {
                    Label("More", systemImage: "wand.and.rays")
                        .foregroundColor(.themeColor)
                }
                }
            }
            .navigationBarTitle("Woody的相机", displayMode: .inline)
            .navigationViewStyle(.stack)
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(DataModel())
    }
}
