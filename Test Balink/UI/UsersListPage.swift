//
//  UsersListPage.swift
//  Test Balink
//
//  Created by Давид Михайлов on 03.06.2022.
//

import Foundation
import UIKit

class UsersListPage: UIViewController {

    private let users: [User]

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UserCell.self, forCellWithReuseIdentifier: String(describing: UserCell.self))
        return collectionView
    }()

//     MARK: - Init
    init(users: [User]) {
        self.users = users
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        configureCollectionView()
    }

    func configureCollectionView() {
        view.backgroundColor = .white
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

    }
}

extension UsersListPage: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let users = self.users[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: UserCell.self), for: indexPath
        ) as? UserCell else {
            fatalError("DequeueReusableCell failed while casting")
        }
        cell.configureCell(userAvatar: users.avatar,
                           userName: users.first_name,
                           userEmail: users.email)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 80
        return CGSize(width: width, height: width)
    }
}
