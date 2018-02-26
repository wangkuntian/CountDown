//
//  TypeTableVC.swift
//  CountDown
//
//  Created by 王坤田 on 2017/11/3.
//  Copyright © 2017年 王坤田. All rights reserved.
//

import UIKit

class TypeTableVC: UITableViewController {
    
    var types : [Type] = []
    var sections : Int = 2
    
    var lastSelectedIndexPath : IndexPath = NewDay.current.typeIndexPath
    
    //MARK:-
    override func viewWillAppear(_ animated: Bool) {
        
        initData()
        
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "分类"
        
        initViews()
        
    }
    
    
    //MARK: - 初始化视图
    func initViews() {
        
        initNavBar()
        
        configTableView()
    }
    
    
    //MARK: - 初始化数据
    func initData() {
        
        self.types = CoreDataTool.getAllTypes()
        self.tableView.reloadData()
        
    }
    
    //MARK: - 初始化导航栏
    func initNavBar() {
        
        let rightBarTap = UITapGestureRecognizer(target: self, action: #selector(editing))
        
        let rightBarButton = UIBarButtonItem.createBarButtonItem(with: #imageLiteral(resourceName: "ic_list"), and: rightBarTap, width: 45 * widthScale)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    
    //MARK: - 配置TableView
    func configTableView() {
        
        self.tableView.register(TypeTableCell.classForCoder(), forCellReuseIdentifier: TypeTableCell.cellID)
        
    }
    
    //MARK: - 分类编辑
    @objc func editing() {
        
        self.tableView.setEditing(true, animated: true)
        
        
        let rightBarTap = UITapGestureRecognizer(target: self, action: #selector(edited))
        
        let rightBarButton = UIBarButtonItem.createBarButtonItem(with: #imageLiteral(resourceName: "ic_check"), and: rightBarTap)
        
        self.navigationItem.setRightBarButton(rightBarButton, animated: true)
        
        sections -= 1
        
        self.tableView.deleteSections(IndexSet.init(integer: 1), with: .middle)
        
        
    }
    
    @objc func edited() {
        
        self.tableView.setEditing(false, animated: true)
        
        let rightBarTap = UITapGestureRecognizer(target: self, action: #selector(editing))
        
        let rightBarButton = UIBarButtonItem.createBarButtonItem(with: #imageLiteral(resourceName: "ic_list"), and: rightBarTap, width: 45 * widthScale)
        self.navigationItem.setRightBarButton(rightBarButton, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            
            self.sections += 1
            
            let indexPath = IndexPath.init(row: 0, section: 1)
            
            self.tableView.reloadData()
            
            self.tableView.reloadRows(at: [indexPath], with: .bottom)
            
            
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return sections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return self.types.count + 1
            
        }
        
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 1 {
            
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            
            let titleLabel = UILabel()
            cell.contentView.addSubview(titleLabel)
            
            titleLabel.snp.makeConstraints({ (make) in
                
                make.center.equalTo(cell.contentView)
                
            })
            titleLabel.text = "新分类"
            
            return cell
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TypeTableCell.cellID, for: indexPath) as! TypeTableCell
        
        if lastSelectedIndexPath == indexPath {
            
            cell.selectedImageView.isHidden = false
            
        }
        
        if indexPath.row == 0 {
            
            cell.titleLabel.text = "事件"
            cell.iconImageView.image = #imageLiteral(resourceName: "ic_calendar")
            
        }else {
            
            let temp = self.types[indexPath.row - 1]
            
            cell.titleLabel.text = temp.name
            cell.iconImageView.image = UIImage(named: temp.image)
            
        }
        
        return cell
    }
    
    
    //MARK: - Table View Delegate
    
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        
        if indexPath.row == 0 {
            
            return UITableViewCellEditingStyle.none
            
        }
        
        return UITableViewCellEditingStyle.delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let temp = self.types[indexPath.row - 1]
            
            let result = CoreDataTool.deleteType(id: temp.id)
            
            if result {
                
                self.types.remove(at: indexPath.row - 1)
                
                tableView.deleteRows(at: [indexPath], with: .automatic)
                
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        if indexPath.row == 0 {
            
            return false
            
        }
        
        return true
        
    }
    
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        
        if proposedDestinationIndexPath.section == 0 && proposedDestinationIndexPath.row == 0 {
            
            let indexPath = IndexPath.init(row: 1, section: 0)
            
            return indexPath
            
        }
        
        return proposedDestinationIndexPath
    }
    

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        if indexPath.section == 1 {
            
            return false
            
        }
        
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        let fromIndex = fromIndexPath.row - 1
        let toIndex = to.row - 1
        
        let temp = self.types[fromIndex]
        self.types[fromIndex] = self.types[toIndex]
        
        self.types[toIndex] = temp

    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        return "删除"
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        switch indexPath.section {
            
        case 0:
            
            if lastSelectedIndexPath != indexPath {
                
                let lastCell = tableView.cellForRow(at: lastSelectedIndexPath) as! TypeTableCell
                lastCell.selectedImageView.isHidden = true
                
                let cell = tableView.cellForRow(at: indexPath) as! TypeTableCell
                cell.selectedImageView.isHidden = false
                
            }
            
            lastSelectedIndexPath = indexPath
            
            NewDay.current.typeIndexPath = indexPath
            
            if indexPath.row == 0 {
                
                NewDay.current.type = "事件"
                NewDay.current.typeImage = "ic_calendar.png"
                
            }else {
                
                NewDay.current.type = self.types[indexPath.row - 1].name
                NewDay.current.typeImage = self.types[indexPath.row - 1].image
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                
                self.navigationController?.popViewController(animated: true)
                
                
            })
            
            
            
            
        default:
            
            let vc = NewTypeTableVC(style: .grouped)
            let nav = UINavigationController(rootViewController: vc)
            self.present(nav, animated: true, completion: nil)
            
            break
            
        }

        
        
    }

}
