//
//  DetailViewController.swift
//  Github Users
//
//  Created by Oko-osi Korede on 28/10/2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    private lazy var bgView = UIView.bgView()
    private lazy var userNameProfileTitle = UILabel.textLabel(fontSize: 18)
    private lazy var userProfilePic = UIImageView()
    
    private lazy var userTypeLabel = UILabel.infoLabel(text: "User Type", fontSize: 16)
    private lazy var userTypeText = UILabel.textLabel(fontSize: 16)
    
    private lazy var fullNameLabel = UILabel.infoLabel(text: "Full Name", fontSize: 16)
    private lazy var fullNameText = UILabel.textLabel(fontSize: 16)
    
    private lazy var companyLabel = UILabel.infoLabel(text: "Company", fontSize: 16)
    private lazy var companyText = UILabel.textLabel(fontSize: 16)
    
    private lazy var locationLabel = UILabel.infoLabel(text: "Location", fontSize: 16)
    private lazy var locationText = UILabel.textLabel(fontSize: 16)
    
    private lazy var emailLabel = UILabel.infoLabel(text: "Email", fontSize: 16)
    private lazy var emailText = UILabel.textLabel(fontSize: 16)
    
    private lazy var bioLabel = UILabel.infoLabel(text: "Bio", fontSize: 16)
    private lazy var bioText = UILabel.textLabel(fontSize: 16)
    
    private lazy var twitterLabel = UILabel.infoLabel(text: "Twitter Handle", fontSize: 16)
    private lazy var twitterText = UILabel.textLabel(fontSize: 16)
    
    private lazy var followersLabel = UILabel.infoLabel(text: "Follower", fontSize: 16)
    private lazy var followersText = UILabel.textLabel(fontSize: 16)
    
    private lazy var followingLabel = UILabel.infoLabel(text: "Following", fontSize: 16)
    private lazy var followingText = UILabel.textLabel(fontSize: 16)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .darkGray
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        view.addSubview(bgView)
        bgView.pin(to: view)
        
        setupSubViews()
        setupTitle()
        setupImageView()
        setupUserType()
        setupFullName()
        setupCompany()
        setupBio()
        setupTwitter()
    }
    
    func setupSubViews() {
        [
            userNameProfileTitle, userProfilePic,userTypeLabel,
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
        
    }
    
    func setupImageView() {
        
    }
    
    func setupUserType() {
        
    }
    
    func setupFullName() {
        
    }
    
    func setupCompany() {
        
    }
    
    func setupBio() {
        
    }
    
    func setupTwitter() {
        
    }
    

}
