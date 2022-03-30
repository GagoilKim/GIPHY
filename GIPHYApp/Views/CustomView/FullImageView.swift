//
//  FullImageView.swift
//  GIPHYApp
//
//  Created by KyleKim on 2022/02/14.
//

import SwiftUI
import Kingfisher

struct FullImageView: View {
    @State  var imageAddress : String
    @State private var isFavorite : Bool = false
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack{
            if let url = URL(string: imageAddress){
                KFAnimatedImage(url)
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width)
            } else {
                EmptyView()
            }
            
            Button(action:  {
                isFavorite.toggle()
                viewModel.clickFavorite(imageAddress: imageAddress)
            }){
                Image(systemName: isFavorite ? "star.fill" : "star")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color.yellow)
            }
            Spacer()
        }
        .background(.black)
        .onAppear(perform: {
            isFavorite = viewModel.checkFavoriteData(imageAddress: imageAddress)
        })
    }
}

struct FullImageView_Previews: PreviewProvider {
    static var previews: some View {
        FullImageView(imageAddress: "")
    }
}

extension FullImageView {
    final class ViewModel: ObservableObject {
        let userDefaults = UserDefaults.standard
        
        func checkFavoriteData(imageAddress: String) -> Bool {
            if let data =  userDefaults.value(forKey: UserDefaultsConstants.favoriteImageKey) as? [String] {
              return data.contains(imageAddress)
            }
            return false
        }
        
        func clickFavorite(imageAddress : String) {
            if let data =  userDefaults.value(forKey: UserDefaultsConstants.favoriteImageKey) as? [String] {
                    var updatedData = data
                    if updatedData.contains(imageAddress) {
                        updatedData = updatedData.filter{ $0 != imageAddress }
                    } else {
                        updatedData.append(imageAddress)
                    }
                    userDefaults.set(updatedData, forKey: UserDefaultsConstants.favoriteImageKey)
            } else {
                let newFavoriteData : [String] = [imageAddress]
                userDefaults.set(newFavoriteData, forKey: UserDefaultsConstants.favoriteImageKey)
            }
            print("Clicked favorite button")
        }
    }
}
