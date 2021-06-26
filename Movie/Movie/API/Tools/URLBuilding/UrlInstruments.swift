//
//  UrlInstruments.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 26.06.21.
//

enum APIBaseUrl: String {
    case dataBaseUrl = "https://api.themoviedb.org/3/"
    case imageBaseUrl = "https://image.tmdb.org/t/p/"
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
