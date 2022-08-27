//
//  WatchlistViewController.swift
//  WatchListPro
//
//  Created by Alexander Khazzam on 7/14/22.
//

import UIKit

class WatchlistViewController: UIViewController {

    let movies: [String: String] = [:]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }

}

//MARK: - UITableViewDataSource

extension WatchlistViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

