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
    private let newsSearchTF = UITextField()
    private let newsSearchButton = UIButton()

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
        
        self.view.addSubview(newsSearchTF)
        newsSearchTF.autocorrectionType = .no
        newsSearchTF.autocapitalizationType = .none
        newsSearchTF.borderStyle = .line
        
        newsSearchTF.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newsSearchTF.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            newsSearchTF.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            newsSearchTF.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -80),
            newsSearchTF.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        self.view.addSubview(newsSearchButton)
        newsSearchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newsSearchButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            newsSearchButton.leadingAnchor.constraint(equalTo: self.newsSearchTF.trailingAnchor, constant: 0),
            newsSearchButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            newsSearchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        self.view.addSubview(tableView)
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.estimatedRowHeight = 130;
        tableView.register(NewsTableCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.newsSearchTF.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        var config = UIButton.Configuration.filled()
        config.titleTextAttributesTransformer =
          UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.preferredFont(forTextStyle: .headline)
            return outgoing
          }
        config.title = "Search"
        newsSearchButton.configuration = config
        newsSearchButton.addTarget(self, action: #selector(search), for: .touchUpInside)
    }
    
    @objc func search() {
        let semaphore = DispatchSemaphore(value: 0)
        
        if let keyword : String = newsSearchTF.text {
            self.viewModel.sendRequest(keyword: keyword) { response in
                self.viewModel.news = response
                semaphore.signal()
                
                DispatchQueue.main.async {
                    semaphore.wait()
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
        let title = viewModel.getTitle(index: indexPath.row)
        let date = viewModel.getDate(index: indexPath.row)
        cell.configure(title: title, date: date)
        cell.titleLabel.sizeToFit()
        cell.sizeToFit()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return UITableView.automaticDimension
    }
    
    private func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

