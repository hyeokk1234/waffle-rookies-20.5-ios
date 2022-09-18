//
//  TaskCell.swift
//  seminar-1-ios-version2
//
//  Created by 최성혁 on 2022/09/19.
//

import Foundation
import UIKit

class TaskCell : UITableViewCell {
    var taskModel : TaskModel?
    var todoListViewModel : TodoListViewModel?
    let doneButton = UIButton()
    
    override var reuseIdentifier: String? {
        return "TableViewCell"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "TableViewCell")
        
        self.contentView.backgroundColor = .lightGray

        doneButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)

        self.contentView.addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            doneButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            doneButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20)
        ])
        
        doneButton.addTarget(self, action: #selector(tapDoneButton), for: .touchUpInside)
    }
    
    @objc func tapDoneButton() {
        self.taskModel!.isDone = true
        changeAppearance()
        saveAllData()
    }
    
    func changeAppearance() {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: (self.textLabel?.text)!)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        self.textLabel?.attributedText = attributeString
        doneButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
    }
    
    func configure(tm: TaskModel, tvm: TodoListViewModel) {
        self.todoListViewModel = tvm
        self.taskModel = tm
        self.textLabel?.text = tm.content
        
        if self.taskModel!.isDone! {
            changeAppearance()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func saveAllData() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(todoListViewModel!.tasks)
            UserDefaults.standard.set(data, forKey: "prevList")
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
}
