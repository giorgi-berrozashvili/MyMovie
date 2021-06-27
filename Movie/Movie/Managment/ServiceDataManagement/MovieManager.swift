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
    
    private init() {
        movieStore = .shared
        lastFetchedPage = 1
        movieGateway = GetMoviesGatewayImplementation()
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
                    self.lastFetchedPage += 1
                case .failure(let error):
                    self.serviceErrorMessage = error.localizedDescription
                }
            }
        }
    }
}

extension MovieManager: MovieInformable { }
