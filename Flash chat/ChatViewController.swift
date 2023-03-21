//
//  ChatViewController.swift
//  Flash chat
//
//  Created by Artur Imanbaev on 16.03.2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
final class ChatViewController: UIViewController {

    let chatTableView = UITableView()
    fileprivate let cellId = "id"
    let db = Firestore.firestore()
    var messages: [Message] = []
    private let chatField: UITextField = {
        $0.borderStyle = .roundedRect
        $0.placeholder = "Write a message"
        $0.textAlignment = .left
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    private let sendButton: UIButton = {
        $0.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        $0.addTarget(self, action: #selector(sendTrigerred), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    private let logoutButton: UIButton = {
        $0.setTitle("Logout", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(logoutTrigerred), for: .touchUpInside)
        return $0
    }(UIButton())
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        loadMessages()
    }
    private func loadMessages(){
        messages = []
        db
            .collection("messages")
            .order(by: "date")
            .addSnapshotListener() { querySnapshot, error in
            self.messages = []

            if let e = error{
                print("there was issue, \(e)")
            } else{
                if let snapshotDocuments = querySnapshot?.documents{
                    for doc in snapshotDocuments{
                        let data = doc.data()
                        if let sender = data["sender"] as? String,
                            let messageBody = data["body"] as? String {
                            let newMessage = Message(sender: sender, body: messageBody)
                            self.messages.append(newMessage)
                            DispatchQueue.main.async {
                                self.chatTableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.chatTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    private func setupTableView(){
        chatTableView.register(ChatTableViewCell.self,forCellReuseIdentifier: cellId)
        chatTableView.dataSource = self
        chatTableView.separatorStyle = .none
    }
    @objc
    private func sendTrigerred(){
        if let messageBody = chatField.text, let messageSender = Auth.auth().currentUser?.email{
            db
                .collection("messages")
                .addDocument(data: [
                    "sender": messageSender,
                    "body": messageBody,
                    "date": Date().timeIntervalSince1970
                ]) { (error) in
                if let e = error{
                    print("there was issue, \(e)")
                } else{
                    print("succesfully saved your data")
                    DispatchQueue.main.async {
                        self.chatField.text = ""
                    }
                }
            }
        }
    }
    @objc
    private func logoutTrigerred(){
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
extension ChatViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatTableViewCell
        cell.selectionStyle = .none
        cell.cellText.text = message.body

        if message.sender == Auth.auth().currentUser?.email{
            cell.youAvatarImage.isHidden = true
            cell.avatarImage.isHidden = false
            cell.cellView.backgroundColor = UIColor(named: "BrandLightPurple")
            cell.cellText.textColor = UIColor(named: "BrandPurple")
        } else{
            cell.youAvatarImage.isHidden = false
            cell.avatarImage.isHidden = true
            cell.cellView.backgroundColor = UIColor(named: "BrandPurple")
            cell.cellText.textColor = UIColor(named: "BrandLightPurple")
        }
            
        return cell
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if(indexPath.row == 1){
//            return 200
//        }
//        return 50
//    }
}
extension ChatViewController{
    func setupUI(){
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor(named: "BrandPurple")
        chatTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chatTableView)
        NSLayoutConstraint.activate([
            chatTableView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 13),
            chatTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chatTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: chatTableView.bottomAnchor, multiplier: 15)
        ])
        view.addSubview(chatField)
        NSLayoutConstraint.activate([
            chatField.topAnchor.constraint(equalToSystemSpacingBelow: chatTableView.bottomAnchor, multiplier:2),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: chatField.bottomAnchor, multiplier: 8),
            chatField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: chatField.trailingAnchor, multiplier: 10)
        ])
        view.addSubview(sendButton)
        NSLayoutConstraint.activate([
            sendButton.centerYAnchor.constraint(equalTo: chatField.centerYAnchor),
            sendButton.leadingAnchor.constraint(equalToSystemSpacingAfter: chatField.trailingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: sendButton.trailingAnchor, multiplier: 2)
        ])
        view.addSubview(logoutButton)
        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: logoutButton.trailingAnchor, multiplier: 4)
        ])
    }
}
