//
//  ViewController.swift
//  GithubRepos
//
//  Created by Veeresh Kumbar on 18/01/23.
//

import UIKit

class PRViewController: UIViewController {
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var prTableView: UITableView!
    let viewModel: PRViewModel = PRViewModel(with: PRService())
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        loadData()
        
    }
    
    private func setupUI() {
        prTableView.delegate = self
        prTableView.dataSource = self
    }
    
    private func loadData() {
        loadingView.isHidden = false
        viewModel.fetchData { [weak self] error in
            guard let self = self else { return }
            self.loadingView.isHidden = true
            guard error == nil else {
                debugPrint(error?.errorDescription ?? "")
                return
            }
            
            let indexPaths = self.viewModel.getIndexPathsForNewCells()
            self.prTableView.insertRows(at: indexPaths, with: .automatic)
            
//            self.prTableView.reloadData()
        }
    }


}


extension PRViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PRTableViewCell", for: indexPath) as? PRTableViewCell else { return UITableViewCell() }
        
        let dataModel: PRDataModel = viewModel.dataArray[indexPath.row]
        let cellViewModel: PRTableViewCellViewModel = PRTableViewCellViewModel(data: dataModel)
        cell.config(viewModel: cellViewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.dataArray.count - 2 {
            self.loadData()
        }
    }
    
    
}
