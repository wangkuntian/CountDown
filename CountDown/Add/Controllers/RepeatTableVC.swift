//
//  RepeatTableVC.swift
//  CountDown
//
//  Created by 王坤田 on 2017/11/6.
//  Copyright © 2017年 王坤田. All rights reserved.
//

import UIKit

class RepeatTableVC: UITableViewController {
    
    let titles : [String] = ["不重复","每年","每月","每周"]
    
    var lastSelectedIndexPath = NewDay.current.repeatIndexPath

    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.title = "重复"
        
        self.tableView.register(RepeatTableCell.classForCoder(), forCellReuseIdentifier: RepeatTableCell.cellID)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.titles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepeatTableCell.cellID, for: indexPath) as! RepeatTableCell

        cell.titleLabel.text = self.titles[indexPath.row]
        
        if lastSelectedIndexPath == indexPath {
            
            cell.selectedImageView.isHidden = false
            
        }

        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if lastSelectedIndexPath != indexPath {
            
            let lastCell = tableView.cellForRow(at: lastSelectedIndexPath) as! RepeatTableCell
            lastCell.selectedImageView.isHidden = true
            
            let cell = tableView.cellForRow(at: indexPath) as! RepeatTableCell
            cell.selectedImageView.isHidden = false
            
            
        }
        
        lastSelectedIndexPath = indexPath
        
        NewDay.current.repeatIndexPath = indexPath
        NewDay.current.repeat = self.titles[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            
            self.navigationController?.popViewController(animated: true)
            
        }
        
        
        
    }

}
