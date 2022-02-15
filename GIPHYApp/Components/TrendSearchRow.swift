//
//  TrendSearchRow.swift
//  GIPHYApp
//
//  Created by Kyle Kim on 2022/02/14.
//

import SwiftUI

struct TrendSearchRow: View {
    @Binding var searchType : SearchType

    let trendKeyword: String
    
    var body: some View {
        NavigationLink(destination: SearchResultView(keyword: trendKeyword, searchType: $searchType)){
            HStack{
                Image(systemName: "arrow.up.forward.app")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10, height: 10)
                    .foregroundColor(Color.blue)
                Text(trendKeyword)
                Spacer()
            }
        }
    }
}

struct TrendSearchRow_Previews: PreviewProvider {
    static var previews: some View {
        TrendSearchRow( searchType: .constant(.GIFs), trendKeyword: "")
    }
}
