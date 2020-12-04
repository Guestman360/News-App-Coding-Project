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
    
    // Use NewsService as Singleton??
//    public static let shared = NewsService()
    init() {}
    private let urlSession = URLSession.shared
    private let newsURL = URL(string: Constants.BASE_NEWS_API_URL)!
    
    private let jsonDecoder: JSONDecoder = {
       let jsonDecoder = JSONDecoder()
       return jsonDecoder
    }()
   
    // Simpler network request but decided to experiment with more comprehensive approach below
//    static func getArticles(url : URL , completion : @escaping (NewsData?) -> () )  {
//
//        print("Making web request")
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//
//            if let error = error {
//                print(error.localizedDescription)
//                completion(nil)
//                return
//            }
//
//            if let data = data {
//                print("Fetching response")
//                if let response = try? JSONDecoder().decode(NewsData.self, from: data) {
//                    print("Completion handler")
//                    completion(response)
//                }
//            }
//        }.resume()
//    }
    
    // Leverage Result enum that Swift provides us for better error handling and descriptions
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

// Extension on URLSession datatask that lets us use Swift Result type for the completion handler closure
extension URLSession {
    func dataTask(with url: URL, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
}
