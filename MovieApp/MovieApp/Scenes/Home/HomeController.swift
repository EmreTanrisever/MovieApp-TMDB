//
//  ViewController.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 31.01.2023.
//

import UIKit

class HomeController: UIViewController {

    private let leftView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "homeleftview")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.zPosition = 0
        return view
    }()
    
    private let nowPlayingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
}

extension HomeController {
    func configure() {
        self.view.backgroundColor = .white
        view.addSubviews(leftView, nowPlayingLabel)
        
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            leftView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leftView.topAnchor.constraint(equalTo: view.topAnchor),
            leftView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            leftView.widthAnchor.constraint(lessThanOrEqualToConstant: 133)
        ])
    }
}
