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
    
    let context: NSManagedObjectContext?
    private let movieManager: MovieManager
    
    private init() {
        movieManager = .shared
        self.context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    }
    
    func start() {
        movieManager.FetchInitialMovies()
    }
}
