//
//  ViewController.swift
//  Flash chat
//
//  Created by Artur Imanbaev on 14.03.2023.
//

import UIKit
import FirebaseAuth
import FirebaseCore
class RegisterViewController: UIViewController {

    let emailView = textFieldView("Email")
    let passwordView = textFieldView("Password")
    let registerButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleToFill
        $0.setTitle("Register", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 30)
        $0.setTitleColor(UIColor(named:"BrandBlue"), for: .normal)
        return $0
    }(UIButton())
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BrandLightBlue")
        setupUI()
        registerButtonTapped()
    }
    func registerButtonTapped(){
        registerButton.addTarget(self, action: #selector(authTrigerred), for: .touchUpInside)
    }
    @objc
    private func authTrigerred(){
        if let email = emailView.textField.text, let password = passwordView.textField.text{
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let err = error{
                    print(err)
                } else{
                    self.navigationController?.pushViewController(ChatViewController(), animated: true)
                }
            }
        }
    }
}
extension RegisterViewController{
    func setupUI(){
        view.addSubview(emailView)
        NSLayoutConstraint.activate([
            emailView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 10),
            emailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        view.addSubview(passwordView)
        NSLayoutConstraint.activate([
            passwordView.topAnchor.constraint(equalToSystemSpacingBelow: emailView.bottomAnchor, multiplier: 0.10),
            passwordView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            passwordView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        view.addSubview(registerButton)
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalToSystemSpacingBelow: passwordView.bottomAnchor, multiplier: 2),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),

        ])
    }
}
