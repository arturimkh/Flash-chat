//
//  textFieldView.swift
//  Flash chat
//
//  Created by Artur Imanbaev on 14.03.2023.
//

import UIKit

class textFieldView: UIView {
    let imageField : UIImageView = {
        $0.image = UIImage(named: "textfield")
        $0.contentMode = .scaleToFill
        $0.isUserInteractionEnabled = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    let textField: UITextField = {
        $0.textAlignment = .center
        //$0.becomeFirstResponder()
        $0.font = .systemFont(ofSize: 24)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())

    convenience init(_ nameField: String){
        self.init()
        self.addCustomView()
        self.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "\(nameField)"
    }

    
    func addCustomView(){
        self.addSubview(imageField)
        NSLayoutConstraint.activate([
            imageField.topAnchor.constraint(equalTo: self.topAnchor),
            imageField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        imageField.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: imageField.topAnchor, constant: -25),
            textField.bottomAnchor.constraint(equalTo: imageField.bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: imageField.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: imageField.trailingAnchor)
        ])
    }

}
extension textFieldView: UITextFieldDelegate{
    
}
