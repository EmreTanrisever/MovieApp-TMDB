//
//  SeeMoreViewController.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 4.03.2024.
//

import UIKit

protocol SeeMoreInterface: AnyObject {
    func configure()
    func prepareTableView()
    func tableViewReloadData()
}

final class SeeMoreViewController: UIViewController {
    
    private lazy var viewModel = SeeMoreViewModel(view: self)
    
    private let moviesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: MoviesTableViewCell.identifier)
        tableView.rowHeight = 120
        tableView.backgroundColor = UIColor.clear
        tableView.layer.backgroundColor = UIColor.clear.cgColor
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
    }
}

// MARK: - SeeMoreViewController's Functions
extension SeeMoreViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            moviesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            moviesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setCategory(at id: Int){
        viewModel.setCategoryId(at: id)
    }
}

// MARK: - SeeMore Interface's Functions
extension SeeMoreViewController: SeeMoreInterface {
    
    func configure() {
        view.addSubviews(moviesTableView)
        setConstraints()
        
        view.backgroundColor = .white
    }
    
    func prepareTableView() {
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
    }
    
    func tableViewReloadData() {
        DispatchQueue.main.async {
            self.moviesTableView.reloadData()
        }
    }
}


// MARK: - TableViewDelegate's Functions
extension SeeMoreViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DetailController()
        if let movies = viewModel.movies {
            controller.fetchTheMovie(id: movies[indexPath.row].id)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

// MARK: - TableViewDataSource's Functions
extension SeeMoreViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = moviesTableView.dequeueReusableCell(
            withIdentifier: MoviesTableViewCell.identifier,
            for: indexPath
        ) as? MoviesTableViewCell else { return UITableViewCell() }
        cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.backgroundColor = UIColor.clear
        if let movies = viewModel.movies, let genres = viewModel.genres {
            cell.setData(
                movie: movies[indexPath.row],
                genres: genres
            )
        }
        return cell
    }
}

