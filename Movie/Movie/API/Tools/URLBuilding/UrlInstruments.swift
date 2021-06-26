//
//  UrlInstruments.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 26.06.21.
//

enum APIBaseUrl {
    case dataBaseUrl
    case imageBaseUrl
    
    var string: String {
        switch self {
        case .dataBaseUrl:
            return "https://api.themoviedb.org/3/"
        case .imageBaseUrl:
            return "https://image.tmdb.org/t/p/"
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

enum APIImageSize: String {
    case w300
    case w400
    case w500
}
