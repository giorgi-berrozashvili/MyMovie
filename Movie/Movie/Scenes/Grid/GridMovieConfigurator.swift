//
//  GridMovieConfigurator.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 26.06.21.
//

protocol GridMovieConfigurator {
    func configure(_ controller: GridMovieViewController)
}

class GridMovieConfiguratorImplementation: GridMovieConfigurator {
    func configure(_ controller: GridMovieViewController) {
        let router = GridMovieRouterImplementation(view: controller)
        let dataProvider = GridMoviePopuparDataProvider()
        let presenter = GridMoviePresenterImplementation(
            view: controller,
            router: router,
            dataProvider: dataProvider
        )
        controller.gridPresenter = presenter
    }
}
