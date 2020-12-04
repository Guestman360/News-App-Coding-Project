//
//  NewsService.swift
//  News App
//
//  Created by Matthew Guest on 12/3/20.
//

import Foundation

class NewsService {
    
    public enum APIServiceError: Error {
        case apiError
        case invalidEndpoint
        case invalidResponse
        case noData
        case decodeError
    }
    
    init() {}
    private let urlSession = URLSession.shared
    private let newsURL = URL(string: Constants.BASE_NEWS_API_URL)!
    
    private let jsonDecoder: JSONDecoder = {
       let jsonDecoder = JSONDecoder()
       return jsonDecoder
    }()
   
    private func fetchResources<T: Decodable>(url: URL, completion: @escaping (Result<T, APIServiceError>) -> Void) {
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        guard let url = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
     
        urlSession.dataTask(with: url) { (result)  in
            switch result {
                case .success(let (response, data)):
                    guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                        completion(.failure(.invalidResponse))
                        return
                    }
                    
                    do {
                        let values = try self.jsonDecoder.decode(T.self, from: data)
                        completion(.success(values))
                    } catch {
                        completion(.failure(.decodeError))
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(.failure(.apiError))
            }
         }.resume()
    }
    
    public func fetchNews(result: @escaping (Result<NewsData, APIServiceError>) -> Void) {
        fetchResources(url: newsURL, completion: result)
    }
}
