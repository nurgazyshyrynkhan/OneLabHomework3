//
//  FirstViewController.swift
//  OneLabHW3
//
//  Created by Gazinho Dos Santos on 04.04.2023.
//

import UIKit

final class FirstViewController: UIViewController {
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .white
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        title = "Search"
        view.addSubview(button)
        view.addSubview(textView)
        setupConstraints()
        
        button.addTarget(
            self,
            action: #selector(buttonTapped),
            for: .touchUpInside
        )
    }
    
    @objc private func buttonTapped() {
        let imageViewController = ImageViewController()
        
        navigationController?.pushViewController(imageViewController, animated: true)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textView.widthAnchor.constraint(equalToConstant: 300),
            textView.heightAnchor.constraint(equalToConstant: 300),
            
            button.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 50),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
}
