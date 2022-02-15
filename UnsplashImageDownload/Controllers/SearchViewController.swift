


import UIKit

class SearchViewController: UIViewController {
    

    //MARK: - Var
    
   
    
    private var searchTextField: UITextField = {
        let searchTextField =  UITextField()
        searchTextField.placeholder = "Поиск...."
        searchTextField.attributedPlaceholder = NSAttributedString(string: searchTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        searchTextField.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        searchTextField.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        searchTextField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
        searchTextField.layer.cornerRadius = 10
        searchTextField.setLeftPaddingPoints(20)
        searchTextField.clearButtonMode = .always
       
        
        return searchTextField
        
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
        searchTextField.delegate = self
        setupNavigationBar()
        searchTextFieldSetup()
        searchButton()
        
    }
    

    private func setupNavigationBar() {
        let label = UILabel()
        label.text = "Поиск изображения"
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "", size: 45)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = label.text
        
    }
    
    func searchTextFieldSetup() {
      
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(searchTextField)
        searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        searchTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
   
    }
    
    func searchButton() {
        let searchButton =  UIButton()
        searchButton.setTitle("Найти", for: .normal)
        searchButton.setTitleColor(.black, for: .normal)
        searchButton.backgroundColor = .white
        searchButton.layer.cornerRadius = 10
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(searchButton)
        searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80).isActive = true
        searchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        searchButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        
    }
    
   



    @objc func buttonTapped(sender: UIButton) {
        
        guard let searchTextField = searchTextField.text else {
            return
        }
        if !searchTextField.isEmpty {
            let imageController = ImageCollectionViewController()
            imageController.searchText = searchTextField
            navigationController?.pushViewController(imageController, animated: true)
        }
    }
    
}

extension SearchViewController: UISearchTextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.text != "" {
            let imageController = ImageCollectionViewController()
            imageController.searchText = textField.text
            navigationController?.pushViewController(imageController, animated: true)
            return true
        }
        
        return false
    }
}


extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
