//
//  ViewController.swift
//  assignment_0
//
//  Created by 최성혁 on 2022/09/08.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let nameTF = UITextField()
    let mailTF = UITextField()
    let pwTF = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let topView : UIView = .init(frame: .init())
        topView.backgroundColor = .systemBackground
        self.view.addSubview(topView)

        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        topView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        topView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true

        
        nameTF.autocapitalizationType = .none
        nameTF.borderStyle = .bezel
        
        topView.addSubview(nameTF)
        nameTF.translatesAutoresizingMaskIntoConstraints = false
        nameTF.topAnchor.constraint(equalTo: topView.topAnchor, constant: 30).isActive = true
        nameTF.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 100).isActive = true
        nameTF.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -10).isActive = true
        
        mailTF.keyboardType = .emailAddress
        mailTF.autocapitalizationType = .none
        mailTF.borderStyle = .bezel

        topView.addSubview(mailTF)
        mailTF.translatesAutoresizingMaskIntoConstraints = false
        mailTF.topAnchor.constraint(equalTo: topView.topAnchor, constant: 100).isActive = true
        mailTF.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 100).isActive = true
        mailTF.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -10).isActive = true
        
        pwTF.isSecureTextEntry = true
        pwTF.autocapitalizationType = .none
        pwTF.borderStyle = .bezel
        
        topView.addSubview(pwTF)
        pwTF.translatesAutoresizingMaskIntoConstraints = false
        pwTF.topAnchor.constraint(equalTo: topView.topAnchor, constant: 170).isActive = true
        pwTF.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 100).isActive = true
        pwTF.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -10).isActive = true
        
        let nameLabel = UILabel()
        let mailLabel = UILabel()
        let pwLabel = UILabel()
        
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
        
        pwLabel.text = "비밀번호"
        topView.addSubview(pwLabel)
        pwLabel.translatesAutoresizingMaskIntoConstraints = false
        pwLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 170).isActive = true
        pwLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 0).isActive = true
        pwLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -10).isActive = true
        
        var config = UIButton.Configuration.filled()
        config.titleTextAttributesTransformer =
          UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.preferredFont(forTextStyle: .headline)
            return outgoing
          }
        config.title = "로그인"
        let loginButton = UIButton()
        loginButton.configuration = config
        
        topView.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -100).isActive = true
        //Button Hit 다음 동작
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        
    }
    @objc func login() {
        //빠진 text field가 있으면 알림 띄움
        if (nameTF.text == "" || mailTF.text == "" || pwTF.text == "") {
            let noInputAlert = UIAlertController(title: "", message: "내용을 입력해주세요", preferredStyle: .alert)
            let alertOkButton = UIAlertAction(title: "Okay", style: .default, handler: nil)
            noInputAlert.addAction(alertOkButton)
            present(noInputAlert, animated: true, completion: nil)
            return
        }
        
        //이름이 2글자 미만이면 알림 띄움
        else if (nameTF.text!.count < 2) {
            //alert
            let nameLengthAlert = UIAlertController(title: "", message: "username은 두 글자 이상이어야 합니다", preferredStyle: .alert)
            let alertOkButton = UIAlertAction(title: "Okay", style: .default, handler: nil)
            nameLengthAlert.addAction(alertOkButton)
            present(nameLengthAlert, animated: true, completion: nil)
            return
        }
        
        
        //다음 View로 넘어가기위한 View 세팅
        //ViewModel을 만들고 정보 넘겨줌
        let loginViewModel = LoginViewModel()
        loginViewModel.buildModel(userName: nameTF.text!, userMail: mailTF.text!)
        
        //정보 저장했으니 현재 입력된 정보는 삭제
        self.resetInputData()
        
        let nextVC = UserInfoViewController()
        nextVC.infoShown = loginViewModel.getInfo()
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    func resetInputData() {
        nameTF.text = ""
        mailTF.text = ""
        pwTF.text = ""
    }

}

