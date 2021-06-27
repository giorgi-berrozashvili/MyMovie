//
//  GridMovieRouter.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 26.06.21.
//

protocol GridMovieRouter {
    func navigateToMovieDetails(with movieEntity: Any)
}

class GridMovieRouterImplementation: GridMovieRouter {
    weak var view: GridMovieView?
    
    init(view: GridMovieView) {
        self.view = view
    }
    
    func navigateToMovieDetails(with movieEntity: Any) {
        let controller = MovieDetailsViewController.configured()
        self.view?.push(controller: controller)
    }
}
