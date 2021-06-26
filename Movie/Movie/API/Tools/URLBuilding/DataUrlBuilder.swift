//
//  DataUrlBuilder.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 26.06.21.
//

class DataURLBuilder: URLBuilder {
    private(set) var urlString: String
    
    init() {
        self.urlString = ""
    }
    
    func withBaseUrl() -> Self {
        self.urlString = APIBaseUrl.dataBaseUrl.string
        return self
    }
    
    func withRequestType(_ type: APIRequestType) -> Self {
        self.urlString += type.rawValue + "/movie?"
        return self
    }
    
    func withApiKey() -> Self {
        self.urlString += "&api_key=" + API_KEY
        return self
    }
    
    func withPage(_ page: Int) -> Self {
        self.urlString += "&page=" + page.description
        return self
    }
    
    func withQuery(_ queryString: String) -> Self {
        self.urlString += "&query=" + queryString.replacingOccurrences(of: " ", with: "+")
        return self
    }
}
