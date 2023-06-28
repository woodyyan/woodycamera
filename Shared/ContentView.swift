//
//  ContentView.swift
//  Shared
//
//  Created by 颜松柏 on 2022/7/17.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataModel : DataModel
    @Environment(\.colorScheme) var colorScheme
    @State private var navigateTo = ""
    @State private var isActive = false
    @State private var searchText = ""
    
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
                    .background(colorScheme == .light ? .white : Color.darkModeGray)
                    .cornerRadius(8.0)
                }
            }
            .searchable(text: $searchText, prompt: "搜索标签或模特")
            .onChange(of: searchText, perform: { searchText in
                print(searchText)
                if searchText.isEmpty {
                    self.dataModel.items = self.dataModel.allItems
                } else {
                    self.dataModel.items = self.dataModel.allItems.filter { (modelItem) -> Bool in
                        return modelItem.tags.map{ $0.tag }.contains(searchText) || modelItem.modelName.contains(searchText)
                    }
                }
            })
            .onSubmit(of: .search) {
                print("Search submitted")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(colorScheme == .light ? Color.lightGray : Color.black)
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                        MoreView()
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
    
    func getDestination() -> AnyView {
        switch self.navigateTo {
        case "催更":
            let imageName = "Illustration" + String(Int.random(in: 1...17))
            return AnyView(UrgeWoodyView(imageName: imageName))
        case "想找Woody拍照":
            return AnyView(FindWoodyView())
        case "关于":
            return AnyView(AboutView())
        default:
            return AnyView(AboutView())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(DataModel())
    }
}
