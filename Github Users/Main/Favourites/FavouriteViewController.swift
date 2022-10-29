//
//  FavouriteViewController.swift
//  Github Users
//
//  Created by Oko-osi Korede on 27/10/2022.
//

import UIKit
import Combine

class FavouriteViewController: UIViewController {
    
    private let viewModel = FavouriteUserViewModel()
    private lazy var tableView = UITableView.genericTableView(cell: UserCell.self, identifier: UserCell.identifier)
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.navigationItem.title = "Favourite Git Users"
        
//        print("This is all stored data: \(viewModel.sortAllUsers())")
        view.addSubview(tableView)
        viewModel.fetchRecentData()
        
        
        setupBarButton()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchRecentData()
        tableView.reloadData()
//        listerner()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.frame = view.bounds
        
        tableView.separatorStyle = .none
        
        
    }
    
    func listerner() {
        viewModel.$allSectionedUser
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                DispatchQueue.main.async {
//                    self?.tableView.reloadData()
                    print("The data is \(self?.viewModel.allSectionedUser)")
                }
                
            }
            .store(in: &cancellables)
    }

    func setupBarButton() {
        let favButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        favButton.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        favButton.addTarget(self, action: #selector(deleteTapped(_:)), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favButton)
        favButton.tintColor = .red
    }
    
    @objc func deleteTapped(_ sender: UIButton) {
        showAlert(title: "Delete", message: "Are you sure you want to delete all your favourite GITHUB users. This is permanent action and cannot be reversed.", positive: "Yes", negavite: "No") { [weak self] in
            guard let self = self else { return }
            let allUser = self.viewModel.allFavGitUser
            if allUser.isEmpty {
                self.showToast(message: "You don't have favourite users yet", font: .systemFont(ofSize: 14))
            } else {
                self.viewModel.removeAllUser()
                self.showToast(message: "You have deleted all your favourite GITHUB users", font: .systemFont(ofSize: 12))
            }
        }
        cancel:  {
           
        }
    }
}

extension FavouriteViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionHeader.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sortAllUsers()[viewModel.sectionHeader[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pos = viewModel.sectionHeader[indexPath.section]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as? UserCell,
              let userData = viewModel.allSectionedUser[pos] else { return UITableViewCell() }
        print("The user data is: \(userData)")
        let user = UserModel(id: userData[indexPath.row].id, username: userData[indexPath.row].username, avatar: userData[indexPath.row].avatar, userType: userData[indexPath.row].userType, userInfo: userData[indexPath.row].userInfo)
        cell.userCellViewModel = UserCellImageDownloader(model: user)
        cell.configure(with: userData[indexPath.row].fullName ?? "", userData[indexPath.row].userType ?? "")
//        cell.backgroundColor = .systemBrown
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        headerView.backgroundColor = .lightGray
        let titleLabel = UILabel()
        headerView.addSubview(titleLabel)
        titleLabel.setCenterAnchor(vertical: headerView.centerYAnchor, horizontal: nil, height: nil, width: nil)
        titleLabel.setViewConstraints(top: nil, right: nil, bottom: headerView.bottomAnchor, left: headerView.leadingAnchor, paddingLeft: 20)
        titleLabel.text = viewModel.sectionHeader[section]
        titleLabel.font = .systemFont(ofSize: 24, weight: .black)
        return headerView
    }
    
}

extension FavouriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let pos = viewModel.sectionHeader[indexPath.section]
        guard let userData = viewModel.allSectionedUser[pos] else { return }
//        var endpoint: String
        let detailVC = DetailViewController()
//        let model = self.viewModel.userProfiles[indexPath.row]
        let model = userData[indexPath.row] //UserModel(id: userData[indexPath.row].id, username: userData[indexPath.row].username, avatar: userData[indexPath.row].avatar, userType: userData[indexPath.row].userType, userInfo: userData[indexPath.row].userInfo)
        let endpoint = model.userInfo
//        guard let endpointWithCom1 = rawEndpoint?.split(separator: "."), endpointWithCom1.count > 2 else { return }
//        let picData = viewModel.userCellViewModels[indexPath.row].image
        detailVC.detailViewModel = DetailViewModel(endPoint: String(endpoint), user: model)
        detailVC.imageLoader = UserCellImageDownloader(model: UserModel(id: model.id, username: model.username, avatar: model.avatar, userType: model.userType, userInfo: model.userInfo))
        detailVC.isFav = true //model.favourite
//        detailVC.userProfilePic.image = picData
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
