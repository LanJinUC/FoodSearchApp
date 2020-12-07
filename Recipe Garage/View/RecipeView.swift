//
//  RecipeView.swift
//  FoodSearchApp
//
//  Created by Lan Jin on 2020-11-18.
//

import SwiftUI
import WebKit

struct RecipeView: View {
    @Binding var Query: String
    @ObservedObject var recipeAPI = RecipeAPI()
    
    var body: some View {
        
            Text("Here are the recipes contain \(Query)") .foregroundColor(.orange)

            List(recipeAPI.recipes) { post in
                NavigationLink(destination: DetailView(url: post.url)) {

                    HStack {
                        RemoteImage(url: post.image)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100)
                        Text(post.label).font(.system(size: 12.0))
                    }
                }
            } .onAppear {
                self.recipeAPI.fetchData(ingredients: Query)
            //.navigationBarTitle("Tour Location")

        }
       
    }
}

struct RemoteImage: View {
    private enum LoadState {
        case loading, success, failure
    }

    private class Loader: ObservableObject {
        var data = Data()
        var state = LoadState.loading

        init(url: String) {
            guard let parsedURL = URL(string: url) else {
                fatalError("Invalid URL: \(url)")
            }

            URLSession.shared.dataTask(with: parsedURL) { data, response, error in
                if let data = data, data.count > 0 {
                    self.data = data
                    self.state = .success
                } else {
                    self.state = .failure
                }

                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }.resume()
        }
    }

    @StateObject private var loader: Loader
    var loading: Image
    var failure: Image

    var body: some View {
        selectImage()
            .resizable()
    }

    init(url: String, loading: Image = Image(systemName: "photo"), failure: Image = Image(systemName: "multiply.circle")) {
        _loader = StateObject(wrappedValue: Loader(url: url))
        self.loading = loading
        self.failure = failure
    }

    private func selectImage() -> Image {
        switch loader.state {
        case .loading:
            return loading
        case .failure:
            return failure
        default:
            if let image = UIImage(data: loader.data) {
                return Image(uiImage: image)
            } else {
                return failure
            }
        }
    }
}

struct DetailView: View {
    
    let url: String?
    
    var body: some View {
        WebView(urlString: url)
    }
}

struct WebView: UIViewRepresentable {
    
    let urlString: String?
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let safeString = urlString {
            if let url = URL(string: safeString) {
                let request = URLRequest(url: url)
                uiView.load(request)
            }
        }
    }
    
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "www.google.com")
    }
}



#if DEBUG
struct RecipeView_Previews: PreviewProvider {
    @State static var someProperty = ""
    static var previews: some View {
        RecipeView(Query: $someProperty)
    }
}
#endif

