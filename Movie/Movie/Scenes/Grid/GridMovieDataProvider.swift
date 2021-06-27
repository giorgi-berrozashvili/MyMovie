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
            .map { MovieEntityModel(
                id: $0.id,
                isFavourite: false,
                title: $0.title,
                rating: $0.voteAverage,
                posterPath: $0.posterPath,
                backdropPath: $0.backdropPath
            )}
    }
}

struct GridMovieTopRatedDataProvider: GridMovieDataProvider {
    func getData() -> [MovieEntityModel] {
        MovieStore
            .shared
            .getAllMovies()
            .sorted(by: { $0.voteAverage ?? 0.0 > $1.voteAverage ?? 0.0 })
            .map { MovieEntityModel(
                id: $0.id,
                isFavourite: false,
                title: $0.title,
                rating: $0.voteAverage,
                posterPath: $0.posterPath,
                backdropPath: $0.backdropPath
            )}
    }
}

struct GridMovieFavouriteDataProvider: GridMovieDataProvider {
    func getData() -> [MovieEntityModel] {
        <#code#>
    }
}
