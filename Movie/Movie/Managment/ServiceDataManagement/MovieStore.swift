//
//  MovieStore.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 26.06.21.
//

import Foundation

class MovieStore {
    static let shared: MovieStore = MovieStore()
    private var fetchedMovies: [Int: MovieEntity]
    
    private init() {
        fetchedMovies = [:]
    }
    
    func addMovies(_ movies: [MovieEntity]) {
        movies.forEach {
            if let id = $0.id {
                fetchedMovies[id] = $0
            }
        }
    }
    
    func getAllMovies() -> [MovieEntity] {
        return Array(fetchedMovies.values)
    }
    
    func getMovieBy(id: Int) -> MovieEntity? {
        return fetchedMovies[id]
    }
}
