//
//  ViewController.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 31.01.2023.
//

import UIKit

protocol HomeViewInterface: AnyObject {
    func prepareCollectionView()
}

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
        label.text = "Home.firstTitle".localized
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let seeMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Home.seeMoreButtonTitle".localized, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 12
        button.setTitleColor(UIColor(named: "tabbarshadow"), for: .normal)
        button.layer.borderColor = UIColor(named: "tabbarshadow")?.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 12, bottom: 4, right: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let carouselCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        collectionViewLayout.itemSize = CGSize(width: 144, height: 280)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(HorizontalMovieCell.self, forCellWithReuseIdentifier: HorizontalMovieCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        return collectionView
    }()
    
    private lazy var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
        
        configureUI()
        
    }

    @objc private func seeMoreButtonTapped(_ sender: UIButton) {
        print("See More Tapped")
    }
}

extension HomeController: HomeViewInterface, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func prepareCollectionView() {
        carouselCollectionView.delegate = self
        carouselCollectionView.dataSource = self
        carouselCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = carouselCollectionView.dequeueReusableCell(withReuseIdentifier: HorizontalMovieCell.identifier, for: indexPath) as? HorizontalMovieCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
}

extension HomeController {
    func configureUI() {
        self.view.backgroundColor = .white
        
        view.addSubviews(leftView, nowPlayingLabel, seeMoreButton, carouselCollectionView)
        
        seeMoreButton.addTarget(self, action: #selector(seeMoreButtonTapped), for: .touchUpInside)
        
        setConstraints()
    }
    
    // MARK: - Constraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            leftView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leftView.topAnchor.constraint(equalTo: view.topAnchor),
            leftView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            leftView.widthAnchor.constraint(lessThanOrEqualToConstant: 133),
            
            nowPlayingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            nowPlayingLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            seeMoreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            seeMoreButton.topAnchor.constraint(equalTo: nowPlayingLabel.topAnchor, constant: -4),
            
            carouselCollectionView.topAnchor.constraint(equalTo: nowPlayingLabel.bottomAnchor, constant: 24),
            carouselCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            carouselCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            carouselCollectionView.heightAnchor.constraint(lessThanOrEqualToConstant: 280)
            
        ])
    }
}
