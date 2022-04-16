//
//  SearchResultView.swift
//  GIPHYApp
//
//  Created by Kyle Kim on 2022/02/14.
//

import SwiftUI

struct SearchResultView: View {
    @State var keyword: String
    @Binding var searchType : SearchType
    
    @State private var isFullScreen : Bool = false
    @StateObject private var viewModel = ViewModel()
    var body: some View {
        VStack{
            SearchBar(keyword: $keyword, searchType: $searchType)
            ScrollView{
                ImageCollectionView(imageAddressList: $viewModel.imageAddressList,
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
            }
            if !viewModel.imageAddressList.isEmpty {
                NavigationLink( destination:
                                    FullImageView(imageAddress:
                                                    viewModel.imageAddressList[viewModel.selectedIndex]),
                                isActive: $isFullScreen) {
                    EmptyView()
                }
            }
        }
        .background(.black)
        .onAppear(perform: {
            switch searchType {
            case .GIFs:
                viewModel.searchImages(keyword: keyword)
            case .Stickers:
                viewModel.searchStickers(keyword: keyword)
            }
            viewModel.getRecentSearchedWords(keyword: keyword)
        })
        .navigationTitle(Text(keyword))
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(keyword: "Something", searchType: .constant(.Stickers))
    }
}


extension SearchResultView {
    final class ViewModel: ObservableObject {
        @Published var imageAddressList : [String] = []
        @Published var imageSelectStatus : ImageSelectStatus = .notSelected
        @Published var selectedIndex : Int = 0
        
        let userDefaults = UserDefaults.standard
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
        
        func searchStickers(keyword: String) {
            giphyApiService.searchStickers(keyword: keyword){ [weak self] result in
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
        
        func getRecentSearchedWords(keyword: String) {
            if let data =  userDefaults.value(forKey: UserDefaultsConstants.searchedWordKey) as? [String] {
                var searchedWords = data
                searchedWords.append(keyword)
                userDefaults.set(searchedWords, forKey: UserDefaultsConstants.searchedWordKey)
            } else {
                userDefaults.set([keyword], forKey: UserDefaultsConstants.searchedWordKey)
            }
        }
    }
}
