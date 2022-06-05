//
//  PopUp.swift
//  Test Balink
//
//  Created by Давид Михайлов on 05.06.2022.
//

import UIKit

class PopUpViewController: UIViewController {

    // MARK: - Properties
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.backgroundColor = .systemGray
        button.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        return button
    }()

    private lazy var okButton: UIButton = {
        let button = UIButton()
        button.setTitle("OK", for: .normal)
        button.backgroundColor = .systemGreen
        button.addTarget(self, action: #selector(okAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        return button
    }()

    private lazy var popUpView: UIView = {
        let popUpView = UIView()
        popUpView.translatesAutoresizingMaskIntoConstraints = false
        popUpView.backgroundColor = .secondarySystemBackground
        popUpView.layer.cornerRadius = 10
        return popUpView
    }()

    private lazy var headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.text = "Custom Pop Up"
        headerLabel.font = .systemFont(ofSize: 26)
        return headerLabel
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setipUI()
        presentPopUp()
    }

    // MARK: - Privatemethods
    private func setipUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        view.addSubview(popUpView)
        popUpView.addSubview(cancelButton)
        popUpView.addSubview(okButton)
        popUpView.addSubview(headerLabel)

        NSLayoutConstraint.activate([
            popUpView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            popUpView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popUpView.heightAnchor.constraint(equalToConstant: view.frame.height/2),
            popUpView.widthAnchor.constraint(equalToConstant: view.frame.width - 20)
        ])

        NSLayoutConstraint.activate([
            cancelButton.bottomAnchor.constraint(equalTo: popUpView.bottomAnchor, constant: -40),
            cancelButton.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 25),
            cancelButton.heightAnchor.constraint(equalToConstant: 40),
            cancelButton.widthAnchor.constraint(equalToConstant: 100)
        ])

        NSLayoutConstraint.activate([
            okButton.bottomAnchor.constraint(equalTo: popUpView.bottomAnchor, constant: -40),
            okButton.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -25),
            okButton.heightAnchor.constraint(equalToConstant: 40),
            okButton.widthAnchor.constraint(equalToConstant: 100)
        ])

        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: popUpView.topAnchor, constant: 60),
            headerLabel.centerXAnchor.constraint(equalTo: popUpView.centerXAnchor),
            headerLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }

    func presentPopUp() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }

    func removePopUp() {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        })
    }

    // MARK: - OBJC methods
    @objc func cancelAction() {
        removePopUp()
    }

    @objc func okAction() {
        print("OK")
    }
}
