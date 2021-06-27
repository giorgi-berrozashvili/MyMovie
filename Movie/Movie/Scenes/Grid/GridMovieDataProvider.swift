//
//  GridMovieDataProvider.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 27.06.21.
//

import Foundation

protocol GridMovieDataProvider {
    func getData() -> [MovieEntityModel]
}

struct GridMoviePopuparDataProvider: GridMovieDataProvider {
    func getData() -> [MovieEntityModel] {
        MovieStore
            .shared
            .getAllMovies()
            .sorted(by: { $0.popularity ?? 0.0 > $1.popularity ?? 0.0 })
    }
}

struct GridMovieTopRatedDataProvider: GridMovieDataProvider {
    func getData() -> [MovieEntityModel] {
        MovieStore
            .shared
            .getAllMovies()
            .sorted(by: { $0.rating ?? 0.0 > $1.rating ?? 0.0 })
    }
}

struct GridMovieFavouriteDataProvider: GridMovieDataProvider {
    func getData() -> [MovieEntityModel] {
        MovieStore
            .shared
            .getAllMovies()
            .filter { $0.isFavourite }
    }
}

enum MovieFilterType: Int {
    case popular = 0
    case topRated = 1
    case favourite = 2
}
