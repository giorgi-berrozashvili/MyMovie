//
//  MovieDetailsPresenter.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 27.06.21.
//

import Foundation

// MARK: - movie details presenter declaration
protocol MovieDetailsPresenter {
    func viewDidLoad()
    func getTitle() -> String?
    func getBackdropImageString() -> String
    func getPosterModel() -> PosterView.Model
    func getTripleLabelModel() -> TripleLabelView.Model
    func didTapFavouriteButton()
}

// MARK: - movie details presenter implementation
class MovieDetailsPresenterImplementation {
    // MARK: - private properties
    private weak var view: MovieDetailsView?
    private let router: MovieDetailsRouter
    private let saveFavouriteGateway: SaveFavouriteMovieGateway
    private let deleteFavouriteGateway: DeleteFavouriteMovieGateway
    private var movieEntityModel: MovieEntityModel!
    
    // MARK: - initialization
    init(view: MovieDetailsView,
         router: MovieDetailsRouter,
         saveFavouriteGateway: SaveFavouriteMovieGateway,
         deleteFavouriteGateway: DeleteFavouriteMovieGateway,
         movieEntityModel: MovieEntityModel?) {
        
        self.view = view
        self.router = router
        self.saveFavouriteGateway = saveFavouriteGateway
        self.deleteFavouriteGateway = deleteFavouriteGateway
        self.movieEntityModel = movieEntityModel
    }
}

// MARK: - movie details presenter implementation
extension MovieDetailsPresenterImplementation: MovieDetailsPresenter {
    func viewDidLoad() {
        if isModelInalid() {
            showModelInvalidityError()
            return
        }
    }
    
    func getTitle() -> String? {
        return movieEntityModel.title
    }
    
    func getBackdropImageString() -> String {
        return ImageURLBuilder()
            .withBaseUrl()
            .withSize(.w500)
            .withIdentifier(self.movieEntityModel.backdropPath!)
            .urlString
    }
    
    func getPosterModel() -> PosterView.Model {
        let url = ImageURLBuilder()
            .withBaseUrl()
            .withSize(.w500)
            .withIdentifier(self.movieEntityModel.posterPath!)
            .urlString
        
        return PosterView.Model(
            imageUrl: url,
            ratingText: String(format: "%.1f", movieEntityModel.rating!),
            favouriteIconName: movieEntityModel.isFavourite ? "star-filled" : "star-outline"
        )
    }
    
    func getTripleLabelModel() -> TripleLabelView.Model {
        return TripleLabelView.Model(
            title: movieEntityModel.title,
            description: movieEntityModel.overview,
            additional: getFormattedDate(from: movieEntityModel.releaseDate)
        )
    }
    
    func didTapFavouriteButton() {
        if movieEntityModel.isFavourite { deleteFromFavourites() }
        else { addToFavourites() }
    }
}

// MARK: - movie details helper methods
extension MovieDetailsPresenterImplementation {
    private func isModelInalid() -> Bool {
        return movieEntityModel == nil || movieEntityModel.isValid() == false
    }
    
    private func showModelInvalidityError() {
        view?.notify(message: "Network Error",
                     description: "Network error occurred, sorry for inconvenience",
                     type: .danger)
    }
    
    private func getFormattedDate(from date: String?) -> String? {
        guard let date = date else { return nil }
        
        return Util.getConverted(date, fromFormat: "YYYY-MM-dd", toFormat: "MMMM d, YYYY")
    }
    
    private func deleteFromFavourites() {
        guard let movieId = movieEntityModel.id else {
            view?.notifyGeneralError()
            return
        }
        deleteFavouriteGateway.deleteFavouriteMovie(by: movieId) { [weak self] response in
            if let error = response {
                self?.view?.notify(message: "Network error occurred",
                                   description: error.localizedDescription,
                                   type: .danger)
            }
            else {
                self?.didChangeFavouriteStatus(to: false)
                self?.view?.notify(message: "Success",
                                   description: "\(self?.movieEntityModel.title ?? "Movie") was successfully deleted from favourites",
                                   type: .success)
            }
        }
    }
    
    private func addToFavourites() {
        movieEntityModel.isFavourite = true
        saveFavouriteGateway.saveFavouriteMovie(movieEntityModel) { [weak self] response in
            if let error = response {
                self?.view?.notify(message: "Network error occurred",
                                   description: error.localizedDescription,
                                   type: .danger)
            }
            else {
                self?.didChangeFavouriteStatus(to: true)
                self?.view?.notify(message: "Success",
                                   description: "\(self?.movieEntityModel.title ?? "Movie") was successfully added to favourites",
                                   type: .success)
            }
        }
    }
    
    private func didChangeFavouriteStatus(to value: Bool) {
        self.movieEntityModel.isFavourite = value
        FavouriteMovieManager.shared.FetchFavouriteMovies {
            MovieManager.shared.synchronizeFavouriteMovies()
            NotificationCenter.default.post(name: Notification.Name("DidChangeFavouriteStatus"), object: nil)
        }
        self.view?.refreshPosterView()
    }
}
