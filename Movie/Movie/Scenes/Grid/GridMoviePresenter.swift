//
//  GridMoviePresenter.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 26.06.21.
//

protocol GridMoviePresenter {
    func viewDidLoad()
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    
}

class GridMoviePresenterImplementation {
    weak var view: GridMovieView?
    let router: GridMovieRouter
    
    init(view: GridMovieView,
         router: GridMovieRouter) {
        
        self.view = view
        self.router = router
    }
}

extension GridMoviePresenterImplementation: GridMoviePresenter {
    func viewDidLoad() {
        
    }
    
    func numberOfSections() -> Int {
        
    }
    
    func numberOfItems(in section: Int) -> Int {
        
    }
}
