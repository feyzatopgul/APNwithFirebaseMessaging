//
//  TableViewController.swift
//  APNwithFBMessaging
//
//  Created by fyz on 10/22/22.
//

import UIKit

class TableViewController: UITableViewController {
    
    let news1 = News(title: "Why do babies cry?", description: "This is the only way at this time to communicate with you")
    let news2 = News(title: "A kitten is rescued from the tree", description: "Santa Clara fire department rescued a kitten from a tree yesterday")
    
    var newsFeed = NewsFeed.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        newsFeed.addNews(news: news1)
        newsFeed.addNews(news: news2)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return newsFeed.newsFeed.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        cell.titleLabel.text = newsFeed.newsFeed[indexPath.row].title
        cell.descriptionLabel.numberOfLines = 10
        cell.descriptionLabel.text = newsFeed.newsFeed[indexPath.row].description
        return cell
    }

}
