//
//  ViewController.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 31.01.2023.
//

import UIKit

protocol HomeViewInterface: AnyObject {
    func prepareCollectionView()
    func collectionViewReloadData()
    func prepareTableView()
    func tableViewReloadData()
}

class HomeController: UIViewController, HomeViewInterface {
    
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
    
    private let nowPlayingCollectionView: UICollectionView = {
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
    
    private let moviesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: MoviesTableViewCell.identifier)
        tableView.rowHeight = 120
        tableView.backgroundColor = UIColor.clear
        tableView.layer.backgroundColor = UIColor.clear.cgColor
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var viewModel = HomeViewModel(self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
        configureUI()
        
    }

    @objc private func seeMoreButtonTapped(_ sender: UIButton) {
        print("See More Tapped")
    }
}

// MARK: - ConfigureUI
extension HomeController {
    func configureUI() {
        self.view.backgroundColor = .white
        
        view.addSubviews(leftView, nowPlayingLabel, seeMoreButton, nowPlayingCollectionView, moviesTableView)
        
        seeMoreButton.addTarget(self, action: #selector(seeMoreButtonTapped), for: .touchUpInside)
        
        setConstraints()
    }
    
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
            
            nowPlayingCollectionView.topAnchor.constraint(equalTo: nowPlayingLabel.bottomAnchor, constant: 24),
            nowPlayingCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nowPlayingCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nowPlayingCollectionView.heightAnchor.constraint(lessThanOrEqualToConstant: 280),
            
            moviesTableView.topAnchor.constraint(equalTo: nowPlayingCollectionView.bottomAnchor, constant: 24),
            moviesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
}

// MARK: - NowPlaying CollectionView
extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionViewReloadData() {
        nowPlayingCollectionView.reloadData()
    }
    
    func prepareCollectionView() {
        nowPlayingCollectionView.delegate = self
        nowPlayingCollectionView.dataSource = self
        nowPlayingCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.nowPlayingMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = nowPlayingCollectionView.dequeueReusableCell(
            withReuseIdentifier: HorizontalMovieCell.identifier,
            for: indexPath
        ) as? HorizontalMovieCell else { return UICollectionViewCell() }
        cell.setData(movie: viewModel.nowPlayingMovies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
}

//MARK: - Movies TableView
extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func prepareTableView() {
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
    }
    
    func tableViewReloadData() {
        moviesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Array(viewModel.moviesCategory)[section].value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = moviesTableView.dequeueReusableCell(
            withIdentifier: MoviesTableViewCell.identifier,
            for: indexPath
        ) as? MoviesTableViewCell else { return UITableViewCell() }
        cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.moviesCategory.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40))
        
        let sectionLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let seeMoreSectionButton: UIButton = {
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
        
//        let titles = Array(viewModel.moviesCategory.keys).sorted()
        sectionLabel.text = Array(viewModel.moviesCategory)[section].key
        
        seeMoreSectionButton.addTarget(self, action: #selector(seeMoreButtonTapped), for: .touchUpInside)
        
        header.addSubviews(sectionLabel, seeMoreSectionButton)
        
        NSLayoutConstraint.activate([
            sectionLabel.topAnchor.constraint(equalTo: header.topAnchor),
            sectionLabel.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 24),
          
            seeMoreSectionButton.topAnchor.constraint(equalTo: header.topAnchor),
            seeMoreSectionButton.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -24),
            
        ])
        
        return header
    }
    
}
