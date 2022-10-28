//
//  UserCell.swift
//  Github Users
//
//  Created by Oko-osi Korede on 27/10/2022.
//

import UIKit
import Combine

class UserCell: UITableViewCell {
    
    var userCellViewModel: UserCellViewModel?
    
    static let identifier = "UserCell"
    
    var mainView = UIView.customShadowView()
    var bgView = UIView.bgView()
    var userImageView = UIImageView()
    var userNameLabel = UILabel.infoLabel(text: "UserName: ", fontSize: 16)
    var userNameText = UILabel.textLabel(fontSize: 16)
    
    var userTypeLabel = UILabel.infoLabel(text: "UserType: ", fontSize: 16)
    var userTypeText = UILabel.textLabel(fontSize: 16)
    
    private var cancellables = Set<AnyCancellable>()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(mainView)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupBGView()
        setupImageView()
        setupUserNameLabel()
        setupUserNameText()
        setupUserTypeLabel()
        setupUserTypeText()
        
    }
    
    private func setupBGView() {
        mainView.setCenterAnchor(vertical: centerYAnchor, horizontal: centerXAnchor, height: heightAnchor, heightMultiplier: 0.8, width: widthAnchor, widthMultiplier: 0.9)
        mainView.addSubview(bgView)
        bgView.pin(to: mainView)
        [userImageView, userNameLabel, userNameText, userTypeLabel, userTypeText].forEach { newView in
            bgView.addSubview(newView)
        }
    }
    
    private func setupImageView() {
        userImageView.setCenterAnchor(vertical: bgView.centerYAnchor, horizontal: nil, height: bgView.heightAnchor, heightMultiplier: 0.7, width: bgView.heightAnchor, widthMultiplier: 0.7)
        userImageView.image = UIImage(named: "default")
        userImageView.setViewConstraints(top: nil, right: nil, bottom: nil, left: bgView.leadingAnchor, paddingLeft: 10)
        userImageView.cornerRadius = 42
        userImageView.clipsToBounds = true
    }
    
    private func setupUserNameLabel() {
        userNameLabel.setViewConstraints(top: bgView.topAnchor, right: nil, bottom: nil, left: userImageView.trailingAnchor, paddingTop: 30, paddingLeft: 10)
    }
    
    private func setupUserNameText() {
        userNameText.setViewConstraints(top: userNameLabel.topAnchor, right: nil, bottom: nil, left: userNameLabel.trailingAnchor, paddingLeft: 2)
    }
    
    private func setupUserTypeLabel() {
        userTypeLabel.setViewConstraints(top: userNameLabel.bottomAnchor, right: nil, bottom: nil, left: userNameLabel.leadingAnchor, paddingTop: 10)
    }
    
    private func setupUserTypeText() {
        userTypeText.setViewConstraints(top: userNameText.bottomAnchor, right: nil, bottom: nil, left: userTypeLabel.trailingAnchor, paddingTop: 10, paddingLeft: 10)
    }
    func configure(with userName: String,_ userType: String) {
        userNameText.text = userName
        userTypeText.text = userType
        
        userCellViewModel?.$image
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] image in
                guard let self = self,
                      let image = image else { return }
                self.userImageView.image = image
            })
            .store(in: &cancellables)
    }
}
