//
//  DetailViewModel.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 31.05.2023.
//

import Foundation
import RealmSwift

protocol DetailViewModelInterface {
    var view: DetailViewInterface? { get set }
    var movie: DetailsOfMovie? { get set }
    var savedMovies: [MoviePersistance]? { get set}
    
    func viewDidLoad()
    func fetchTheMovie(id: Int)
    func saveMovie(movie: DetailsOfMovie)
    func fetchSavedMovie()
}

final class DetailViewModel {
    weak var view: DetailViewInterface?
    var movie: DetailsOfMovie?
    var savedMovies: [MoviePersistance]?
    var isSaved = false
    
    private let networkService = NetworkService()
    private let movieStorageService = MovieStorageService()
    
    init(_ view: DetailViewInterface) {
        self.view = view
    }
}

extension DetailViewModel: DetailViewModelInterface {
    
    func viewDidLoad() {
        view?.configure()
        view?.prepareCollectionView()
        fetchSavedMovie()
    }
    
    func fetchTheMovie(id: Int) {
        networkService.getTheMovieDetail(id: "\(id)", completion: { [weak self] response in
            switch response {
            case .success(let movie):
                self?.movie = movie
                self?.controlSavedMovie(movie: self?.movie)
                self?.view?.fillUI()
                self?.view?.changeButtonImage()
                self?.view?.collectionViewReload()
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func saveMovie(movie: DetailsOfMovie) {
        
        if let movieDetail = self.movie {
            let genresId = List<Int>()
            let genres = List<String>()
            
            movieDetail.genres.forEach { genre in
                genresId.append(genre.id)
                genres.append(genre.name)
            }
            
            let moviePersistance = MoviePersistance(
                adult: movieDetail.adult,
                backdrop_path: movieDetail.backdrop_path,
                budget: movieDetail.budget,
                genresId: genresId,
                genres: genres,
                homepage: movieDetail.homepage,
                imdbId: movieDetail.imdbId,
                language: movieDetail.language,
                originalTitle: movieDetail.originalTitle,
                overview: movieDetail.overview,
                popularity: movieDetail.popularity,
                poster: movieDetail.poster,
                release: movieDetail.release,
                revenue: movieDetail.revenue,
                voteAvarage: movieDetail.voteAvarage,
                voteCount: movieDetail.voteCount
            )
            movieStorageService.saveMovie(movie: moviePersistance)
        }
        fetchSavedMovie()
        controlSavedMovie(movie: self.movie)
        self.view?.changeButtonImage()
    }
    
    func fetchSavedMovie() {
        savedMovies = movieStorageService.getMovies()
    }
    
    func controlSavedMovie(movie: DetailsOfMovie?) {
        savedMovies?.forEach({ moviePersistance in
            if moviePersistance.imdbId == movie?.imdbId {
                isSaved = true
            }
        })
    }
    
    func deleteSavedMovie(movie: DetailsOfMovie) {
        savedMovies?.forEach({ moviePersistance in
            if moviePersistance.imdbId == movie.imdbId {
                self.movieStorageService.deleteTheMovie(movie: moviePersistance)
                fetchSavedMovie()
                isSaved = false
                controlSavedMovie(movie: self.movie)
                self.view?.changeButtonImage()
            }
        })
    }
}
