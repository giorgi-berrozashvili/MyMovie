//
//  UrlBuilder.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 26.06.21.
//

/// Url building base protocol
protocol URLBuilder {
    var urlString: String { get }
    func withBaseUrl() -> Self
}
