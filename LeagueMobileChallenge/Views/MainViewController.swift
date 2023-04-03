//
//  MainViewController.swift
//  LeagueMobileChallenge
//
//  Created by banie setijoso on 2023-03-31.
//  Copyright © 2023 Banie Setijoso. All rights reserved.
//

import Foundation
import UIKit
import Combine

class MainViewController: UITableViewController {
    
    private lazy var dataSource = makeDataSource()
    private let presenter = MainPresenter()
    private var subscribers = [AnyCancellable]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts"
        
        tableView.register(UINib(nibName: "PostTableCell", bundle: nil), forCellReuseIdentifier: "PostTableCell")
        tableView.dataSource = dataSource
        
        presenter.delegate = self
        presenter.listChanged.sink { [weak self] snapshot in
            self?.dataSource.apply(snapshot)
        }.store(in: &subscribers)
        
        Task.detached {
            await self.presenter.load()
        }
    }
    
    func makeDataSource() -> UITableViewDiffableDataSource<Int, PostItem> {
        return UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, postItem in
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableCell", for: indexPath) as? PostTableCell
            cell?.decorate(with: postItem)
            return cell
        }
    }
}

extension MainViewController: MainPresenterDelegate {
    func tokenFetchDidFail(with error: Error) {
        let alert = UIAlertController(title: "Getting user token failed", message: "Please try again later", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
    
    func loadDidFail(with error: Error) {
        let alert = UIAlertController(title: "Failed in fetching for posts", message: "Please try again later", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
}
