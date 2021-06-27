//
//  FavouriteMovieStore.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 27.06.21.
//

class FavouriteMovieStore {
    static let shared: FavouriteMovieStore = FavouriteMovieStore()
    private var fetchedMovies: [Int: MovieEntityModel]
    
    private init() {
        fetchedMovies = [:]
    }
    
    func addMovies(_ movies: [MovieEntityModel]) {
        movies.forEach {
            if let id = $0.id {
                fetchedMovies[id] = $0
            }
        }
    }
    
    func getAllMovies() -> [MovieEntityModel] {
        return Array(fetchedMovies.values)
    }
    
    func getMovieBy(id: Int) -> MovieEntityModel? {
        return fetchedMovies[id]
    }
}
