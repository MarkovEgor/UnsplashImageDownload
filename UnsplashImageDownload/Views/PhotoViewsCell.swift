


import UIKit
import SDWebImage

class PhotoViewsCell: UICollectionViewCell {
    
    static let reuseID = "PhotoViewsCell"
    

    
     let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
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
    
 
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        setupImagePhoto()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupImagePhoto() {
        addSubview(photoImageView)
        photoImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        photoImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
    }
    
    
}
