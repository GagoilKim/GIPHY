//
//  ImageCollection.swift
//  GIPHYApp
//
//  Created by Kyle Kim on 2022/02/13.
//

import SwiftUI

struct ImageCollection: View {
    @Binding var imageObjectList : [DataObject]

    var body: some View {
        ScrollView {
            HStack(alignment: .top){
                VStack{
                    ForEach(imageObjectList.indices, id: \.self) { index in
                        if index % 2 == 0 {
                            Image(uiImage: imageObjectList[index].imagesList.originalStill.url.loadImage())
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width / 2)
                        }
                    }
                }
                VStack{
                    ForEach(imageObjectList.indices, id: \.self) { index in
                        if index % 2 == 1 {
                            Image(uiImage: imageObjectList[index].imagesList.originalStill.url.loadImage())
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width / 2)
                        }
                    }
                }
            }
        }    }
}

struct ImageCollection_Previews: PreviewProvider {
    static var previews: some View {
        ImageCollection(imageObjectList: .constant([]))
    }
}
