//
//  MovieEntityModel.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 27.06.21.
//

struct MovieEntityModel: ModelEntityValidable {
    let id: Int?
    let isFavourite: Bool
    let title: String?
    let rating: Double?
    let posterPath: String?
    let backdropPath: String?
    
    
    func isValid() -> Bool {
        return [id != nil,
                title != nil,
                rating != nil,
                posterPath != nil,
                backdropPath != nil].allSatisfy { $0 }
    }
}
