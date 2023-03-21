//
//  ViewController.swift
//  Flash chat
//
//  Created by Artur Imanbaev on 14.03.2023.
//

import UIKit

class WelcomeViewController: UIViewController {

    let chatLabel: UILabel = {
        $0.text = ""
        $0.font = .boldSystemFont(ofSize: 60)
        $0.textColor = UIColor(named: "BrandBlue")
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    let registerButton: UIButton = {
        $0.backgroundColor = UIColor(named: "BrandLightBlue")
        $0.setTitle("Register", for: .normal)
        $0.setTitleColor(.systemTeal, for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    let loginButton: UIButton = {
        $0.backgroundColor = .systemTeal
        $0.setTitle("login", for: .normal)
        $0.setTitleColor(UIColor(named: "BrandLightBlue"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        addTargetToButtons()
        printWelcomeTitle()
    }
    func addTargetToButtons(){
        loginButton.addTarget(self, action: #selector(transitionViewController(sender:)), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(transitionViewController(sender:)), for: .touchUpInside)
    }
    func printWelcomeTitle(){
        let titleText = "⚡️FlashChat"
        var charIndex = 0.0
        for letter in titleText{
            Timer.scheduledTimer(withTimeInterval: 0.05 * charIndex, repeats: false) { (timer) in
                self.chatLabel.text?.append(letter)
            }
            charIndex+=1
        }
    }
    @objc
    private func transitionViewController(sender: UIButton){
        if(sender.currentTitle == "Register"){
            self.navigationController?.pushViewController(RegisterViewController(), animated: true)
        }
        else {
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        }
    }
}
extension WelcomeViewController{
    func setupUI(){
        view.addSubview(chatLabel)
        NSLayoutConstraint.activate([
            chatLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            chatLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        view.addSubview(registerButton)
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalToSystemSpacingBelow: chatLabel.bottomAnchor, multiplier: 20),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: registerButton.bottomAnchor, multiplier: 17),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalToSystemSpacingBelow: registerButton.bottomAnchor,multiplier: 1),
            loginButton.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 1),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

