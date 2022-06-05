//
//  MainView.swift
//  Test Balink
//
//  Created by Давид Михайлов on 01.06.2022.
//

import UIKit

import UIKit

class MainView: UIViewController {

    let dataManager: DataManager = CoreDataManager.shared
    let usersApi: UsersApiProtocol = UsersApi()

    // MARK: - Properties
    private lazy var userListButton: UIButton = {
        let button = UIButton()
        button.setTitle("UserListButton", for: .normal)
        button.backgroundColor = .systemRed
        button.addTarget(self, action: #selector(retriveUserList), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupElements()
    }

    // MARK: - Private function
    private func setupElements() {
        view.addSubview(userListButton)

        userListButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        userListButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userListButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        userListButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }

    func showUsersList() {
        let vc = UsersListPage()
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - OBJC methods
    @objc func retriveUserList() {
        guard self.dataManager.fetch().isEmpty else {
            showUsersList()
            return
        }

        usersApi.get { [weak self] users in
            guard let users = users else {
                return
            }
            self?.dataManager.save(model: users)
            self?.showUsersList()
        }
    }
}

