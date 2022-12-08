

import UIKit

final class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    var VM: LoginViewModelProtocol?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let loginTextField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email Address..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    private let passwordTextField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .systemGray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        VM = LoginViewModel()
        setupSubviews()
        setLayout()
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func setupSubviews() {
        view.addSubview(imageView)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
    }
    
    func setLayout() {
        view.frame = view.bounds
        let size = view.frame.size.width/3
        imageView.frame = CGRect(x: (view.frame.size.width - size)/2, y: 80, width: size, height: size)
        loginTextField.frame = CGRect(x: 30, y: imageView.frame.size.height + imageView.frame.origin.y + 60, width: view.frame.size.width-60, height: 52)
        passwordTextField.frame = CGRect(x: 30, y: loginTextField.frame.size.height + loginTextField.frame.origin.y + 10, width: view.frame.size.width-60, height: 52)
        loginButton.frame = CGRect(x: 30, y: passwordTextField.frame.size.height + passwordTextField.frame.origin.y + 10, width: view.frame.size.width-60, height: 52)
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Error", message: "Неверные данные", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    @objc private func signUpButtonTapped() {
        VM?.isAuth(login: loginTextField.text ?? "", password: passwordTextField.text ?? "", completion: { [weak self] result in
            switch result {
            case true:
                self?.VM?.showTableVC()
            case false:
                self?.showAlert()
            }
        })
    }
}

