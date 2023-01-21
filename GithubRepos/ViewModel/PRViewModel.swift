//
//  ViewModel.swift
//  GithubRepos
//
//  Created by Veeresh Kumbar on 18/01/23.
//

import Foundation

final class PRViewModel {
    
    // Array to hold the fetched data
    var dataArray: [PRDataModel] = []
    
    // This property will hold the number of pages fethed, will start from 1
    private var pageNumber: Int = 1
    
    // This property will hold the count of pages we need to fetch on each api call
    private let pageCount: Int = 10
    
    private(set) var isLoading: Bool = false
    
    private let networkService: PRServiceProtocol
    
    init(with networkService: PRServiceProtocol) {
        self.networkService = networkService
    }
    
    
    /// Fetched the closed pull request from git hub for a given repo
    /// - Parameter completion: a closure which notifies the caller with error if any after the api call completion
    func fetchData(completion: @escaping ((APIError?)->Void)) {
        isLoading = true
        networkService.fetchClosedPRs(of: pageNumber, with: pageCount) { result in
            DispatchQueue.main.async { [weak self] in
                self?.isLoading = false
                switch result {
                case .success(let success):
                    debugPrint(success?.debugDescription ?? "")
                    self?.dataArray.append(contentsOf: success ?? [])
                    completion(nil)
                    self?.increasePageNumber()
                case .failure(let failure):
                    print(failure.errorDescription)
                    completion(failure)
                }
            }
        }
    }
    
    func increasePageNumber() {
        pageNumber += 1
    }
    
    func getIndexPathsForNewCells() -> [IndexPath] {
        var indexPaths: [IndexPath] = []
        let dataCount: Int = pageNumber * pageCount
        let prevDataCount: Int = (pageNumber-1) * pageCount
        
        for number in prevDataCount..<dataCount {
            let indexPath: IndexPath = IndexPath(row: number, section: 0)
            indexPaths.append(indexPath)
        }
        return indexPaths
    }
    
}
