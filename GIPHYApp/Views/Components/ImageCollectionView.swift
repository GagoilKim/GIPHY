//
//  ImageCollectionView.swift
//  GIPHYApp
//
//  Created by Kyle Kim on 2022/02/13.
//

import SwiftUI
import Kingfisher

struct ImageCollectionView: View {
    @Binding var imageAddressList : [String]
    @Binding var imageSelectStatus : ImageSelectStatus
    @Binding var selectedIndex : Int
    
    var body: some View {
        HStack(alignment: .top){
            VStack{
                ForEach(imageAddressList.indices, id: \.self) { index in
                    if index % 2 == 1 {
                        if let imageAddress = imageAddressList[index] {
                            KFImage(URL(string: imageAddress))
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width / 2)
                                .onTapGesture {
                                    imageSelectStatus = .selected
                                    selectedIndex = index
                                }
                        }else {
                            ProgressView()
                                .progressViewStyle(.circular)
//                            EmptyView()
                        }
                    }
                }
            }
            Spacer()
            VStack{
                ForEach(imageAddressList.indices, id: \.self) { index in
                    if index % 2 == 0 {
                        if let imageAddress = imageAddressList[index] {
                            KFImage(URL(string: imageAddress))
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width / 2)
                                .onTapGesture {
                                    imageSelectStatus = .selected
                                    selectedIndex = index
                                }
                        }else {
                            EmptyView()
                        }
                    }
                }
            }
        }
    }
}

struct ImageCollection_Previews: PreviewProvider {
    static var previews: some View {
        ImageCollectionView(imageAddressList: .constant([]), imageSelectStatus: .constant(.notSelected), selectedIndex: .constant(1))
    }
}
