//
//  URLImage.swift
//  GIPHYApp
//
//  Created by Kyle Kim on 2022/02/15.
//

import SwiftUI
import Combine

struct URLImage: View {
    @StateObject private var viewModel = ViewModel()
    let urlAddress : String
    
    var body: some View {
        Group{
            if let data = viewModel.imageData, let uiImage = UIImage(data: data){
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            } else {
                Text("Loading...")
            }
        }
        .onAppear{
            viewModel.loadImage(urlAddress: urlAddress)
        }
    }
}

struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        URLImage(urlAddress: "")
    }
}

extension URLImage{
    final class ViewModel: ObservableObject {
        @Published var imageData : Data?
        
        private var cancellable = Set<AnyCancellable>()
        private let cache = NSCache<NSString, NSData>()
        
        func loadImage(urlAddress: String){
            guard let url = URL(string: urlAddress) else {
                return
            }
            
            if let cachedData = cache.object(forKey: urlAddress as NSString){
                imageData = cachedData as Data
            } else {
                URLSession.shared.dataTaskPublisher(for: url)
                    .map{ $0.data }
                    .replaceError(with: nil)
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] in
                        guard let self = self else { return }
                        if let data = $0 {
                            self.imageData = data
                            self.cache.setObject(data as NSData, forKey: urlAddress as NSString)
                        }
                    }.store(in: &cancellable)
            }
        }
        
        
    }
}
