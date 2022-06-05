//
//  UserEditPage.swift
//  Test Balink
//
//  Created by Давид Михайлов on 03.06.2022.
//

import Foundation
import UIKit
import CoreData

class UserEditPage: UIViewController {
    
    // MARK: - Properties
    let dataManager: DataManager = CoreDataManager.shared
    var userId: Int = 0
    var onSave: () -> Void = {}
    var onClose: () -> Void = {}
    
    private lazy var firstNameTF: UITextField = {
        let firstNameTF = UITextField()
        firstNameTF.translatesAutoresizingMaskIntoConstraints = false
        firstNameTF.placeholder = " First name"
        firstNameTF.layer.borderWidth = 1
        firstNameTF.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        firstNameTF.layer.cornerRadius = 5
        return firstNameTF
    }()
    
    private lazy var lastNameTF: UITextField = {
        let lastNameTF = UITextField()
        lastNameTF.translatesAutoresizingMaskIntoConstraints = false
        lastNameTF.placeholder = " Last name"
        lastNameTF.layer.borderWidth = 1
        lastNameTF.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        lastNameTF.layer.cornerRadius = 5
        return lastNameTF
    }()
    
    private lazy var cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.backgroundColor = .systemRed
        cancelButton.tintColor = .white
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.layer.cornerRadius = 5
        cancelButton.addTarget(self, action: #selector(cancelAndReturn), for: .touchUpInside)
        return cancelButton
    }()
    
    private lazy var saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.backgroundColor = .systemGreen
        saveButton.tintColor = .white
        saveButton.setTitle("Save", for: .normal)
        saveButton.layer.cornerRadius = 5
        saveButton.addTarget(self, action: #selector(saveData), for: .touchUpInside)
        return saveButton
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = dataManager.get(by: userId) {
            firstNameTF.text = user.firstName
            lastNameTF.text = user.lastName
        }
        configureUI()
    }
    
    private func configureUI() {
        title = "Edit"
        view.backgroundColor = .systemBackground
        view.addSubview(firstNameTF)
        view.addSubview(lastNameTF)
        view.addSubview(cancelButton)
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            firstNameTF.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            firstNameTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstNameTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            firstNameTF.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        NSLayoutConstraint.activate([
            lastNameTF.topAnchor.constraint(equalTo: firstNameTF.bottomAnchor, constant: 40),
            lastNameTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lastNameTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            lastNameTF.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: lastNameTF.bottomAnchor, constant: 20),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cancelButton.heightAnchor.constraint(equalToConstant: 30),
            cancelButton.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: lastNameTF.bottomAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 30),
            saveButton.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    // MARK: - OBJC methods
    @objc func saveData() {
        let name = firstNameTF.text ?? ""
        let lastName = lastNameTF.text ?? ""
        dataManager.update(userId: userId, firstName: name, lastName: lastName)
        
        onSave()
    }
    
    @objc func cancelAndReturn() {
        onClose()
    }
}
