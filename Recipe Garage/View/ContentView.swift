//
//  ContentView.swift
//  FoodSearchApp
//
//  Created by Lan Jin on 2020-11-17.
//

import SwiftUI
import WebKit
import UIKit
import CoreML
import Vision

struct Category: Identifiable {
    var id = UUID()
    var image: String
    var name: String
    var url: String
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
    
    
    @State var imageData : Data = .init(capacity: 0)
    @State var show = false
    @State var imagepicker = false
    @State var source : UIImagePickerController.SourceType = .photoLibrary
    
    @State var showModal : Bool = false
    @Environment(\.openURL) var openURL
    
    var urlString = ""
    @State private var res = ""
    
    
    var leadingButton: some View {
        NavigationLink(destination: WebViewPage(request: URLRequest(url: URL(string: "https://www.google.com")!))){
            Text("Google")
        }
    }
    
    init(){
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        //UITableView.appearance().tableFooterView = UIView()
        //UITableView.appearance().separatorStyle = .none
        
    }
    
    let categories: [Category] = [Category(image: "property1", name: "Meat Balls", url: "https://www.cookingclassy.com/meatball-recipe/"), Category(image: "property2", name: "Garlic Tuscan", url: "https://www.cookingclassy.com/roasted-garlic-mashed-cauliflower/") , Category(image: "property3", name: "Soup", url: "https://www.cookingclassy.com/tortellini-soup/"), Category(image: "property4", name: "Easy Chicken",url: "https://www.cookingclassy.com/chicken-fajitas/")]

    
    var body: some View {
        NavigationView{
            
            VStack{
              
                
                NavigationLink(destination: RecipeView(Query: $input.Query), isActive: $isReadyToNextView) {EmptyView()}
                
               VStack{
                    //HStack{
                        
                        TextField("Enter your ingredients", text: $ingredient, onCommit: addNewWord)
                            .padding(.horizontal, 25.0)
                            .padding(EdgeInsets(top: 20, leading: 2, bottom: 0, trailing: 5))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onTapGesture {
                                self.isEditing = true
                            }
                        
                        
                        if isEditing {}
                    //}
                    
                        HStack{
                            
                            Text("  Today's Popular Recipes")
                                .foregroundColor(.orange)
                                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                            
                            
                            Spacer()
                           
                        }
                
                
//                        ScrollView(.horizontal) {
//                            HStack(spacing: 20) {
//
//                                ForEach(self.categories) { item in
//                                    CategoriesView(item: item)
//                                }
//
//                            }
//                            .padding(.bottom, 20)
//                        }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                
            
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {

                            ForEach(self.categories) { item in
                                NavigationLink(destination: DetailView(url: item.url)) {
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

                        }
                        .padding(.bottom, 20)
                    }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                
                
                    
                    List {
                        ForEach(usedWords, id: \.self)
                            { user in Text(user)}
                            .onDelete(perform: delete)
                            //.listRowBackground(Color(UIColor.init(red: 1.0, green: 0.96, blue: 0.89, alpha: 1.0)))
                            .listRowBackground(Color.clear)
                            
                        
                   }.listStyle(SidebarListStyle())
                    
                    Button(" See Recipes "){
                        convert(arrayList: usedWords)
                        input.Query = properQuery
                        
                        self.isReadyToNextView = true
                    }
                        .foregroundColor(.white)
                        //.padding(.vertical, 10.0)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                        .padding(EdgeInsets(top: 0, leading: 2, bottom: 40, trailing: 5))
                
                
                    //Text("\(ingredient)").padding()
                
                
                }
                
                
    
            }
            .background(Image("logo").opacity(0.3))
            .background(Color(UIColor.init(red: 1.0, green: 0.96, blue: 0.89, alpha: 1.0)))
            .navigationBarTitle("Recipe Garage",displayMode: .inline)
            .navigationBarItems(
                leading: leadingButton,
                trailing: Button(action: { self.showModal = true}) {Image(systemName:"camera")})
            .sheet(isPresented: self.$showModal){
                NavigationView{
                    VStack{
                        VStack{
                            NavigationLink(destination: Imagepicker(show: $imagepicker, image: $imageData, source: source), isActive: $imagepicker) {
                                
                                Text("")
                            }
                            
                            
                            
                            
                            Button(action: { self.show.toggle()}) {Image(systemName: "plus.circle.fill")}
                                .padding()
                                .frame(width: 50.0, height: 30.0)
                                .foregroundColor(.orange)
                                .background(Capsule().fill(Color("AccentColor")))
            
                            }
                            .navigationBarTitle("Photo Choose", displayMode: .inline)
                            .navigationBarHidden(true)
                            .padding(10)
                            .background(Color.white)
                            .cornerRadius(5)
                            .actionSheet(isPresented: $show){
                                ActionSheet(title: Text("Select A Type"), message: Text(""),
                                            buttons: [.default(Text("Upload"), action: {
                                                self.source = .photoLibrary
                                                self.imagepicker.toggle()
                                            }),.default(Text("Take A Picture"), action: {
                                                self.source = .camera
                                                self.imagepicker.toggle()
                                            }),.cancel()])}
                        
                        if imageData.count != 0{
                            Image(uiImage: UIImage(data: self.imageData)!)
                                .resizable()
                                .frame(width: 300, height: 300)
                                .cornerRadius(15)
                            
                            Button("Recognition This Ingredient") {
                                
                                guard let CIimage = CIImage(image: UIImage(data: self.imageData)!) else{
                                    fatalError("Could not convert the UIimage into CIimage!")
                                }
                                res = detect(image: CIimage)
                                //self.performImageClassification()
                                print(res)
                                
                                
                            }
                            .padding()
                            .foregroundColor(Color(UIColor.white))
                            .background(Color(UIColor.orange))
                            .cornerRadius(5)
     
                        }
                        
                        NavigationLink(destination: WebViewPage(request: URLRequest(url: URL(string: "https://www.google.com/search?q=" + res)!))){
                            Text(res)
                        }
                        
                        
                    }
                }
            }
        }
    }
    
    
    func detect(image: CIImage) -> String{
        
        var ingredientName = ""
        
        guard let model = try? VNCoreMLModel(for: MyImageClassifier_1().model) else{
            fatalError("Loading CoreML Model failed!")
        }
    
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else{
                fatalError("Model failed to process message")
            }
            
            print(results)
            print("1111111111")
  
            if let firstResult = results.first{
                if firstResult.identifier.contains("Laoganma"){
                    
                    ingredientName = "Laoganma"
                    //self.navigationItem.title = "Laoganma"
                    //self.urlString = "Laoganma"
                    //self.searchTextOnGoogle(self.urlString)
                   
                }else if firstResult.identifier.contains("Zhimajiang"){
                    ingredientName = "Zhimajiang"
                }else if firstResult.identifier.contains("Zhen Jiang Xiang Cu"){
                    ingredientName = "ZhenJiangXiangCu"
                }else if firstResult.identifier.contains("Jiu Hua Jiang"){
                    ingredientName = "JiuHuaJiang"
                }
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do{
            try handler.perform([request])
        }
        catch {
            print(error)
        }
        
        return ingredientName
    }
    
    
    func delete(at offsets: IndexSet) {
        usedWords.remove(atOffsets: offsets)
    }
    
    func addNewWord() {
        // lowercase and trim the word, to make sure we don't add duplicate words with case differences
        let answer = ingredient.lowercased()
            //.trimmingCharacters(in: .whitespacesAndNewlines)

        // exit if the remaining string is empty
        guard answer.count > 0 else {return}

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

struct WebViewPage : UIViewRepresentable {
    let request: URLRequest
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
        uiView.load(request)
    }
}

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

struct Imagepicker : UIViewControllerRepresentable {
    
    func makeCoordinator() -> Imagepicker.Coordinator {
        return Imagepicker.Coordinator(parent1: self)
    }
    
    @Binding var show : Bool
    @Binding var image : Data
    var source : UIImagePickerController.SourceType
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<Imagepicker>) -> UIImagePickerController {
        
        let controller = UIImagePickerController()
        controller.sourceType = source
        controller.delegate = context.coordinator
        return controller
        
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<Imagepicker>) {
        
    }
    
    
    class Coordinator : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        
        var parent : Imagepicker
        
        init(parent1: Imagepicker) {
            
            parent = parent1
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.parent.show.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            let image = info[.originalImage] as! UIImage
            let data = image.pngData()
            self.parent.image = data!
            self.parent.show.toggle()
            
            
        }
    }
    
}

