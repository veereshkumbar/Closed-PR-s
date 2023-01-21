//
//  PRTableViewCellViewModel.swift
//  GithubRepos
//
//  Created by Veeresh Kumbar on 18/01/23.
//

import Foundation

final class PRTableViewCellViewModel {
    let data: PRDataModel
    
    var userImageUrl: URL? {
        return data.user?.profileImageUrl.toUrl()
    }
    
    var userName: String {
        return "Created by: \(data.user?.userName ?? "")"
    }
    
    var createdAt: String {
        return "Created: \(data.createdAt.trimmedDate())"
    }
    
    var closedAt: String {
        return "Closed: \(data.closedAt.trimmedDate())"
    }
    
    var prTitle: String {
        return data.title
    }
    
    init(data: PRDataModel) {
        self.data = data
    }
    
}

extension String {
    func trimmedDate() -> String {
        if let date = self.split(separator: "T").first {
            var dateArray = date.split(separator: "-")
            dateArray = dateArray.reversed()
            return dateArray.joined(separator: ":")
        }
        return self
    }
}
