//
//  MovieManager.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 26.06.21.
//

import Foundation

class MovieManager {
    static let shared: MovieManager = MovieManager()
    private var movieStore: MovieStore
    
    private var lastFetchedPage: Int
    private var serviceErrorMessage: String?
    
    private let movieGateway: GetMoviesGateway
    private let imageGateway: GetImageGateway
    
    private init() {
        movieStore = .shared
        lastFetchedPage = 1
        
        movieGateway = GetMoviesGatewayImplementation()
        imageGateway = GetImageGatewayImplementation()
    }
    
    func FetchInitialMovies() {
        self.lastFetchedPage += 1
        DispatchQueue.global(qos: .background).sync {
            self.movieGateway.getMovies(on: self.lastFetchedPage) { [weak self] response in
                guard let self = self else { return }
                
                switch response {
                case .success(let result):
                    self.movieStore.addMovies(result)
                case .failure(let error):
                    self.serviceErrorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func FetchMoreMovies() {
        self.lastFetchedPage += 1
        
        DispatchQueue.global(qos: .background).sync {
            self.movieGateway.getMovies(on: self.lastFetchedPage) { [weak self] response in
                guard let self = self else { return }
                
                switch response {
                case .success(let result):
                    self.movieStore.addMovies(result)
                    self.synchronizeImageData()
                    self.lastFetchedPage += 1
                case .failure(let error):
                    self.serviceErrorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func synchronizeImageData() {
        let movies = movieStore.getAllMovies()
        
        DispatchQueue.global(qos: .background).sync {
            movies.forEach {
                if let id = $0.id, self.movieStore.getImageForMovie(id: id) == nil {
                    self.synchronizeImageDataForMovieBy(id: id)
                }
            }
        }
    }
    
    private func synchronizeImageDataForMovieBy(id movieId: Int) {
        let movie = movieStore.getMovieBy(id: movieId)
        
        guard let posterId = movie?.posterPath,
              let backdropId = movie?.backdropPath else { return }
        
        
        DispatchQueue.global(qos: .background).sync {
            self.imageGateway.getImage(by: posterId) { [weak self] response in
                if case let .success(posterResult) = response {
                    self?.imageGateway.getImage(by: backdropId) { [weak self] response in
                        if case let .success(backdropResult) = response {
                            self?.movieStore.setImageForMovie(
                                id: movieId,
                                image: MovieImageEntity(
                                    movieId: movieId,
                                    posterImage: posterResult,
                                    backdropImage: backdropResult
                                )
                            )
                        }
                    }
                }
            }
        }
    }
}

extension MovieManager: MovieInformable { }
