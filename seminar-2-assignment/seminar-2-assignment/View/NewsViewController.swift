//
//  ViewController.swift
//  seminar-2-assignment
//
//  Created by 최성혁 on 2022/09/23.
//

import UIKit

class NewsViewController: UIViewController {
    private let viewModel : NewsViewModel
    private let tableView = UITableView()
    private let newsSearchBar = UISearchBar()

    init(vm: NewsViewModel) {
        viewModel = vm;

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpLayout()
    }
}

extension NewsViewController {
    func setUpLayout() {
        self.navigationItem.title = "뉴스 헤드라인"
        newsSearchBar.delegate = self

        self.view.addSubview(newsSearchBar)
        newsSearchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newsSearchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            newsSearchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            newsSearchBar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        self.view.addSubview(tableView)
        tableView.backgroundColor = .darkGray
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.newsSearchBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        tableView.register(NewsTableCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension NewsViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("***************!!!SEARCH BUTTON CLICKED!!!***************")
        print("검색어: " + searchBar.text! + "\n\n")
        let flag : Bool
        
        if let keyword : String = searchBar.text {
            flag = self.viewModel.sendRequest(keyword: keyword)
        } else {
            return
        }
        
        if (flag) {
            self.tableView.reloadData()
        }
    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNum()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! NewsTableCell
        cell.backgroundColor = .lightGray
        cell.configure(title: "bsj", date: "bsjdate")
        return cell
    }
}
