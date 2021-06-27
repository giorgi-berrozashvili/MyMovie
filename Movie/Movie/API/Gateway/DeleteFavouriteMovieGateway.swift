//
//  DeleteFavouriteMovieGateway.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 27.06.21.
//

import UIKit
import CoreData

typealias DeleteFavouriteMovieGatewayCompletionHandler = (NSError?) -> Void

protocol DeleteFavouriteMovieGateway {
    func deleteFavouriteMovie(by id: Int, completion: @escaping DeleteFavouriteMovieGatewayCompletionHandler)
}

class DeleteFavouriteMovieGatewayImplementation: DeleteFavouriteMovieGateway {
    func deleteFavouriteMovie(by id: Int, completion: @escaping DeleteFavouriteMovieGatewayCompletionHandler) {
        
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
        
        let movieRequest = NSFetchRequest<FavouriteMovieEntity>(entityName: "FavouriteMovieEntity")
        
        DispatchQueue.global(qos: .background).async {
            do {
                let objects = try context.fetch(movieRequest)
                objects.forEach { if $0.id == id { context.delete($0) } }
                try context.save()
                completion(nil)
            } catch let error as NSError {
                completion(error)
            }
        }
    }
    
    
}
