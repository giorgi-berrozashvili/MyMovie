//
//  GetMoviesGateway.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 27.06.21.
//
import Alamofire

typealias GetMoviesCompletionHandler = (Result<[MovieEntity], AFError>) -> Void

protocol GetMoviesGateway {
    func getMovies(on page: Int, completion: @escaping GetMoviesCompletionHandler)
}

class GetMoviesGatewayImplementation: GetMoviesGateway {
    func getMovies(on page: Int, completion: @escaping GetMoviesCompletionHandler) {
        let url = DataURLBuilder()
            .withBaseUrl()
            .withRequestType(.discover)
            .withApiKey()
            .withPage(page)
            .urlString
        
        AF.request(url).responseDecodable(of: MovieResultEntity.self) { [weak self] response in
            switch response.result {
            case .success(let result):
                completion(.success(result.results))
                self?.copyMovieDetails(from: result)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func copyMovieDetails(from result: MovieResultEntity) {
        self.discoveredMovieAmount = result.totalResults ?? 0
        self.discoveredMoviePagesAmount = result.totalPages ?? 0
    }
}

extension GetMoviesGatewayImplementation: MovieInformable { }
