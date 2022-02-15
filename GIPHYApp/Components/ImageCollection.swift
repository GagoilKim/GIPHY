//
//  ImageCollection.swift
//  GIPHYApp
//
//  Created by Kyle Kim on 2022/02/13.
//

import SwiftUI

struct ImageCollection: View {
    @Binding var imageAddressList : [String]
    @Binding var imageSelectStatus : ImageSelectStatus
    @Binding var selectedIndex : Int
    
    var body: some View {
        HStack(alignment: .top){
            VStack{
                ForEach(imageAddressList.indices, id: \.self) { index in
                    if index % 2 == 0 {
                        URLImage(urlAddress: imageAddressList[index])
                            .frame(width: UIScreen.main.bounds.width / 2)
                            .onTapGesture {
                                imageSelectStatus = .selected
                                selectedIndex = index
                            }
                    }
                }
            }
            Spacer()
            VStack{
                ForEach(imageAddressList.indices, id: \.self) { index in
                    if index % 2 == 1 {
                        URLImage(urlAddress: imageAddressList[index])
                            .frame(width: UIScreen.main.bounds.width / 2)
                            .onTapGesture{
                                imageSelectStatus = .selected
                                selectedIndex = index
                            }
                    }
                }
            }
        }
    }
}

struct ImageCollection_Previews: PreviewProvider {
    static var previews: some View {
        ImageCollection(imageAddressList: .constant([]), imageSelectStatus: .constant(.notSelected), selectedIndex: .constant(1))
    }
}
