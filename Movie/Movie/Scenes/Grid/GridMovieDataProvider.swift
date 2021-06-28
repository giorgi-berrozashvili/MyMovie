//
//  GridMovieDataProvider.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 27.06.21.
//

import Foundation

// MARK: - grid data provider declaration for 3 different tab data fetching
protocol GridMovieDataProvider {
    func getData() -> [MovieEntityModel]
}

// MARK: - grid popular movies implementation
struct GridMoviePopuparDataProvider: GridMovieDataProvider {
    func getData() -> [MovieEntityModel] {
        MovieStore
            .shared
            .getAllMovies()
            .sorted(by: { $0.popularity ?? 0.0 > $1.popularity ?? 0.0 })
    }
}

// MARK: - grid top rated movies implementation
struct GridMovieTopRatedDataProvider: GridMovieDataProvider {
    func getData() -> [MovieEntityModel] {
        MovieStore
            .shared
            .getAllMovies()
            .sorted(by: { $0.rating ?? 0.0 > $1.rating ?? 0.0 })
    }
}

// MARK: - grid favourite movies implementation
struct GridMovieFavouriteDataProvider: GridMovieDataProvider {
    func getData() -> [MovieEntityModel] {
        MovieStore
            .shared
            .getAllMovies()
            .filter { $0.isFavourite }
    }
}

// MARK: - grid movie type
enum MovieFilterType: Int {
    case popular = 0
    case topRated = 1
    case favourite = 2
}
