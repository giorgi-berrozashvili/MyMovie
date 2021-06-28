//
//  GridMovieRouter.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 26.06.21.
//

// MARK: - grid router declaration
protocol GridMovieRouter {
    func navigateToMovieDetails(with movieEntity: MovieEntityModel)
}

// MARK: - grid router implementation
class GridMovieRouterImplementation: GridMovieRouter {
    weak var view: GridMovieView?
    
    init(view: GridMovieView) {
        self.view = view
    }
    
    func navigateToMovieDetails(with movieEntity: MovieEntityModel) {
        let controller = MovieDetailsViewController.configured(with: movieEntity)
        self.view?.push(controller: controller)
    }
}
