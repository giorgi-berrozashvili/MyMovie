//
//  ApplicationManager.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 26.06.21.
//

import Foundation

class ApplicationManager {
    static let shared: ApplicationManager = ApplicationManager()
    
    private let movieManager: MovieManager
    
    private init() {
        movieManager = .shared
    }
    
    func start() {
        movieManager.FetchInitialMovies()
        movieManager.FetchMoreMovies()
        movieManager.FetchMoreMovies()
        movieManager.FetchMoreMovies()
        movieManager.FetchMoreMovies()
        movieManager.FetchMoreMovies()
        movieManager.FetchMoreMovies()
        movieManager.FetchMoreMovies()
        movieManager.FetchMoreMovies()
        movieManager.FetchMoreMovies()
        movieManager.FetchMoreMovies()
        movieManager.FetchMoreMovies()
        movieManager.FetchMoreMovies()
    }
}
