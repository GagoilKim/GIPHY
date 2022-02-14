//
//  MyPageView.swift
//  GIPHYApp
//
//  Created by Kyle Kim on 2022/02/13.
//

import SwiftUI

struct MyPageView: View {
    @StateObject private var viewModel = ViewModel()
    @State var isFullScreen : Bool = false
    var body: some View {
        NavigationView{
            VStack{
                Text("MyPage")
                ScrollView{
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
            .navigationBarHidden(true)
            .onAppear(perform: {
                viewModel.getFavoriteData()
                resetStatus()
            })
          
        }
    }
    private func resetStatus() {
        self.isFullScreen = false
        viewModel.imageSelectStatus = .notSelected
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}

extension MyPageView {
    final class ViewModel: ObservableObject {
        @Published var imageAddressList : [String] = []
        @Published var imageSelectStatus : ImageSelectStatus = .notSelected
        @Published var selectedIndex : Int = 0
        
        let userDefaults = UserDefaults.standard
        
        func getFavoriteData() {
            if let data =  userDefaults.value(forKey: UserDefaultsConstants.favoriteImageKey) as? [String] {
                imageAddressList = data
                print(imageAddressList)
            }
        }
        
    }
}
