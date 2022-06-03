//
//  UserCell.swift
//  Test Balink
//
//  Created by Давид Михайлов on 03.06.2022.
//

import Foundation
import UIKit

class UserCell: UICollectionViewCell {
    // MARK: - Private properties

    private lazy var userImage: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center

        return label
    }()

    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()


    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.addSubviews()
            self.configureUI()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Layouts subviews

    private func addSubviews() {
        contentView.addSubview(userImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(emailLabel)
    }

    private func configureUI() {
        contentView.layer.cornerRadius = 5
        contentView.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        contentView.layer.borderWidth = 5
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white

        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            userImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            userImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            userImage.heightAnchor.constraint(equalToConstant: 60)
        ])

        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 8),
            nameLabel.heightAnchor.constraint(equalToConstant: 46),
            nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])


        NSLayoutConstraint.activate([
            emailLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            emailLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])

    }

    func configureCell(userAvatar: String, userName: String, userEmail: String) {
        userImage.image = UIImage(named: userAvatar)
        nameLabel.text = userName
        emailLabel.text = userEmail
    }
}
