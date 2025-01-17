//
//  BookmarkController.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 13.02.2023.
//

import UIKit

protocol BookmarkViewControllerInterface:AnyObject {
    func configure()
    func tableViewReloadData()
}

final class BookmarkController: UIViewController {
    
    private lazy var viewModel = BookmarkViewModel(view: self)

    private lazy var bookmarkTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(BookmarkTableViewCell.self, forCellReuseIdentifier: BookmarkTableViewCell.identifier)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
}

// MARK: - BookmarkViewController's Functions
extension BookmarkController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            bookmarkTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bookmarkTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bookmarkTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bookmarkTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}


// MARK: - BookmarkViewControllerInterface's Functions
extension BookmarkController: BookmarkViewControllerInterface {
    
    func configure() {
        view.backgroundColor = .white
        
        view.addSubview(bookmarkTableView)
        
        setConstraints()
    }
    
    func tableViewReloadData() {
        
        DispatchQueue.main.async {
            self.bookmarkTableView.reloadData()
        }
    }
}

// MARK: - TableView Data Source's Function
extension BookmarkController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = bookmarkTableView.dequeueReusableCell(withIdentifier: BookmarkTableViewCell.identifier, for: indexPath) as? BookmarkTableViewCell else {
            return UITableViewCell()
        }
        cell.setData(movie: viewModel.movies[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    
}

// MARK: - BookMarkTableViewCellDelegate's Function
extension BookmarkController: BookmarkTableViewCellDelegate {
    
    func refreshTableView() {
        viewModel.getSavedMovies()
        tableViewReloadData()
    }
}
