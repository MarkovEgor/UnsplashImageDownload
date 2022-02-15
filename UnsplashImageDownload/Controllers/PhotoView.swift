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
        imageView.contentMode = .scaleAspectFit
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
    
    
    var shareButton: UIButton = {
        let button =  UIButton()
        button.setTitle("Share", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(shareButtonAll(sender:)), for: .touchUpInside)
        return button
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
        view.addSubview(shareButton)
        photoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        photoImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        textLabel.topAnchor.constraint(equalTo: photoImageView.topAnchor, constant: 20).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: -20).isActive = true
        
        shareButton.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor, constant: 80).isActive = true
        shareButton.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: -80).isActive = true
        shareButton.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: -40).isActive = true
        
        
    }
    
    
    @objc func shareButtonAll(sender: UIButton) {
        let text = "Author - " + unsplashPhoto.user.username
        
        let photoUrl = unsplashPhoto.urls["thumb"]
        guard let urlImage = photoUrl, let url = URL(string: urlImage) else {
            return
        }
        
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    let shareAll = [text , image] as [Any]
                    let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
                    activityViewController.popoverPresentationController?.sourceView = self.view
                    self.present(activityViewController, animated: true, completion: nil)
                }
            }
        }
        
        
    }
    
}
