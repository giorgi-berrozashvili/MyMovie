//
//  ImageUrlBuilder.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 26.06.21.
//

class ImageURLBuilder: URLBuilder {
    private(set) var urlString: String
    
    init() {
        self.urlString = ""
    }
    
    func withBaseUrl() -> Self {
        self.urlString = APIBaseUrl.imageBaseUrl.string
        return self
    }
    
    func withSize(_ size: APIImageSize) -> Self {
        self.urlString += size.rawValue + "/"
        return self
    }
    
    func withIdentifier(_ identifier: String) -> Self {
        self.urlString += identifier
        return self
    }
}
