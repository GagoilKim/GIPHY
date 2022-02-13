//
//  ImageCollectionController.swift
//  GIPHYApp
//
//  Created by Kyle Kim on 2022/02/13.
//

import Foundation

import Foundation
import SwiftUI
import UIKit

struct ImageCollectionController: UIViewRepresentable {
    @Binding var imageObjectList : [DataObject]
//    @Binding var selectedIndex: Int?
//    @Binding var scrollStatus: ScrollStatus

    func makeUIView(context: Context) -> some UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.dataSource = context.coordinator
        view.delegate = context.coordinator
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")

        return view
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func updateUIView(_ uiView: UIViewType, context _: Context) {
        uiView.reloadData()
    }

    class Coordinator: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate {
        private let parent: ImageCollectionController

        init(_ collectionView: ImageCollectionController) {
            parent = collectionView
        }

        func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
            parent.imageObjectList.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
            DispatchQueue.global().async {
                if self.parent.imageObjectList.count > indexPath.row {
                    let url = URL(string: self.parent.imageObjectList[indexPath.row].imagesList.originalStill.url)
                    if let url = url, let data = try? Data(contentsOf: url) {
                        
                        DispatchQueue.main.async {
                            let image = UIImage(data: data)!
                            let imageView = UIImageView(image: image)
                            imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2)
                            imageView.contentMode = .scaleAspectFit
//
//                            let imageUI = Image(uiImage: self.parent.imageObjectList[indexPath.row].imagesList.originalStill.url.loadImage())
//                                .resizable().scaledToFit().frame(width: UIScreen.main.bounds.width / 2)
//
//                            let imageViewController = UIHostingController(rootView: imageUI)
//                            let testController = UIHostingController(rootView: TestView())
                            
                            
                            
//                            let button = UIButton(type: .custom)
//                            button.setImage(UIImage(data: data)!, for: .normal)
//                            button.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2)

//                            let uiAction = UIAction { _ in
//                                self.parent.selectedIndex = indexPath.row
//                            }
//                            button.addAction(uiAction, for: .touchUpInside)
                            cell.addSubview(imageView)
                        }
                    }
                }
            }
            return cell
        }

//        func scrollViewDidEndDecelerating(_: UIScrollView) {
//            parent.scrollStatus = .scrolled
//        }
    }
}
