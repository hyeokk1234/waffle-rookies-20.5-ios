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
        self.navigationItem.title = "뉴스 헤드라인"
        newsSearchBar.delegate = self

        self.view.addSubview(newsSearchBar)
        newsSearchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newsSearchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            newsSearchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            newsSearchBar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
}

extension NewsViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search button clicked")
        
        if let keyword : String = searchBar.text {
            self.viewModel.getKeyword(keyword: keyword)
        } else {
            return
        }
    }
}

