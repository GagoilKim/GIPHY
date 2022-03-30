//
//  SearchView.swift
//  GIPHYApp
//
//  Created by Kyle Kim on 2022/02/13.
//

import SwiftUI
import Combine

struct SearchView: View {
    @State private var isFullScreen : Bool = false
    @State var keyword : String = ""
    @State var searchType : SearchType = .GIFs
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                SearchBar( searchType: $searchType)
                    .padding(.bottom, 10)
                ScrollView{
                    HStack{
                        if !viewModel.trendSearchList.isEmpty {
                            VStack(alignment: .leading){
                                HStack{
                                    Image(systemName: "eye.circle")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.pink)
                                        .frame(height: 20, alignment: .center)
                                Text("Trending Searches")
                                    .bold()
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                }
                                ForEach(0..<(viewModel.trendSearchList.count/3), id: \.self) { value in
                                    TrendSearchRow(searchType: $searchType,
                                                   trendKeyword: viewModel.trendSearchList[value])
                                }
                            }
                            Spacer()
                        }
                    }
                    .padding(.leading, 20)
//                    RecentSearchRow(searchType: $searchType)
                    HStack{
                        Image(systemName: "arrow.turn.right.up")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.blue)
                            .frame(height: 20, alignment: .center)
                        Text("Trending")
                            .bold()
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.leading, 20)
                    
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
            .navigationBarBackButtonHidden(true)
            .navigationTitle(Text("Search"))
            .foregroundColor(.white)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                resetStatus()
                viewModel.getTrendingImages()
                //                viewModel.getTrendingSearch()
                viewModel.getTrendingSearch2()
            })
        }
        .edgesIgnoringSafeArea(.bottom)
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


extension SearchView {
    final class ViewModel: ObservableObject {
        @Published var imageAddressList : [String] = []
        @Published var imageSelectStatus : ImageSelectStatus = .notSelected
        @Published var selectedIndex : Int = 0
        @Published var trendSearchList : [String] = []
        @Published var isTrendSearch : Bool = false
        
        var cancellable = Set<AnyCancellable>()
        
        let giphyApiService : GiphyApiServiceProtocol
        
        init(service: GiphyApiServiceProtocol = GiphyApiService()){
            giphyApiService = service
        }
        
        
        func getTrendingSearch2() {
            giphyApiService.getTrendingSearch2()
                .sink(receiveCompletion: { result in
                    switch result {
                    case let .failure(error):
                        print(error)
                    case .finished:
                        break
                    }
                }, receiveValue: { value in
                    print("printed here")
                    self.trendSearchList = value
                    print(self.trendSearchList)
                })
                .store(in: &cancellable)
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
