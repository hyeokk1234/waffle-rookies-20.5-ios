//
//  AddNewTaskViewController.swift
//  seminar-1-ios-version2
//
//  Created by 최성혁 on 2022/09/19.
//

import Foundation
import UIKit

class AddNewTaskViewController: UIViewController {
    let todoListViewModel : TodoListViewModel
    let taskTF = UITextField()
    let addTaskButton = UIButton()
    
    init (todoListViewModel: TodoListViewModel) {
        self.todoListViewModel = todoListViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        applyDesign()
    }
}

extension AddNewTaskViewController {
    func setupLayout() {
        taskTF.autocapitalizationType = .none
        taskTF.autocorrectionType = .no
        taskTF.borderStyle = .bezel
        
        self.view.addSubview(taskTF)
        taskTF.translatesAutoresizingMaskIntoConstraints = false
        taskTF.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        taskTF.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        taskTF.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        
        //addTaskButton configuration
        var config = UIButton.Configuration.filled()
        config.titleTextAttributesTransformer =
          UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.preferredFont(forTextStyle: .headline)
            return outgoing
          }
        config.title = "할 일 추가"
        addTaskButton.configuration = config
        
        //Button AutoLayout
        self.view.addSubview(addTaskButton)
        addTaskButton.translatesAutoresizingMaskIntoConstraints = false
        addTaskButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        addTaskButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        addTaskButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addTaskButton.bottomAnchor.constraint(equalTo:self.view.bottomAnchor, constant: -100).isActive = true
        
        //Button Hit 다음 동작 설정
        addTaskButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
    }
    
    @objc func addTask() {
        if (taskTF.text?.count != nil) {
            if (1<=taskTF.text!.count && taskTF.text!.count<=20) {
                todoListViewModel.append(tm: TaskModel(content: taskTF.text, isDone: false))
                self.navigationController?.popViewController(animated: true)
            }
            else {
                let taskLengthAlert = UIAlertController(title: "", message: "1글자 이상, 20글자 이하로 입력해주세요", preferredStyle: .alert)
                let alertOkButton = UIAlertAction(title: "Okay", style: .default, handler: nil)
                taskLengthAlert.addAction(alertOkButton)
                present(taskLengthAlert, animated: true, completion: nil)
                return
            }
        }
    }
    
    func applyDesign() {
        self.view.backgroundColor = .lightGray
        self.taskTF.backgroundColor = .white
    }
}
