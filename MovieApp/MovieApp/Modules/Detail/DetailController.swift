//
//  DetailController.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 14.02.2023.
//

import UIKit
import Kingfisher

protocol DetailViewInterface: AnyObject {
    func configure()
    func fetchTheMovie(id: Int)
    func fillUI()
    func prepareCollectionView()
    func collectionViewReload()
    func changeButtonImage()
}

class DetailController: UIViewController, DetailViewInterface {

    private let movieImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        button.layer.cornerRadius = 4
        return button
    }()
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    private let bookmarkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.tintColor = .black
        return button
    }()
    
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = UIColor(named: "starbackgroundcolor")
        return imageView
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "ratingtextcolor")
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    private let genreCollectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        collectionViewFlowLayout.itemSize = CGSize(width: 120, height: 24)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.register(GenresCollectionViewCell.self, forCellWithReuseIdentifier: GenresCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.text = "Description"
        return label
    }()
    
    private let overViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    private let mainVStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
   
    private let componentsStakView1: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor(named: "homegenrecolor")?.cgColor
        stackView.layer.cornerRadius = 8
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let languageTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "homegenrecolor")
        return label
    }()
    
    private let languageValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(named: "homegenrecolor")
        return label
    }()
    
    private let componentsStakView2: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor(named: "homegenrecolor")?.cgColor
        stackView.layer.cornerRadius = 8
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let releaseDateTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "homegenrecolor")
        return label
    }()
    
    private let releaseDateValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(named: "homegenrecolor")
        return label
    }()
    
    private let componentsStakView3: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor(named: "homegenrecolor")?.cgColor
        stackView.layer.cornerRadius = 8
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let voteCountTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "homegenrecolor")
        return label
    }()
    
    private let voteCountValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(named: "homegenrecolor")
        return label
    }()
    
    private lazy var viewModel = DetailViewModel(self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.title = "AppName".localized
    }
    
    @objc private func pushPreviousController() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func clickedBookmarkButton() {
        guard let movie = viewModel.movie else {
            return
        }
        if viewModel.isSaved {
            guard let movie = self.viewModel.movie else { return }
            self.viewModel.deleteSavedMovie(movie: movie)
        } else {
            viewModel.saveMovie(movie: movie)
        }
        
    }
}

// MARK: - UI
extension DetailController {
    
    func configure() {
        self.view.backgroundColor = .white
        self.tabBarController?.title = nil
        self.navigationItem.hidesBackButton = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        backButton.addTarget(self, action: #selector(pushPreviousController), for: .touchUpInside)
        bookmarkButton.addTarget(self, action: #selector(clickedBookmarkButton), for: .touchUpInside)
        
        view.addSubviews(movieImageview, bottomView)
        bottomView.addSubviews(
            movieNameLabel,
            bookmarkButton,
            starImageView,
            ratingLabel,
            genreCollectionView,
            descriptionLabel,
            overViewLabel,
            mainVStack
        )
        
        mainVStack.addArrangedSubview(componentsStakView1)
        componentsStakView1.addArrangedSubview(languageTitleLabel)
        componentsStakView1.addArrangedSubview(languageValueLabel)
        
        mainVStack.addArrangedSubview(componentsStakView2)
        componentsStakView2.addArrangedSubview(releaseDateTitleLabel)
        componentsStakView2.addArrangedSubview(releaseDateValueLabel)
        
        mainVStack.addArrangedSubview(componentsStakView3)
        componentsStakView3.addArrangedSubview(voteCountTitleLabel)
        componentsStakView3.addArrangedSubview(voteCountValueLabel)
        
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            movieImageview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieImageview.topAnchor.constraint(equalTo: view.topAnchor),
            movieImageview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieImageview.heightAnchor.constraint(lessThanOrEqualToConstant: (view.frame.height * 0.40)),
        
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.topAnchor.constraint(equalTo: movieImageview.bottomAnchor, constant: -16),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            movieNameLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 24),
            movieNameLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 24),
            movieNameLabel.widthAnchor.constraint(equalToConstant: (view.frame.width*0.70)),
            
            bookmarkButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -24),
            bookmarkButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 24),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 20),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 20),
            
            starImageView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 24),
            starImageView.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 8),
            starImageView.widthAnchor.constraint(equalToConstant: 16),
            starImageView.heightAnchor.constraint(equalToConstant: 16),
            
            ratingLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 8),
            ratingLabel.topAnchor.constraint(equalTo: starImageView.topAnchor),
            
            genreCollectionView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            genreCollectionView.topAnchor.constraint(equalTo: starImageView.bottomAnchor, constant: 8),
            genreCollectionView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            genreCollectionView.heightAnchor.constraint(equalToConstant: 24),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 24),
            descriptionLabel.topAnchor.constraint(equalTo: genreCollectionView.bottomAnchor, constant: 16),
            
            overViewLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 24),
            overViewLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            overViewLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -24),
            
            mainVStack.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 24),
            mainVStack.topAnchor.constraint(equalTo: overViewLabel.bottomAnchor, constant: 8),
            mainVStack.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -24),
            mainVStack.heightAnchor.constraint(equalToConstant: (view.frame.height * 0.08)),

        ])
    }
    
    func prepareCollectionView() {
        genreCollectionView.dataSource = self
    }
    
    func collectionViewReload() {
        genreCollectionView.reloadData()
    }
    
    func changeButtonImage() {
        DispatchQueue.main.async {
            if self.viewModel.isSaved {
                self.bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            } else {
                self.bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            }
        }
    }
    
}

// MARK: - Functions Of Protocol
extension DetailController {
    
    func fillUI() {
        guard let movieDetail = viewModel.movie else { return }
        DispatchQueue.main.async {
            let url = "https://image.tmdb.org/t/p/w500" + movieDetail.poster
            self.movieImageview.kf.setImage(with: URL(string: url))
            self.movieNameLabel.text = movieDetail.originalTitle
            self.ratingLabel.text = "\(round(movieDetail.voteAvarage * 10) / 10)/10 IMDB"
            self.overViewLabel.text = movieDetail.overview
            self.languageTitleLabel.text = "Language"
            self.languageValueLabel.text = movieDetail.language.uppercased()
            self.releaseDateTitleLabel.text = "Release Date"
            self.releaseDateValueLabel.text = "\(movieDetail.release.dateFormetter())"
            self.voteCountTitleLabel.text = "Vote Count"
            self.voteCountValueLabel.text = "\((movieDetail.voteCount))"
        }
    }
    
    func fetchTheMovie(id: Int) {
        viewModel.fetchTheMovie(id: id)
    }
}

// MARK: - CollectionView
extension DetailController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = viewModel.movie?.genres.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = genreCollectionView.dequeueReusableCell(
            withReuseIdentifier: GenresCollectionViewCell.identifier,
            for: indexPath
        ) as? GenresCollectionViewCell, let genres = viewModel.movie?.genres else { return UICollectionViewCell() }
        cell.setData(genre: genres[indexPath.row])
        return cell
    }
}
