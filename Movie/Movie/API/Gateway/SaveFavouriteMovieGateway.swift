//
//  SaveFavouriteMovieGateway.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 27.06.21.
//

import UIKit
import CoreData

typealias SaveFavouriteMovieGatewayCompletionHandler = (NSError?) -> Void

protocol SaveFavouriteMovieGateway {
    func saveFavouriteMovie(_ movie: MovieEntityModel, completion: @escaping SaveFavouriteMovieGatewayCompletionHandler)
}

class SaveFavouriteMovieGatewayImplementation: SaveFavouriteMovieGateway {
    
    func saveFavouriteMovie(_ movie: MovieEntityModel, completion: @escaping SaveFavouriteMovieGatewayCompletionHandler) {
        
        guard let context = ApplicationManager.shared.context else {
            completion(
                NSError(
                    domain: "Internal Error: couldn't find DB context",
                    code: -2,
                    userInfo: nil
                )
            )
            return
        }
        
        guard let movies = NSEntityDescription.entity(
            forEntityName: "FavouriteMovieEntity",
            in: context
        ) else {
            completion(
                NSError(
                    domain: "Internal Error: couldn't find FavouriteMovieEntity",
                    code: -1,
                    userInfo: nil
                )
            )
            return
        }
        
        let object = NSManagedObject(entity: movies, insertInto: context)
        
        object.setValuesForKeys(movie.toDictionary() as [String : Any])
        
        do {
            try context.save()
            completion(nil)
        } catch let error as NSError {
            completion(error)
        }
    }
}
