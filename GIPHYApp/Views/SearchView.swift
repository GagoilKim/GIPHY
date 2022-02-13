//
//  SearchView.swift
//  GIPHYApp
//
//  Created by Kyle Kim on 2022/02/13.
//

import SwiftUI

struct SearchView: View {
    @State private var text : String = ""
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack{
            HStack{
                TextField("Type Something", text: $text)
                Spacer()
                Button(action: {
                    viewModel.searchImages(keyword: "Hello")
                }){
                    Image(systemName: "magnifyingglass")
                }
            }
            .padding()
            ImageCollection(imageObjectList: $viewModel.imageObjectList)
            Spacer()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

extension SearchView {
    final class ViewModel: ObservableObject {
        @Published var imageObjectList : [DataObject] = []
        
        let giphyApiService : GiphyApiServiceProtocol
        init(service: GiphyApiServiceProtocol = GiphyApiService()){
            giphyApiService = service
        }
        
        func searchImages(keyword: String) {
            giphyApiService.searchImages(keyword: keyword){ [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .success(data):
                    self.imageObjectList = data
                    print(self.imageObjectList.count)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
