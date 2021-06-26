//
//  MovieInformable.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 26.06.21.
//

import Foundation

protocol MovieInformable: AnyObject {
    var discoveredMovieAmount: Int { get set }
    var discoveredMoviePagesAmount: Int { get set }
}

extension MovieInformable {
    
    var discoveredMovieAmount: Int {
        get { MovieInformation.discoveredMovieAmount }
        set { MovieInformation.discoveredMovieAmount = newValue }
    }
    
    var discoveredMoviePagesAmount: Int {
        get { MovieInformation.discoveredMoviePagesAmount }
        set { MovieInformation.discoveredMoviePagesAmount = newValue }
    }
}

private struct MovieInformation {
    static var discoveredMoviePagesAmount: Int = 0
    static var discoveredMovieAmount: Int = 0
}
