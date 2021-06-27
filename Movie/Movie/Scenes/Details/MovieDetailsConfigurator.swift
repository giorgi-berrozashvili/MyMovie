//
//  MovieDetailsConfigurator.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 27.06.21.
//

protocol MovieDetailsConfigurator {
    func configure(_ controller: MovieDetailsViewController, model: MovieEntityModel?)
}

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
