//
//  UrlBuilder.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 26.06.21.
//

protocol URLBuilder {
    var urlString: String { get }
    func withBaseUrl() -> Self
}
