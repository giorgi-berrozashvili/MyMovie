//
//  UrlBuilder.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 26.06.21.
//
protocol URLBuilder {
    var urlString: String { get }
    mutating func withBaseUrl() -> Self
}

struct JsonURLBuilder: URLBuilder {
    private(set) var urlString: String
    
    init() {
        self.urlString = ""
    }
    
    mutating func withBaseUrl() -> Self {
        self.urlString = UrlInstrument.dataBaseUrl.string
        return self
    }
    
    mutating func withRequestType(_ type: APIRequestType) -> Self {
        self.urlString += type.rawValue + "/movie?"
        return self
    }
    
    mutating func withApiKey() -> Self {
        self.urlString += 
    }
}

class A {
    func f() {
        
    }
}
