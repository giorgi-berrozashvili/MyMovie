//
//  MovieDetailsConfigurator.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 27.06.21.
//

// MARK: - movie details configurator declaration
protocol MovieDetailsConfigurator {
    func configure(_ controller: MovieDetailsViewController, model: MovieEntityModel?)
}

// MARK: - movie details comfigurator implementation
class MovieDetailsConfiguratorImplementation: MovieDetailsConfigurator {
    func configure(_ controller: MovieDetailsViewController, model: MovieEntityModel?) {
        let saveFavouriteGateway = SaveFavouriteMovieGatewayImplementation()
        let deleteFavouriteGateway = DeleteFavouriteMovieGatewayImplementation()
        let router = MovieDetailsRouterImplementation()
        
        let presenter = MovieDetailsPresenterImplementation(
            view: controller,
            router: router,
            saveFavouriteGateway: saveFavouriteGateway,
            deleteFavouriteGateway: deleteFavouriteGateway,
            movieEntityModel: model
        )
        controller.presenter = presenter
    }
}
