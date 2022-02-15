//
//  PhotoView.swift
//  UnsplashImageDownload
//
//  Created by Egor Markov on 2/15/22.
//



import UIKit
import SDWebImage

class PhotoView: UIViewController {
    
    
    
    let photoImageView: UIImageView = {
       let imageView = UIImageView()
       imageView.translatesAutoresizingMaskIntoConstraints = false
       imageView.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
       imageView.contentMode = .scaleToFill
       imageView.layer.cornerRadius = 10
       imageView.clipsToBounds = true
       return imageView
   }()
    
    var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Author unknown"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
   
    
    var unsplashPhoto: UnsplashPhooto! {
        didSet {
           let photoUrl = unsplashPhoto.urls["thumb"]
            guard let urlImage = photoUrl, let url = URL(string: urlImage) else {
                return
            }
            
            photoImageView.sd_setImage(with: url, completed: nil)
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel.text = "Author - " + unsplashPhoto.user.username
        setupImagePhoto()
    }

    
    private func setupImagePhoto() {
        
        view.addSubview(photoImageView)
        view.addSubview(textLabel)
        photoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        photoImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        textLabel.topAnchor.constraint(equalTo: photoImageView.topAnchor, constant: 20).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: -20).isActive = true
        
    }
    
}
