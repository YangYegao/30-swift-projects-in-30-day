//
//  ViewController.swift
//  Day05_PullToRefresh
//
//  Created by 杨业高(外包) on 2018/5/29.
//  Copyright © 2018年 杨业高(外包). All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    var table : UITableView!
    var dataSource = Array<Date>()
    var refresh = UIRefreshControl()
    var row = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        let rect = CGRect(x: 0, y: 20, width: self.view.frame.width, height: self.view.frame.height-20)
        table = UITableView(frame:rect , style: .plain)
        table.delegate = self
        table.dataSource = self
        self.view.addSubview(table)
        
        refresh.attributedTitle = NSAttributedString(string: "住手！再拉我的裤子就要掉啦")
        refresh.addTarget(self, action: #selector(pullToRefresh), for:UIControlEvents.valueChanged)
        table.addSubview(refresh)
        
        addNewElementToArray()
        table.reloadData()
    }
    
    func addNewElementToArray() {
        dataSource.insert(NSDate() as Date, at: row)
        row += 1
    }
    
    @objc func pullToRefresh() {
        addNewElementToArray()
        refresh.endRefreshing()
        table.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateStr = dateFormatter.string(from: dataSource[indexPath.row])
        cell.textLabel?.text = dateStr
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

