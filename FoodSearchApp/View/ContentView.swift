//
//  ContentView.swift
//  FoodSearchApp
//
//  Created by Lan Jin on 2020-11-17.
//

import SwiftUI

struct Category: Identifiable {
    var id = UUID()
    var image: String
    var name: String
}

class UserInput : ObservableObject{
    @Published var Query: String = ""
}

struct ContentView: View {
    
    
    @ObservedObject var recipeAPI = RecipeAPI()
    @State private var ingredient: String = ""

    @State private var isEditing = false
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @ObservedObject var input = UserInput()
    @State var properQuery = ""
    @State private var isReadyToNextView = false
   
    let categories: [Category] = [Category(image: "property1", name: "Meat Balls"), Category(image: "property2", name: "Creamy Garlic Tuscan"), Category(image: "property3", name: "Soup"), Category(image: "property4", name: "Easy Chicken")]
    
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to Food Search").font(.title)
                    .foregroundColor(.orange)
                    .onAppear {
                                 self.recipeAPI.fetchData(ingredients: "")
                             }
               
                
                NavigationLink(destination: RecipeView(Query: $input.Query), isActive: $isReadyToNextView) {EmptyView()}
                
                Button("       See Recipes       "){
                    convert(arrayList: usedWords)
                    input.Query = properQuery
                    
                    
                    self.isReadyToNextView = true
                }.foregroundColor(.white).padding().background(Color.orange).cornerRadius(10)
                
                    
                HStack{
                    Image(systemName: "plus.magnifyingglass")
                    .foregroundColor(Color(UIColor.lightGray))
                    TextField("Enter your ingredients", text: $ingredient, onCommit: addNewWord)
                        .foregroundColor(Color(UIColor.black))
                        .onTapGesture {
                            self.isEditing = true
                        }
                    if isEditing {
                        //                    Button(action: {
                        //                        self.ingredient = ""
                        //                    }){
                        //                        Image(systemName: "multiply.circle.fill")
                        //                            .foregroundColor(.gray)
                        //                            .padding(.trailing, 10)
                        //                    }
                    }
                    Spacer()
                    Image(systemName: "camera")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50,height:30)
                    
                    
                }
                .padding(10)
                .background(Color.white)
                .cornerRadius(5)
                HStack{
                    
                    Text("  Today's Popular Recipes").foregroundColor(.orange)
                    Spacer()
                   
                }
                
                
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(self.categories) { item in
                            CategoriesView(item: item)
                        }
                    }
                    .padding(.bottom, 20)
                }
                
    //
                    List {
                        ForEach(usedWords, id: \.self) { user in
                            Text(user)
                        }
                        .onDelete(perform: delete)
                    }
                    
                    
                    
                    
                    Text("\(ingredient)")
                        .padding()
                    
               
            }// .onAppear{self.recipeAPI.fetchData(ingredients: ingredient)}
        }
    }
    
    func delete(at offsets: IndexSet) {
            usedWords.remove(atOffsets: offsets)
        }
    
    func addNewWord() {
        // lowercase and trim the word, to make sure we don't add duplicate words with case differences
        let answer = ingredient.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        // exit if the remaining string is empty
        guard answer.count > 0 else {
            return
        }

        // extra validation to come

        usedWords.insert(answer, at: 0)
        ingredient = ""
    }
    func convert(arrayList: [String]){
        
        properQuery = arrayList.joined(separator: "+")
        }
        
    }
    
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



    



//NavigationView {
////                //UserEnterDataView()
////                List {
////                    ForEach(usedWords, id: \.self) { user in
////                        Text(user)
////                    }
////                    .onDelete(perform: delete)
////                }
////
////
////
////
////                Text("\(ingredient)")
////                    .padding()
////
////            }.onAppear{self.recipeAPI.fetchData(ingredients: ingredient)}
//
//               //UserEnterDataView()

struct CategoriesView: View {
    var item: Category
    var body: some View {
        VStack(spacing: 0) {
            Image(item.image)
                .resizable()
                .frame(width: 130, height: 90)
            Text(item.name)
                .font(.custom("Helvetica Neue", size: 15))
                .foregroundColor(Color.black.opacity(0.9))
                .fontWeight(.regular)
                .padding(.all, 12)
        }
        .background(Color.white)
        .cornerRadius(4.0)
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 0)
        .padding(.leading, 2)
    }
}
