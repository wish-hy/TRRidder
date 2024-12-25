//
//  TRImagePreviewController.swift
//  NewTrade_Seller
//
//  Created by admin on 2024/12/5.
//

import UIKit
import QuickLook
import SDWebImage

class TRImagePreviewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var images: [Any] = []
    private var currentIndex: Int = 0

    init(images: [Any], currentIndex: Int = 0) {
          super.init(nibName: nil, bundle: nil)
          self.images = images
          self.currentIndex = currentIndex
      }

      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }

      override func viewDidLoad() {
          super.viewDidLoad()
          view.backgroundColor = .black
          setupCollectionView()
      }

      private func setupCollectionView() {
          let layout = UICollectionViewFlowLayout()
          layout.itemSize = view.bounds.size
          layout.minimumLineSpacing = 0
          layout.minimumInteritemSpacing = 0
          layout.scrollDirection = .horizontal

          collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
          collectionView.backgroundColor = .clear
          collectionView.dataSource = self
          collectionView.delegate = self
          collectionView.isPagingEnabled = true
          collectionView.showsHorizontalScrollIndicator = false
          view.addSubview(collectionView)

          collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
      }
}

extension TRImagePreviewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
      let imageView = UIImageView(frame: cell.contentView.bounds)
      imageView.contentMode = .scaleAspectFit
      cell.contentView.addSubview(imageView)

        if let image = images[indexPath.item] as? UIImage {
           imageView.image = image
        } else if let url = images[indexPath.item] as? String {
            imageView.sd_setImage(with: URL(string: url), placeholderImage: nil)
       }
        
      return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension TRImagePreviewController: UICollectionViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
      let pageIndex = scrollView.contentOffset.x / view.bounds.width
      currentIndex = Int(pageIndex)
  }
}
