//
//  GetImageGateway.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 26.06.21.
//

import Alamofire

typealias GetImageCompletionHandler = (Result<UIImage, AFError>) -> Void

protocol GetImageGateway {
    func getImage(by identifier: String, completion: @escaping GetImageCompletionHandler)
}

class GetImageGatewayImplementation: GetImageGateway {
    func getImage(by identifier: String, completion: @escaping GetImageCompletionHandler) {
        let url = ImageURLBuilder()
            .withBaseUrl()
            .withSize(.w500)
            .withIdentifier(identifier)
            .urlString
        
        AF.request(url).response { response in
            switch response.result {
            case .success(let result):
                if let data = result,
                   let image = UIImage(data: data) {
                    completion(.success(image))
                }
                else {
                    completion(.failure(AFError.responseSerializationFailed(reason: .inputFileNil)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
