//
//  PRService.swift
//  GithubRepos
//
//  Created by Veeresh Kumbar on 18/01/23.
//

import Foundation

let apiUrl: String = "https://api.github.com/repos/apple/swift/pulls"

enum APIError: Error {
    case badUrl
    case noData
    
    var errorDescription: String {
        switch self {
        case .badUrl:
            return "Bad URL"
        case .noData:
            return "Could not fetch data"
        }
    }
}


protocol PRServiceProtocol {
    func fetchClosedPRs(of pageNumber: Int, with count: Int, completion: @escaping ((Result<[PRDataModel]?, APIError>) -> Void))
}

class PRService: PRServiceProtocol {
    func fetchClosedPRs(of pageNumber: Int, with count: Int, completion: @escaping ((Result<[PRDataModel]?, APIError>) -> Void)) {
        
        guard let url = URL(string: apiUrl) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let pageItem = URLQueryItem(name: "page", value: pageNumber.toString())
        let countItem = URLQueryItem(name: "per_page", value: count.toString())
        let stateItem = URLQueryItem(name: "state", value: "closed")
        
        urlRequest.url?.append(queryItems: [pageItem, countItem, stateItem])
        debugPrint(urlRequest.url)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                completion(.failure(.badUrl))
                return
            }
            if let data {
                do {
                    let responseData = try JSONDecoder().decode([PRDataModel].self, from: data)
                    print(responseData)
                    completion(.success(responseData))
                } catch let error {
                    print(error)
                }
            } else {
                completion(.failure(.noData))
            }
        }.resume()
        
        
    }
}


extension Int {
    func toString() -> String {
        return "\(self)"
    }
}
