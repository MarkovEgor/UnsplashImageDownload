//
//  ImageCollectionViewController.swift
//  UnsplashImageDownload
//
//  Created by Egor Markov on 8/30/21.
//

import UIKit



class ImageCollectionViewController: UICollectionViewController {
    
    
    //MARK: - Var
    
    var networkDataFetcher = NetWorkDataFetcher()
 
    private var photos = [UnsplashPhooto]()
   
    var searchText: String!
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // иконок на одну сторону
    private let itemsPerRow: CGFloat = 2
    private let sectionInserts = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
        guard let searchText = searchText else {
            return
        }
        
        setupNavigationBar(text: searchText)
        
        networkDataFetcher.fetchImage(searchTerm: self.searchText) { [weak self] (searchResults) in
            guard let fechedPhoto = searchResults else { return }
            
            self?.photos = fechedPhoto.results
            self?.collectionView.reloadData()
        }
    
    }
    
    
    

//    MARK: - Setup Function UI Element
    
    private func setupCollectionView() {
        collectionView.register(PhotoViewsCell.self, forCellWithReuseIdentifier: PhotoViewsCell.reuseID)
        collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.contentInsetAdjustmentBehavior = .automatic
        collectionView.allowsMultipleSelection = true

    }
    
    private func setupNavigationBar(text: String) {
        let label = UILabel()
        label.text = text
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "", size: 45)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = label.text
        
    }
  
}


//MARK: - UICollectionView

extension ImageCollectionViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoViewsCell.reuseID, for: indexPath) as! PhotoViewsCell

        let photoUnsplas = photos[indexPath.item]
        cell.unsplashPhoto = photoUnsplas

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.item]
        let photoView = PhotoView()
        photoView.unsplashPhoto = photo
        navigationController?.pushViewController(photoView, animated: true)
      
    }


}


// MARK: - UICollectionViewDelegateFlowLayout

extension ImageCollectionViewController: UICollectionViewDelegateFlowLayout {

    //Функция по соотношению сторон фото определяется размер ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let photo = photos[indexPath.item]
        let paddingSpace = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let height = CGFloat(photo.height) * widthPerItem / CGFloat(photo.width)
        return CGSize(width: widthPerItem, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
}
