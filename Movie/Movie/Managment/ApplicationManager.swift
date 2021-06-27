//
//  ApplicationManager.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 26.06.21.
//

import UIKit
import CoreData

class ApplicationManager {
    static let shared: ApplicationManager = ApplicationManager()
    
    var context: NSManagedObjectContext? {
        didSet {
            self.start()
        }
    }
    
    private let movieManager: MovieManager
    private let favouriteMovieManager: FavouriteMovieManager
    
    private init() {
        movieManager = .shared
        favouriteMovieManager = .shared
    }
    
    private func start() {
        movieManager.FetchInitialMovies()
        favouriteMovieManager.FetchInitialFavouriteMovies()
    }
}
