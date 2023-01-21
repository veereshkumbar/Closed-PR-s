//
//  ViewModelTest.swift
//  GithubReposTests
//
//  Created by Veeresh Kumbar on 20/01/23.
//

import XCTest
@testable import GithubRepos

final class PRViewModelTest: XCTestCase {

    func testFetchData() {
        
        let viewModel: PRViewModel = PRViewModel(with: PRMockService())
        
        XCTAssertEqual(viewModel.dataArray.count, 0)
        
        viewModel.fetchData { error in
            XCTAssertNil(error)
            XCTAssertEqual(viewModel.dataArray.count, 10)
            XCTAssertNotNil(viewModel.dataArray[0].user)
            let indexPaths = viewModel.getIndexPathsForNewCells()
            XCTAssertEqual(indexPaths.count, 10)
        }
        
    }

}
