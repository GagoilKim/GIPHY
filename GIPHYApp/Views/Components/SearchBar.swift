//
//  SearchBar.swift
//  GIPHYApp
//
//  Created by Kyle Kim on 2022/02/14.
//

import SwiftUI

struct SearchBar: View {
    @Binding var keyword : String
    @Binding var searchType : SearchType
    
    var body: some View {
        VStack{
            HStack{
//                NavigationLink(destination: SearchResultView(keyword: keyword, searchType: $searchType)) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.white)
                        .background(Rectangle().foregroundColor(.purple).frame(width: 40, height: 40))
//                        .padding(.leading, 5)
//                }
              
                Spacer()
                TextField("Search GIPHY", text: $keyword)
                    .foregroundColor(.black)
                    .padding(.leading, 10)
            }
            .padding(.leading, 5)
            .background(Rectangle()
                        .frame(height: 40)
                            .foregroundColor(.white)
            )
            .padding(.bottom, 20)
            HStack{
                Spacer()
                Text("GIFs")
                    .foregroundColor(.white)
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
                    .foregroundColor(.white)
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
        SearchBar(keyword: .constant(""), searchType: .constant(.Stickers))
    }
}
