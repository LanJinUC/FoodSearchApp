//
//  AppView.swift
//  FoodSearchApp
//
//  Created by Lan Jin on 2020-11-18.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "server.rack" ).renderingMode(.template)
                        
                    Text("Pantry")
                }

          //  RecipeView(Query: $Query)
                
            Text("").tabItem {
                Image(systemName: "text.book.closed")
                Text("Recipes") }.tag(3)
            Text("Saved").tabItem {
                Image(systemName: "heart.fill")
                Text("Saved") }.tag(3)
            
            ShoppingListView().tabItem {
                Image(systemName: "cart")
                Text("Shopping List") }.tag(4)

            Text("Profile")
                .tabItem {
                Image(systemName: "person.fill")
                Text("Profile") }.tag(5)
        }.accentColor(.orange)
    }
}
struct AppView_Previews: PreviewProvider {
 
    static var previews: some View {
        AppView()
    }
}
