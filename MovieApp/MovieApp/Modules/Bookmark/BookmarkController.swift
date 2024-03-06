//
//  BookmarkController.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 13.02.2023.
//

import UIKit

protocol BookmarkViewControllerInterface:AnyObject {
    func configure()
}

final class BookmarkController: UIViewController {
    
    private lazy var viewModel = BookmarkViewModel(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}

extension BookmarkController: BookmarkViewControllerInterface {
    
    func configure() {
        view.backgroundColor = .white
    }
}
