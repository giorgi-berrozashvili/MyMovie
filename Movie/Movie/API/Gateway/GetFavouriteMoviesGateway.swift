//
//  GetFavouriteMoviesGateway.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 27.06.21.
//

import UIKit
import CoreData

typealias GetFavouriteMoviesCompletionHandler = (Result<[MovieEntityModel], NSError>) -> Void

protocol GetFavouriteMoviesGateway {
    func getFavouriteMovies(completion: @escaping GetFavouriteMoviesCompletionHandler)
}

class GetFavouriteMoviesGatewayImplementation: GetFavouriteMoviesGateway {
    func getFavouriteMovies(completion: @escaping GetFavouriteMoviesCompletionHandler) {
        
        guard let context = ApplicationManager.shared.context else {
            completion(
                .failure(
                    NSError(
                        domain: "Internal Error: couldn't find DB context",
                        code: -2,
                        userInfo: nil
                    )
                )
            )
            return
        }
        
        let movieRequest = NSFetchRequest<NSDictionary>(entityName: "FavouriteMovieEntity")
        movieRequest.resultType = .dictionaryResultType
        
        DispatchQueue.global(qos: .background).async {
            do {
                let result = try context.fetch(movieRequest)
                completion(.success(self.getModelFromDictionary(result)))
                
            } catch let error as NSError {
                completion(.failure(error))
            }
        }
        
    }
    
    private func getModelFromDictionary(_ result: [NSDictionary]) -> [MovieEntityModel] {
        return result.map { MovieEntityModel.fromDictionary($0 as! [String : Any?])}
    }
}
