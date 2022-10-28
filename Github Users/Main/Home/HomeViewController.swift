//
//  HomeViewController.swift
//  Github Users
//
//  Created by Oko-osi Korede on 27/10/2022.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    private lazy var tableView = UITableView.genericTableView(cell: UserCell.self, identifier: UserCell.identifier)
    private let viewModel = HomeViewModel()
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
        self.navigationItem.title = "All Users"
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
            
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
        tableView.separatorStyle = .none
        
        viewModel.$userProfiles
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
                self?.tableView.tableFooterView = nil
            }
            .store(in: &cancellables)
    }
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userProfiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as? UserCell else { return UITableViewCell() }
        cell.userCellViewModel = UserCellViewModel(url: viewModel.userProfiles[indexPath.row].avatar, key: String(viewModel.userProfiles[indexPath.row].id))
        cell.configure(with: viewModel.userProfiles[indexPath.row].username, viewModel.userProfiles[indexPath.row].userType)
        return cell
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UIScrollViewDelegate {
    private func createLoaderView() -> UIView {
        let loadingMoreView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        
        let loader = UIActivityIndicatorView()
        loadingMoreView.addSubview(loader)
        loader.center = loadingMoreView.center
        loader.startAnimating()
        
        return loadingMoreView
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            print("Fetch new data")
            self.tableView.tableFooterView = createLoaderView()
            viewModel.counter += 1
            guard viewModel.counter < 2 else { return }
            viewModel.paginating()
        }
    }
}
