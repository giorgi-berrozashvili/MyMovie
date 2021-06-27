//
//  MovieDetailsConfigurator.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 27.06.21.
//

protocol MovieDetailsConfigurator {
    func configure(_ controller: MovieDetailsViewController)
}

class MovieDetailsConfiguratorImplementation: MovieDetailsConfigurator {
    func configure(_ controller: MovieDetailsViewController) {
        let presenter = MovieDetailsPresenterImplementation()
        controller.presenter = presenter
    }
}
