//
//  GiphyApiService.swift
//  GIPHYApp
//
//  Created by Kyle Kim on 2022/02/13.
//

import Foundation
import Combine
import Alamofire

protocol GiphyApiServiceProtocol {
    func searchImages(keyword: String, completion: @escaping (Result<[ImageDataObject], Error>) -> Void)
    func searchStickers(keyword: String, completion: @escaping (Result<[ImageDataObject], Error>) -> Void)
    func getTrendingImages(completion: @escaping (Result<[ImageDataObject], Error>) -> Void)
    func getTrendingSearch(completion: @escaping (Result<[String], Error>) -> Void)
//    func getTrendingSearch2() -> AnyPublisher<[String], Error> 
}

class GiphyApiService : GiphyApiServiceProtocol {
    let decoder  = JSONDecoder()
    
    func searchImages(keyword: String, completion: @escaping (Result<[ImageDataObject], Error>) -> Void){
        let path = "?api_key=\(KeyConstants.Giphy.APIKey)&q=\(keyword)"
        AF.request(URLConstant.SearchImageURL + path.encodeUrl(), method: .get, encoding: JSONEncoding.default).response { res in
            switch res.result {
            case let .success(data) :
                do {
                    if res.response?.statusCode != 200 {
                        completion(.failure(AppErrors.requestError))
                    }
                    let response = try self.decoder.decode(ImageResponse.self, from: data!)
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
    
    func searchStickers(keyword: String, completion: @escaping (Result<[ImageDataObject], Error>) -> Void){
        let path = "?api_key=\(KeyConstants.Giphy.APIKey)&q=\(keyword)"
        AF.request(URLConstant.SearchStickerURLL + path.encodeUrl(), method: .get, encoding: JSONEncoding.default).response { res in
            switch res.result {
            case let .success(data) :
                do {
                    if res.response?.statusCode != 200 {
                        completion(.failure(AppErrors.requestError))
                    }
                    let response = try self.decoder.decode(ImageResponse.self, from: data!)
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
    
    
    func getTrendingImages(completion: @escaping (Result<[ImageDataObject], Error>) -> Void){
        let path = "?api_key=\(KeyConstants.Giphy.APIKey)"
        AF.request(URLConstant.TrendingImageURL + path, method: .get, encoding: JSONEncoding.default).response { res in
            switch res.result {
            case let .success(data) :
                do {
                    if res.response?.statusCode != 200 {
                        completion(.failure(AppErrors.requestError))
                    }
                    let response = try self.decoder.decode(ImageResponse.self, from: data!)
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
    
    func getTrendingSearch(completion: @escaping (Result<[String], Error>) -> Void){
        let path = "?api_key=\(KeyConstants.Giphy.APIKey)"
        AF.request(URLConstant.TrendingSearchURL + path, method: .get, encoding: JSONEncoding.default).response { res in
            switch res.result {
            case let .success(data) :
                do {
                    if res.response?.statusCode != 200 {
                        completion(.failure(AppErrors.requestError))
                    }
                    let response = try self.decoder.decode(TrendSearchResponse.self, from: data!)
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
    
//    func getTrendingSearch2() -> AnyPublisher<[String], Error> {
//        let path = "?api_key=\(KeyConstants.Giphy.APIKey)"
//        return AF.request(URLConstant.TrendingSearchURL + path, method: .get, encoding: JSONEncoding.default)
//            .validate()
//            .publishDecodable(type: TrendSearchResponse.self)
//            .value()
//            .map(\.data)
//            .mapError{ error in
//                print(error) as! Error
//            }
//            .eraseToAnyPublisher()
        
    ///    #1
//        return URLSession.shared.dataTaskPublisher(for: URL(string: URLConstant.TrendingSearchURL + path)!)
//            .map(\.data)
//            .decode(type: TrendSearchResponse.self, decoder: decoder)
//            .map(\.data)
//            .eraseToAnyPublisher()
        
        
        /// #2
//            .tryMap( {data, response in
//                return data
//            })
//            .decode(type: TrendSearchResponse.self, decoder: decoder)
//            .map(\.data)
//            .mapError{ error in
//                print(error) as! Error
//            }
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
//    }
    
    
}
