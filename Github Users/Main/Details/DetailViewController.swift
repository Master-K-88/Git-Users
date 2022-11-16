//
//  DetailViewController.swift
//  Github Users
//
//  Created by Oko-osi Korede on 28/10/2022.
//

import UIKit
import Combine

class DetailViewController: UIViewController {
    
    var imageLoader: UserCellImageDownloader?
    var isFav: Bool = false
    
    private lazy var bgView = UIView.bgView()
    private lazy var imageBGView = UIView.customShadowView()
    private lazy var userNameProfileTitle = UILabel.textLabel(fontSize: 24)
    lazy var userProfilePic = UIImageView()
    
    private lazy var userTypeLabel = UILabel.infoLabel(text: "User Type: ", fontSize: 16)
    private lazy var userTypeText = UILabel.textLabel(fontSize: 16)
    
    private lazy var fullNameLabel = UILabel.infoLabel(text: "Full Name: ", fontSize: 16)
    private lazy var fullNameText = UILabel.textLabel(fontSize: 16)
    
    private lazy var companyLabel = UILabel.infoLabel(text: "Company: ", fontSize: 16)
    private lazy var companyText = UILabel.textLabel(fontSize: 16)
    
    private lazy var locationLabel = UILabel.infoLabel(text: "Location: ", fontSize: 16)
    private lazy var locationText = UILabel.textLabel(fontSize: 16)
    
    private lazy var emailLabel = UILabel.infoLabel(text: "Email: ", fontSize: 16)
    private lazy var emailText = UILabel.textLabel(fontSize: 16)
    
    private lazy var bioLabel = UILabel.infoLabel(text: "Bio: ", fontSize: 16)
    private lazy var bioText = UILabel.textLabel(fontSize: 16)
    
    private lazy var twitterLabel = UILabel.infoLabel(text: "Twitter: ", fontSize: 16)
    private lazy var twitterText = UILabel.textLabel(fontSize: 16)
    
    private lazy var followersLabel = UILabel.infoLabel(text: "Follower: ", fontSize: 16)
    private lazy var followersText = UILabel.textLabel(fontSize: 16)
    
    private lazy var followingLabel = UILabel.infoLabel(text: "Following: ", fontSize: 16)
    private lazy var followingText = UILabel.textLabel(fontSize: 16)
    
    var detailViewModel: DetailViewModel?
    
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupUI()
        setupBarButton()
        detailViewModel?.getSavedData()
        // Do any additional setup after loading the view.
        
        detailViewModel?.$userDetail
            .receive(on: RunLoop.main)
            .sink { [weak self] detail in
                self?.configureView()
            }
            .store(in: &cancellables)
    }
    
    func setupBarButton() {
        let favButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        favButton.setImage(UIImage(systemName: isFav ? "heart.fill" : "heart"), for: .normal)
        favButton.addTarget(self, action: #selector(favouriteTapped), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favButton)
        favButton.tintColor = isFav ? .red : .black
    }
    
    @objc func favouriteTapped(_ sender: UIButton) {
        guard let userData = detailViewModel?.userDetail else {
            return
        }
        detailViewModel?.isClicked = detailViewModel?.userDetail.username.uppercased() ?? ""
        if isFav {
//            detailViewModel?.userDetail.favourite = false
            self.showAlert(title: "Fav", message: "You have removed \(userData.username) from your favourite GITHUB users", positive: "Ok")
            detailViewModel?.removeuser()
        } else {
            if !userData.favourite {
                detailViewModel?.addFavUser()
                self.showAlert(title: "Fav", message: "You have added \(userData.username) to your favourite GITHUB users", positive: "Ok")
            } else {
                self.showAlert(title: "Fav", message: "You have already added \(userData.username) to your favourite GITHUB users", positive: "Ok")
            }
            sender.setImage(UIImage(systemName: detailViewModel?.userDetail.favourite ?? false ? "heart.fill": "heart"), for: .normal)
            sender.tintColor = detailViewModel?.userDetail.favourite ?? false ?  .red : .black
        }
    }
    
    func setupUI() {
        view.addSubview(bgView)
        bgView.pin(to: view)
        
        setupSubViews()
        setupTitle()
        setupCompany()
        setupImageView()
        setupUserType()
        setupFullName()
        setupEmail()
        setupLocation()
        setupBio()
        setupTwitter()
        
    }
    
    func setupSubViews() {
        [
            userNameProfileTitle, imageBGView,userTypeLabel,
            userTypeText, fullNameLabel, fullNameText,
            companyLabel, companyText, locationLabel,
            locationText, emailLabel, emailText,
            bioLabel, bioText, twitterLabel,
            twitterText, followersLabel, followersText,
            followingLabel, followingText
        ].forEach { newView in
            bgView.addSubview(newView)
        }
    }
    
    func setupTitle() {
        userNameProfileTitle.setCenterAnchor(vertical: nil, horizontal: bgView.centerXAnchor, height: nil, width: nil)
        userNameProfileTitle.setViewConstraints(top: view.safeTopAnchor, right: nil, bottom: nil, left: nil, paddingTop: 20)
        userNameProfileTitle.text = "Testing"
        userNameProfileTitle.font = .systemFont(ofSize: 24, weight: .black)
        userNameProfileTitle.textColor = UIColor.label
    }
    
    func setupImageView() {
        imageBGView.addSubview(userProfilePic)
        userProfilePic.pin(to: imageBGView)
        imageBGView.setCenterAnchor(vertical: nil, horizontal: bgView.centerXAnchor, height: view.widthAnchor, heightMultiplier: 0.5, width: view.widthAnchor, widthMultiplier: 0.5)
        imageBGView.setViewConstraints(top: userNameProfileTitle.bottomAnchor, right: nil, bottom: nil, left: nil, paddingTop: 20)
        userProfilePic.image = UIImage(named: "default")
        userProfilePic.cornerRadius = view.bounds.size.width * 0.25
        userProfilePic.clipsToBounds = true
    }
    
    func setupUserType() {
        userTypeLabel.setViewConstraints(top: imageBGView.bottomAnchor, right: nil, bottom: nil, left: bgView.leadingAnchor, paddingTop: 35, paddingLeft: 40)
        
        userTypeText.setViewConstraints(top: userTypeLabel.topAnchor, right: nil, bottom: nil, left: userTypeLabel.trailingAnchor, paddingLeft: 20)
        userTypeText.text = "TESTING VALUE"
        userTypeLabel.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    
    func setupFullName() {
        fullNameLabel.setViewConstraints(top: userTypeLabel.bottomAnchor, right: nil, bottom: nil, left: userTypeLabel.leadingAnchor, paddingTop: 25)
        fullNameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        
        fullNameText.setViewConstraints(top: fullNameLabel.topAnchor, right: nil, bottom: nil, left: userTypeText.leadingAnchor)
        fullNameText.text = "TESTING VALUE"
    }
    
    func setupCompany() {
        companyLabel.setViewConstraints(top: fullNameLabel.bottomAnchor, right: nil, bottom: nil, left: fullNameLabel.leadingAnchor, paddingTop: 25)
        companyLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        
        companyText.setViewConstraints(top: companyLabel.topAnchor, right: nil, bottom: nil, left: userTypeText.leadingAnchor)
        companyText.text = "TESTING VALUE"
    }
    
    func setupLocation() {
        locationLabel.setViewConstraints(top: companyLabel.bottomAnchor, right: nil, bottom: nil, left: companyLabel.leadingAnchor, paddingTop: 25)
        locationLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        
        locationText.setViewConstraints(top: locationLabel.topAnchor, right: nil, bottom: nil, left: userTypeText.leadingAnchor)
        locationText.text = "TESTING VALUE"
    }
    
    func setupEmail() {
        
    }
    
    func setupBio() {
        bioLabel.setViewConstraints(top: locationLabel.bottomAnchor, right: nil, bottom: nil, left: locationLabel.leadingAnchor, paddingTop: 25)
        bioLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        
        bioText.setViewConstraints(top: bioLabel.topAnchor, right: bgView.trailingAnchor, bottom: nil, left: userTypeText.leadingAnchor, paddingRight: 20)
        bioText.text = "TESTING VALUE"
        bioText.numberOfLines = 0
        
    }
    
    func setupTwitter() {
        twitterLabel.setViewConstraints(top: bioLabel.bottomAnchor, right: nil, bottom: nil, left: bioLabel.leadingAnchor, paddingTop: 40)
        twitterLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        
        twitterText.setViewConstraints(top: twitterLabel.topAnchor, right: nil, bottom: nil, left: userTypeText.leadingAnchor)
        twitterText.text = "TESTING VALUE"
    }
    
    func configureView() {
        userNameProfileTitle.text = detailViewModel?.userDetail.username.uppercased() ?? ""
        
        imageLoader?.$image
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] image in
                guard let self = self,
                      let image = image else { return }
                self.userProfilePic.image = image
//                self.detailViewModel?.userDetail.avatar =  image.pngData()
            })
            .store(in: &cancellables)
        
        userTypeText.text = detailViewModel?.userDetail.userType ?? "Not Available"
        fullNameText.text = detailViewModel?.userDetail.fullName ?? "Not Available"
        companyText.text = detailViewModel?.userDetail.company ?? "Not Available"
        
        locationText.text = detailViewModel?.userDetail.location ?? "Not Available"
        emailText.text = detailViewModel?.userDetail.email ?? "Not Available"
        bioText.text = detailViewModel?.userDetail.bio ?? "Not Available"
        twitterText.text = "@\(detailViewModel?.userDetail.twitter ?? "")"
        
//        navigationItem.rightBarButtonItem?.image = UIImage
        let rightButton = navigationItem.rightBarButtonItems
        rightButton?.first?.image = UIImage(systemName: detailViewModel?.userDetail.favourite ?? false ? "heart.fill" : "heart.fill")
//        navigationItem.rightBarButtonItem?.image = UIImage(systemName: detailViewModel?.userDetail.favourite ?? false ? "heart.fill" : "heart")
        navigationItem.rightBarButtonItem?.tintColor = detailViewModel?.userDetail.favourite ?? false ? .red : .black
    }

}
