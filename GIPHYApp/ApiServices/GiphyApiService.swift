//
//  GiphyApiService.swift
//  GIPHYApp
//
//  Created by Kyle Kim on 2022/02/13.
//

import Foundation
import Alamofire

protocol GiphyApiServiceProtocol {
    func searchImages(keyword: String, completion: @escaping (Result<[DataObject], Error>) -> Void)
}

class GiphyApiService : GiphyApiServiceProtocol {
    let decoder  = JSONDecoder()
    func searchImages(keyword: String, completion: @escaping (Result<[DataObject], Error>) -> Void){
        let path = "?api_key=\(KeyConstants.Giphy.APIKey)&q=\(keyword)$limit=3"
        AF.request(URLConstant.SearchImageURL + path.encodeUrl(), method: .get, encoding: JSONEncoding.default).response { res in
            switch res.result {
            case let .success(data) :
                do {
                    if res.response?.statusCode != 200 {
                        completion(.failure(AppErrors.requestError))
                    }
                    let response = try self.decoder.decode(GiphyResponse.self, from: data!)
                    completion(.success(response.data))
                } catch {
                    #if DEBUG
                        print(error.localizedDescription)
                    #endif
                    completion(.failure(AppErrors.decodeError))
                }
            case let .failure(error):
                #if DEBUG
                print(error.localizedDescription)
                #endif
                completion(.failure(AppErrors.networkError))
            }
        }
    }

}
