//
//  SearchBar.swift
//  GIPHYApp
//
//  Created by Kyle Kim on 2022/02/14.
//

import SwiftUI

struct SearchBar: View {
    @State var keyword : String = ""
    @Binding var searchType : SearchType
    
    var body: some View {
        VStack{
            HStack{
                TextField("Search GIPHY", text: $keyword)
                Spacer()
                NavigationLink(destination: SearchResultView(keyword: keyword, searchType: $searchType)) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.black)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            HStack{
                Spacer()
                Text("GIFs")
                    .foregroundColor(searchType.gifsTextColor)
                    .background{
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 100, height: 30)
                            .foregroundColor(searchType.gifsBackColor)
                    }
                    .onTapGesture {
                        searchType = .GIFs
                    }
                Spacer()
                Text("Stickers")
                    .foregroundColor(searchType.stickerTextColor)
                    .background{
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 100, height: 30)
                            .foregroundColor(searchType.stickerBackColor)
                    }
                    .onTapGesture {
                        searchType = .Stickers
                    }
                Spacer()
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchType: .constant(.Stickers))
    }
}
