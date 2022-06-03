//
//  MainView.swift
//  Test Balink
//
//  Created by Давид Михайлов on 01.06.2022.
//

import UIKit

class MainView: UIViewController {

// MARK: - Properties
    private lazy var userListButton: UIButton = {
        let button = UIButton()
        button.setTitle("UserListButton", for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(retriveUserList), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        return button
    }()

    private var users: [User] = []

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
        let vc = UsersListPage(users: users)
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - OBJC methods
    @objc func retriveUserList() {
        guard let url = URL(string: "https://reqres.in/api/users") else { return }
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data,
                  let response = response else { return }
            print(response)
            print(data)

            do {
                let jsonData = try JSONDecoder().decode(Initial.self, from: data)
                let users = jsonData.data
                print(users)
                self.users = users
                DispatchQueue.main.async {
                    self.showUsersList()
                }

            } catch {
                print(String(describing: error))
            }
        }.resume()
    }
}

