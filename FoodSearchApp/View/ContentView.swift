//
//  ContentView.swift
//  FoodSearchApp
//
//  Created by Lan Jin on 2020-11-17.
//

import SwiftUI

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

