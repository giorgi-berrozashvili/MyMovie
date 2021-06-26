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
    private var fetchedImages: [Int: MovieImageEntity]
    
    private init() {
        fetchedMovies = [:]
        fetchedImages = [:]
    }
    
    func addMovies(_ movies: [MovieEntity]) {
        movies.forEach {
            if let id = $0.id {
                fetchedMovies[id] = $0
            }
        }
    }
    
    func getAllImageData() -> [MovieImageEntity] {
        return Array(fetchedImages.values)
    }
    
    func getImageForMovie(id: Int) -> MovieImageEntity? {
        return self.fetchedImages[id]
    }
    
    func setImageForMovie(id: Int, image: MovieImageEntity) {
        self.fetchedImages[id] = image
    }
    
    func getAllMovies() -> [MovieEntity] {
        return Array(fetchedMovies.values)
    }
    
    func getMovieBy(id: Int) -> MovieEntity? {
        return fetchedMovies[id]
    }
}
