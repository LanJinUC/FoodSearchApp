//
//  Recipes.swift
//  FoodSearchApp
//
//  Created by Lan Jin on 2020-11-18.
//

import Foundation


public struct Recipes: Identifiable{
        public var id: String {
            return label
        }
        public var label : String
        public var url : String
        public var image : String
        public var ingredientLines: [String]
        
        
}
