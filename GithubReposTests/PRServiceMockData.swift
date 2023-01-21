//
//  PRServiceMockData.swift
//  GithubReposTests
//
//  Created by Veeresh Kumbar on 21/01/23.
//

import Foundation
@testable import GithubRepos

class PRMockService: PRServiceProtocol {
    func fetchClosedPRs(of pageNumber: Int, with count: Int, completion: @escaping ((Result<[PRDataModel]?, APIError>) -> Void)) {
        // adding mock data here for now to acheive test case results
        
        if let data = PRMockData.getMockData() {
            completion(.success(data))
        } else {
            completion(.failure(APIError.noData))
        }   
    }
}

struct PRMockData {
    static func getMockData() -> [PRDataModel]? {
        do {
            let prData: [PRDataModel] = try JSONDecoder().decode([PRDataModel].self, from: UnitTestHelper.getData(for: "MockData"))
            return prData
        } catch let error {
            debugPrint("error reading mock data: \(error.localizedDescription)")
            return nil
        }
    }
}
