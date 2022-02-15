//
//  RecentSearchRow.swift
//  GIPHYApp
//
//  Created by Kyle Kim on 2022/02/15.
//

import SwiftUI

struct RecentSearchRow: View {
    @StateObject private var viewModel = ViewModel()
    @Binding var searchType : SearchType
    
    var body: some View {
        VStack{
            HStack{
                Text("Recent Searches")
                    .bold()
                Spacer()
            }
            .isHidden(viewModel.recentSearchWords.isEmpty)
            ScrollView(.horizontal){
                HStack{
                    ForEach(viewModel.recentSearchWords.indices, id: \.self) { index in
                        NavigationLink(destination: SearchResultView(keyword: viewModel.recentSearchWords[index], searchType: $searchType)){
                            Text(viewModel.recentSearchWords[index])
                                .background(
                                    RoundedRectangle(cornerRadius: 25)
                                        .frame(height: 20)
                                        .foregroundColor(.gray))
                        }
                    }
                }
            }
        }
        .padding(.leading, 20)
        .onAppear{
            viewModel.getRecentSearchedWords()
        }
    }
}

struct RecentSearchRow_Previews: PreviewProvider {
    static var previews: some View {
        RecentSearchRow(searchType: .constant(.GIFs))
    }
}

extension RecentSearchRow {
    final class ViewModel: ObservableObject {
        @Published var recentSearchWords : [String] = []
        
        let userDefaults = UserDefaults.standard
        
        func getRecentSearchedWords() {
            if let data =  userDefaults.value(forKey: UserDefaultsConstants.searchedWordKey) as? [String] {
                recentSearchWords = data
                print(recentSearchWords)
            }
        }
        
    }
}
