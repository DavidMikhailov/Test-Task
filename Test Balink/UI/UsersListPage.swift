//
//  UsersListPage.swift
//  Test Balink
//
//  Created by Давид Михайлов on 03.06.2022.
//

import Foundation
import UIKit

class UsersListPage: UIViewController {

    let dataManager: DataManager = CoreDataManager.shared

    private var users: [User] = []

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

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.users = dataManager.fetch()

        collectionView.dataSource = self
        collectionView.delegate = self
        configureCollectionView()
    }

    func configureCollectionView() {
        view.backgroundColor = .systemBackground
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
                           userName: users.firstName + " " + users.lastName,
                           userEmail: users.email)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 80
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UserEditPage()
        vc.userId = users[indexPath.row].id
        vc.onSave = { [weak self] in
            self?.onSave()
        }
        vc.onClose = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        navigationController?.pushViewController(vc, animated: true)
    }

    private func onSave() {
        users = dataManager.fetch()
        collectionView.reloadData()
        navigationController?.popViewController(animated: true)
    }
}
