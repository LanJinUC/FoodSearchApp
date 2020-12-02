//
//  ShoppingListView.swift
//  Recipe Garage
//
//  Created by 印思佳 on 2020-12-01.
//

import SwiftUI
import Combine

struct ShoppingListView: View {
    @ObservedObject var taskStore = TaskStore()
    @State var newToDo : String = ""
    
    var searchBar : some View {
        HStack{
            TextField("Enter in a new item", text: self.$newToDo)
            Button(action: self.addNewToDo, label: {
                Text("Add")
                    .foregroundColor(.orange)
            })
        }
    }
    
    func addNewToDo() {
        taskStore.tasks.append(Task(id: String(taskStore.tasks.count + 1), toDoItem: newToDo))
        self.newToDo = ""
    }
    
    var body: some View {
        NavigationView {
            VStack{
                searchBar
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(EdgeInsets(top: 10, leading: 2, bottom: 0, trailing: 5))
                List{
                    ForEach(self.taskStore.tasks){
                        task in Text(task.toDoItem)
                    }
                    .onMove(perform: self.move)
                    .onDelete(perform: self.delete)
                    .listRowBackground(Color.clear)
                    
                }
                .navigationBarTitle("Shopping List")
                .navigationBarItems(trailing: EditButton().foregroundColor(.orange))
                .background(Image("cart"))
                
                
            }
            .background(Color(UIColor.init(red: 1.0, green: 0.96, blue: 0.89, alpha: 1.0)))
            

        }
    }
    func move(from source : IndexSet, to destination : Int) {
        taskStore.tasks.move(fromOffsets: source, toOffset: destination)
    }
    func delete(at offsets: IndexSet) {
        taskStore.tasks.remove(atOffsets: offsets)
    }
}

struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView()
    }
}
