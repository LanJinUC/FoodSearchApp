import Foundation
import SwiftyJSON
import Alamofire

class RecipeAPI: ObservableObject{
    
    @Published var recipes = [Recipes]()
    
    func fetchData(ingredients: String){
        let apiURL = "https://api.edamam.com/search?q="
        let apiId = "&app_id=91b2326a"
        let apiKey = "&app_key=0800f71dbb3c9bc1707ccf5abb12a083"
        
        
        AF.request("\(apiURL)\(ingredients)\(apiId)\(apiKey)").responseJSON{ response in
            switch response.result{
            
            case.success(let value):
                
                let json = JSON(value)
                //print web response
                print(json)
                for (index,subJson):(String, JSON) in json["hits"]{
                    let label = subJson["recipe"]["label"].stringValue
                    let image = subJson["recipe"]["image"].stringValue
                    let url = subJson["recipe"]["url"].stringValue
                    let ingredientLines = subJson["recipe"]["ingredientLines"].arrayValue.map {
                        $0.stringValue}
                    //print(subJson["recipe"]["ingredientLines"])
                   // let recipy = Recipes(label: label, url: url, image: image, ingredientLines: ingredientLines)
                    let recip = Recipes(label: label, url: url, image: image, ingredientLines: ingredientLines)
                    self.recipes.append(recip)
                }
                
            case.failure(let error):
               print(error)
            
            
            }
        }
        
        
        //for test
//        let pathToJsonFile = Bundle.main.path(forResource: "test", ofType: "json")!
//        let data = NSData(contentsOfFile: pathToJsonFile)!
//
//            do{
//                let json = try JSON(data: data as Data)
//                print("yeah?")
//               // print(json)
//
//                for (index,subJson):(String, JSON) in json["hits"]{
//                    let label = subJson["recipe"]["label"].stringValue
//                    let image = subJson["recipe"]["image"].stringValue
//                    let url = subJson["recipe"]["url"].stringValue
//                    let ingredientLines = subJson["recipe"]["ingredientLines"].arrayValue.map {
//                        $0.stringValue}
//                    //print(subJson["recipe"]["ingredientLines"])
//                   // let recipy = Recipes(label: label, url: url, image: image, ingredientLines: ingredientLines)
//                    let recip = Recipes(label: label, url: url, image: image, ingredientLines: ingredientLines)
//                    recipes.append(recip)
//                }
//
//
//
//            }catch{
//                print("Invalid selection")
//            }

        }
        
        


        
        
       


      
        
       

    }
    
    
    
    

