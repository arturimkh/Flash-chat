//
//  ChatTableViewCell.swift
//  Flash chat
//
//  Created by Artur Imanbaev on 18.03.2023.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    let avatarImage: UIImageView = {
        $0.image = UIImage(named: "MeAvatar")
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    let youAvatarImage: UIImageView = {
        $0.image = UIImage(named: "YouAvatar")
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    let cellView: UIView = {
        $0.backgroundColor = UIColor(named: "BrandPurple")
        $0.layer.cornerRadius = 10
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    let cellText: UILabel = {
        $0.textAlignment = .left
        $0.text = ""
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        addSubview(avatarImage)
        NSLayoutConstraint.activate([
            avatarImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.trailingAnchor.constraint(equalToSystemSpacingAfter: avatarImage.trailingAnchor, multiplier: 3)
        ])
        addSubview(youAvatarImage)
        NSLayoutConstraint.activate([
            youAvatarImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            youAvatarImage.leadingAnchor.constraint(equalToSystemSpacingAfter: self.contentView.leadingAnchor, multiplier: 3)
        ])
        addSubview(cellView)
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            cellView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            cellView.trailingAnchor.constraint(equalTo: avatarImage.leadingAnchor),
            cellView.leadingAnchor.constraint(equalTo: youAvatarImage.trailingAnchor),
        ])
        cellView.addSubview(cellText)
        NSLayoutConstraint.activate([
            cellText.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            cellText.leadingAnchor.constraint(equalToSystemSpacingAfter: cellView.leadingAnchor, multiplier: 5),
            cellView.trailingAnchor.constraint(equalToSystemSpacingAfter: cellText.trailingAnchor, multiplier: 3),
        ])
    }
}
