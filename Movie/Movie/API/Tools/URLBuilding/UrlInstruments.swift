//
//  UrlInstruments.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 26.06.21.
//

enum UrlInstrument {
    case dataBaseUrl
    case imageBaseUrl
    
    var string: String {
        switch self {
        case .dataBaseUrl:
            return "https://api.themoviedb.org/3/"
        case .imageBaseUrl:
            return "https://image.tmdb.org/t/p/"
//        case .resourceType(let type):
//            switch type {
//            case .json(let requestType):
//                return requestType.rawValue
//            case .image:
//                return "w500/"
//            }
//        }
        }
    }
}

enum APIResourceType {
    case data
    case image
}

enum APIRequestType: String {
    case discover
    case find
    case search
    
    
}
