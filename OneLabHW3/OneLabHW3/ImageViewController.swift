//
//  ViewController.swift
//  OneLabHW3
//
//  Created by Gazinho Dos Santos on 03.04.2023.
//

import UIKit

final class ImageViewController: UIViewController {
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "slowmo")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(imageView)
        
        Task {
            do {
                let image = try await APIService().fetchImageForPrompt("dancing japanese yakuza")
                await MainActor.run {
                    imageView.image = image
                }
            } catch {
                print("Error occured")
            }
        }
        
    }
    
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
    
}

