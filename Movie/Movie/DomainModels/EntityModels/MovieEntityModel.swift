//
//  MovieEntityModel.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 27.06.21.
//

struct MovieEntityModel: ModelEntityValidable {
    let id: Int?
    var isFavourite: Bool
    let title: String?
    let rating: Double?
    let popularity: Double?
    let overview: String?
    let releaseDate: String?
    let posterPath: String?
    let backdropPath: String?
    
    func isValid() -> Bool {
        return [id != nil,
                title != nil,
                rating != nil,
                popularity != nil,
                overview != nil,
                releaseDate != nil,
                posterPath != nil,
                backdropPath != nil].allSatisfy { $0 }
    }
}

extension MovieEntityModel: ModelEntityMappable {
    static func fromDictionary(_ dictionary: [String : Any?]) -> MovieEntityModel {
        return MovieEntityModel(
            id: dictionary["id"] as? Int,
            isFavourite: dictionary["isFavourite"] as? Bool ?? false,
            title: dictionary["title"] as? String,
            rating: dictionary["rating"] as? Double,
            popularity: dictionary["popularity"] as? Double,
            overview: dictionary["overview"] as? String,
            releaseDate: dictionary["releaseDate"] as? String,
            posterPath: dictionary["posterPath"] as? String,
            backdropPath: dictionary["backdropPath"] as? String
        )
    }
    
    func toDictionary() -> [String : Any?] {
        return [
            "id": id,
            "isFavourite": isFavourite,
            "title": title,
            "rating": rating,
            "popularity": popularity,
            "overview": overview,
            "releaseDate": releaseDate,
            "posterPath": posterPath,
            "backdropPath": backdropPath
        ]
    }
}
