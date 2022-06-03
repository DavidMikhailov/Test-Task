//
//  CustomPopUp.swift
//  Test Balink
//
//  Created by Давид Михайлов on 02.06.2022.
//

import Foundation
import UIKit

class CustomPop: UIView {
    struct Config {
        var action: String
    }

    private lazy var add: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        return button
    }()

    private lazy var cancel: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        return button
    }()

    private lazy var ok: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        return button
    }()

    @objc func addAction() {
        print("add")
    }

    
}
