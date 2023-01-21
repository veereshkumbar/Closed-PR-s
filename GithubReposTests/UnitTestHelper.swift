//
//  UnitTestHelper.swift
//  GithubReposTests
//
//  Created by Veeresh Kumbar on 21/01/23.
//

import Foundation
@testable import GithubRepos


/// Helper class for getting mock data from local files
class UnitTestHelper {
    
    static let testBundle = Bundle(for: UnitTestHelper.self)
    
    static func getData(for fileName: String) -> Data {
        if let path = testBundle.path(forResource: fileName, ofType: "json") {
            do {
                return try Data(contentsOf: URL(fileURLWithPath: path))
            } catch {
                return Data()
            }
        }
        return Data()
    }
    
    
}
