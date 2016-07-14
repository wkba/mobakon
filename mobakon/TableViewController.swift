//
//  TableViewController.swift
//  mobakon
//
//  Created by wakabashi on 2016/07/15.
//  Copyright © 2016年 wakabayashi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TableViewController: UITableViewController {
    
    var fetchFrom: String?
    var parent: UIViewController?
    var entries: [Entry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.registerNib(UINib(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedTableViewCell")
        
        Alamofire.request(.GET, fetchFrom!).responseJSON { response in
            if let values = response.result.value {
                JSON(values)["responseData"]["feed"]["entries"].forEach {i,value in
                    self.entries.append(Entry(
                        title: value["title"].string!,
                        desc: value["content"].string!,
                        link: value["link"].string!
                        ))
                }
                self.tableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.entries.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FeedTableViewCell", forIndexPath: indexPath) as! FeedTableViewCell
        let entry = self.entries[indexPath.row]
        cell.title.text = entry.title
        cell.desc.text = entry.desc
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.entry = self.entries[indexPath.row]
        parent!.navigationController!.pushViewController(detailViewController , animated: true)
    }
}