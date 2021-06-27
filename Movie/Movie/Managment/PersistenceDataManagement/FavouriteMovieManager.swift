//
//  FavouriteMovieManager.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 27.06.21.
//

import CoreData

class FavouriteMovieManager {
    static let shared: FavouriteMovieManager = FavouriteMovieManager()
    private var favouriteMovieStore: FavouriteMovieStore
    
    private var persistenceErrorMessage: String?
    
    private let favouriteMovieGateway: GetFavouriteMoviesGateway
    
    private init() {
        favouriteMovieStore = .shared
        favouriteMovieGateway = GetFavouriteMoviesGatewayImplementation()
    }
    
    func FetchInitialFavouriteMovies() {
        DispatchQueue.global(qos: .background).sync {
            self.favouriteMovieGateway.getFavouriteMovies { [weak self] response in
                switch response {
                case .success(let movies):
                    self?.favouriteMovieStore.addMovies(movies)
                case .failure(let error):
                    self?.persistenceErrorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func FetchFavouriteMovies(_ completion: (() -> ())? = nil) {
        DispatchQueue.global(qos: .background).async {
            self.favouriteMovieGateway.getFavouriteMovies { [weak self] response in
                switch response {
                case .success(let movies):
                    self?.favouriteMovieStore.addMovies(movies)
                    completion?()
                case .failure(let error):
                    self?.persistenceErrorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func getErrorMessageIfExists() -> String? {
        return persistenceErrorMessage
    }
}
