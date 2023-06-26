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
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.isScrollEnabled = true
        return scroll
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        tableView.isScrollEnabled = false
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
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: 3000)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(leftView, nowPlayingLabel, seeMoreButton, nowPlayingCollectionView, moviesTableView)
        
        seeMoreButton.addTarget(self, action: #selector(seeMoreButtonTapped), for: .touchUpInside)
        
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalToConstant: view.frame.width),
            contentView.heightAnchor.constraint(equalToConstant: 7700),
            
            leftView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            leftView.topAnchor.constraint(equalTo: view.topAnchor),
            leftView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            leftView.widthAnchor.constraint(lessThanOrEqualToConstant: 133),
            
            nowPlayingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            nowPlayingLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            
            seeMoreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            seeMoreButton.topAnchor.constraint(equalTo: nowPlayingLabel.topAnchor, constant: -4),
            
            nowPlayingCollectionView.topAnchor.constraint(equalTo: nowPlayingLabel.bottomAnchor, constant: 24),
            nowPlayingCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nowPlayingCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nowPlayingCollectionView.heightAnchor.constraint(lessThanOrEqualToConstant: 280),
            
            moviesTableView.topAnchor.constraint(equalTo: nowPlayingCollectionView.bottomAnchor, constant: 24),
            moviesTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            moviesTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            moviesTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
        ])
    }
    
    func goToDetailViewController(at indexPath: IndexPath) {
        let controller = DetailController()
        let title = viewModel.returnKey(section: indexPath.section)!
        guard let id = viewModel.moviesCategory[title]?[indexPath.row].id else {
            return
        }
        controller.fetchTheMovie(id: id)
        navigationController?.pushViewController(controller, animated: true)
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
        goToDetailViewController(at: indexPath)
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
        if let section = viewModel.returnKey(section: indexPath.section) {
            if let movie = viewModel.moviesCategory[section]?[indexPath.row] {
                cell.setData(movie: movie, genres: viewModel.genres)
            }
        }
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
        
        sectionLabel.text = viewModel.returnKey(section: section)
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToDetailViewController(at: indexPath)
    }
}
