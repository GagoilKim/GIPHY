//
//  SearchView.swift
//  GIPHYApp
//
//  Created by Kyle Kim on 2022/02/13.
//

import SwiftUI

struct SearchView: View {
    @State private var isFullScreen : Bool = false
    @State var text : String = ""
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    TextField("Type Something", text: $text)
                    Spacer()
                    Button(action: {
                        viewModel.searchImages(keyword: "Hello")
                    }){
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.black)
                    }
                }
                .padding()
                ImageCollection(imageAddressList: $viewModel.imageAddressList,
                                imageSelectStatus: $viewModel.imageSelectStatus,
                                selectedIndex: $viewModel.selectedIndex)
                    .onChange(of: viewModel.imageSelectStatus){ val in
                        switch viewModel.imageSelectStatus {
                        case .notSelected:
                            isFullScreen = false
                        case .selected:
                            isFullScreen = true
                        }
                    }
                Spacer()
                if !viewModel.imageAddressList.isEmpty {
                    NavigationLink( destination:
                                        FullImageView(imageAddress:
                                                        viewModel.imageAddressList[viewModel.selectedIndex]),
                                    isActive: $isFullScreen) {
                        EmptyView()
                    }
                }
            }
            .navigationBarHidden(true)
            .onAppear(perform: {
                resetStatus()
            })
        }
    }
    
    private func resetStatus() {
        self.isFullScreen = false
        viewModel.imageSelectStatus = .notSelected
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

enum ImageSelectStatus: Equatable {
    case selected
    case notSelected
}

extension SearchView {
    final class ViewModel: ObservableObject {
        @Published var imageAddressList : [String] = []
        @Published var imageSelectStatus : ImageSelectStatus = .notSelected
        @Published var selectedIndex : Int = 0
        
        let giphyApiService : GiphyApiServiceProtocol
        init(service: GiphyApiServiceProtocol = GiphyApiService()){
            giphyApiService = service
        }
        
        func searchImages(keyword: String) {
            giphyApiService.searchImages(keyword: keyword){ [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .success(data):
                    self.imageAddressList = data.map{ $0.imagesList.downSized.url }
                case let .failure(error):
                    #if DEBUG
                    print(error.localizedDescription)
                    #endif
                }
            }
        }
    }
}
