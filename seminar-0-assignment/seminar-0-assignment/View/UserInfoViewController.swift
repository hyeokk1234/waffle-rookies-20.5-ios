//
//  UserInfoViewController.swift
//  assignment_0
//
//  Created by 최성혁 on 2022/09/08.
//

import UIKit

class UserInfoViewController: UIViewController {
    var infoShown : [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let topView : UIView = .init(frame: .init())
        topView.backgroundColor = .systemBackground
        self.view.addSubview(topView)

        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        topView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        topView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        let nameLabel = UILabel()
        let mailLabel = UILabel()
        
        nameLabel.text = "유저 이름"
        topView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 30).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 0).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -10).isActive = true
        
        mailLabel.text = "이메일"
        topView.addSubview(mailLabel)
        mailLabel.translatesAutoresizingMaskIntoConstraints = false
        mailLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 100).isActive = true
        mailLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 0).isActive = true
        mailLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -10).isActive = true
        
        let userNameLabel = UILabel()
        userNameLabel.text = infoShown![0]
        topView.addSubview(userNameLabel)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 30).isActive = true
        userNameLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 100).isActive = true
        userNameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -10).isActive = true
        
        
        
        let userMailLabel = UILabel()
        userMailLabel.text = infoShown![1]
        topView.addSubview(userMailLabel)
        userMailLabel.translatesAutoresizingMaskIntoConstraints = false
        userMailLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 100).isActive = true
        userMailLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 100).isActive = true
        userMailLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -10).isActive = true
        
        var config = UIButton.Configuration.filled()
        config.titleTextAttributesTransformer =
          UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.preferredFont(forTextStyle: .headline)
            return outgoing
          }
        config.title = "로그아웃"
        
        let logoutButton = UIButton()
        logoutButton.configuration = config
        
        topView.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        logoutButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        logoutButton.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -100).isActive = true
        //Button Hit 다음 동작
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }
    
    @objc func logout() {
        self.navigationController?.popViewController(animated: true)
    }
}


