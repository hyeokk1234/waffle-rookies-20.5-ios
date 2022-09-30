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
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.estimatedRowHeight = 130;
        tableView.register(NewsTableCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .darkGray
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.newsSearchBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
    }
}

extension NewsViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("*********************************************************")
        print("***************!!!SEARCH BUTTON CLICKED!!!***************")
        print("*********************************************************")
        print("검색어: " + searchBar.text! + "\n\n")
//        var flag = false
//
//        DispatchQueue.main.async {
//            if let keyword : String = searchBar.text {
//                flag = self.viewModel.sendRequest(keyword: keyword) { response in
//                    print("뉴스 받아온거 세팅")
//                    self.viewModel.news = response
//                }
//            } else {
//                return
//            }
//        }
//
//        DispatchQueue.main.async {
//            if (flag) {
//                print("테이블 로드")
//                self.tableView.reloadData()
//            }
//        }

        

//        main은 메인스레드. serial queue니까 하나가 끝나야 다음걸 함.
//        global()은 concurrent
        /*
         sync: 큐에 작업을 추가하고 끝날 때까지 기다리면 됨.
         async: 큐에 작업을 추가하고 다른 작업을 함
         */
        let semaphore = DispatchSemaphore(value: 0)
        
        if let keyword : String = searchBar.text {
            self.viewModel.sendRequest(keyword: keyword) { response in
                print("뉴스 받아온거 세팅")
                self.viewModel.news = response
                semaphore.signal()
                
                DispatchQueue.main.async {
                    semaphore.wait()
                    print("테이블뷰 리로드")
                    self.tableView.reloadData()
                }
            }
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
        let title = viewModel.getTitle(index: indexPath.row)
        let date = viewModel.getDate(index: indexPath.row)
        cell.configure(title: title, date: date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return UITableView.automaticDimension
    }
    
    private func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

