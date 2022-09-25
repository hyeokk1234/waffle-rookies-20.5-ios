//
//  ListViewController.swift
//  seminar-1-ios-version2
//
//  Created by 최성혁 on 2022/09/19.
//

import Foundation
import UIKit

class ListViewController: UIViewController {
    let todoListViewModel = TodoListViewModel()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadAllData()
        setupLayout()
        applyDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        saveAllData()
        self.tableView.reloadData()
    }
}

extension ListViewController {
    private func setupLayout() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        tableView.register(TaskCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addNewTask))
    }
    
    @objc func addNewTask() {
        let addNewTaskVC = AddNewTaskViewController(todoListViewModel: todoListViewModel)
        self.navigationController?.pushViewController(addNewTaskVC, animated: true)
    }
    
    private func applyDesign() {
        self.view.backgroundColor = .white
        tableView.backgroundColor = .darkGray
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoListViewModel.getNum()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TaskCell()
        cell.configure(tm: todoListViewModel.tasks[indexPath.row], tvm: todoListViewModel)
        return cell
    }
}

//UserDefaults 관련
extension ListViewController {
    func saveAllData() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(todoListViewModel.tasks)
            UserDefaults.standard.set(data, forKey: "prevList")
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
    
    func loadAllData() {
        //전의 데이터 있으면 불러오기
        if let prevList = UserDefaults.standard.data(forKey: "prevList") {
            do {
                let decoder = JSONDecoder()
                todoListViewModel.tasks =  try decoder.decode([TaskModel].self, from: prevList)
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
    }
}
