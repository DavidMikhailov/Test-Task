//
//  MainView.swift
//  Test Balink
//
//  Created by Давид Михайлов on 01.06.2022.
//

import UIKit

class MainView: UIViewController {

    // MARK: - Properties
    let dataManager: DataManager = CoreDataManager.shared
    let usersApi: UsersApiProtocol = UsersApi()
    
    private lazy var userListButton: UIButton = {
        let button = UIButton()
        button.setTitle("UserListButton", for: .normal)
        button.backgroundColor = .systemRed
        button.addTarget(self, action: #selector(retriveUserList), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        return button
    }()

    private lazy var showPopUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show Pop Up", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(showPopUp), for: .touchUpInside)
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
        view.addSubview(showPopUpButton)

        NSLayoutConstraint.activate([
            userListButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            userListButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userListButton.heightAnchor.constraint(equalToConstant: 50),
            userListButton.widthAnchor.constraint(equalToConstant: 150)
        ])

        NSLayoutConstraint.activate([
            showPopUpButton.topAnchor.constraint(equalTo: userListButton.bottomAnchor, constant: 40),
            showPopUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showPopUpButton.heightAnchor.constraint(equalToConstant: 50),
            showPopUpButton.widthAnchor.constraint(equalToConstant: 150)
        ])
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

        usersApi.getUsers { [weak self] users in
            guard let users = users else {
                return
            }
            self?.dataManager.save(model: users)
            self?.showUsersList()
        }
    }

    @objc func showPopUp() {
        let vc = PopUpViewController()
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
}

