//
//  ViewController.swift
//  Flash chat
//
//  Created by Artur Imanbaev on 14.03.2023.
//

import UIKit
import FirebaseAuth
import FirebaseCore
class LoginViewController: UIViewController {

    let emailView = textFieldView("Email")
    let passwordView = textFieldView("Password")
    let loginButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleToFill
        $0.setTitle("Log In", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 30)
        $0.setTitleColor(UIColor(named:"BrandLightBlue"), for: .normal)
        return $0
    }(UIButton())
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BrandBlue")
        setupUI()
        loginButtonTapped()
    }
    func loginButtonTapped(){
        loginButton.addTarget(self, action: #selector(authTriggered), for: .touchUpInside)
    }
    @objc
    private func authTriggered(){
        if let email = emailView.textField.text, let password = passwordView.textField.text{
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard self != nil else { return }
                if let err = error{
                    print(err)
                } else{
                    self?.navigationController?.pushViewController(ChatViewController(), animated: true)
                }
            }
        }
    }
}
extension LoginViewController{
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
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalToSystemSpacingBelow: passwordView.bottomAnchor, multiplier: 2),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),

        ])
    }
}
