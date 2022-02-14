//
//  SearchView.swift
//  GIPHYApp
//
//  Created by Kyle Kim on 2022/02/13.
//

import SwiftUI

struct SearchView: View {
    @State private var isFullScreen : Bool = false
    @State var keyword : String = ""
    @StateObject private var viewModel = ViewModel()
    @State var searchType : SearchType = .GIFs
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                SearchBar( searchType: $searchType)
                ScrollView{
                    HStack{
                        if !viewModel.trendSearchList.isEmpty {
                            VStack(alignment: .leading){
                                Text("Trending Searches")
                                    .bold()
                                ForEach(0..<(viewModel.trendSearchList.count/3), id: \.self) { value in
                                    TrendSearchRow(trendKeyword: viewModel.trendSearchList[value],
                                                   searchType: $searchType)
                                }
                            }
                            Spacer()
                        }
                    }
                    .padding(.leading, 20)
                    HStack{
                        Text("Most Popular Now")
                            .bold()
                        Spacer()
                    }
                    .padding(.leading, 20)
                    
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
            .navigationBarBackButtonHidden(true)
            .navigationTitle(Text("Search"))
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                resetStatus()
                viewModel.getTrendingImages()
                viewModel.getTrendingSearch()
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
        @Published var trendSearchList : [String] = []
        
        let giphyApiService : GiphyApiServiceProtocol
        init(service: GiphyApiServiceProtocol = GiphyApiService()){
            giphyApiService = service
        }
        
        func getTrendingImages() {
            giphyApiService.getTrendingImages { [weak self] result in
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
        
        func getTrendingSearch() {
            giphyApiService.getTrendingSearch { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .success(data):
                    self.trendSearchList = data
                    print(self.trendSearchList)
                case let .failure(error):
#if DEBUG
                    print(error.localizedDescription)
#endif
                }
            }
        }
    }
}
