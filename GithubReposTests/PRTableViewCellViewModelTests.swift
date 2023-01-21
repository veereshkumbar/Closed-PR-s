//
//  PRTableViewCellViewModelTests.swift
//  GithubReposTests
//
//  Created by Veeresh Kumbar on 21/01/23.
//

import XCTest
@testable import GithubRepos

final class PRTableViewCellViewModelTests: XCTestCase {

    func testFetchData() {
        
        let model: [PRDataModel]? = PRMockData.getMockData()
        XCTAssertNotNil(model)
        
        if let model {
            let viewModel: PRTableViewCellViewModel = PRTableViewCellViewModel(data: model[0])
            XCTAssertNotNil(viewModel.data.user)
            XCTAssertNotNil(viewModel.userName)
            XCTAssertNotNil(viewModel.userImageUrl)
            XCTAssertNotNil(viewModel.createdAt)
            XCTAssertNotNil(viewModel.closedAt)
            XCTAssertNotEqual(viewModel.prTitle, "")
        }
    }

}
