//
//  MainVC.swift
//  CountDown
//
//  Created by 王坤田 on 2017/10/27.
//  Copyright © 2017年 王坤田. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var backgroundImageView : UIImageView!
    
    var dayView : DayView!
    
    var tableView : UITableView!
    
    var days : [Day] = []
    
    var day : Day?
    
    let navigationBarHeight : CGFloat = 54
    
    let headerViewHeight : CGFloat = 610 * heightScale
    
    var footerViewHeight : CGFloat = 0
    
    let cellHeight : CGFloat = 130 * heightScale
    
    var tableFooterView : UIView!
    
    var emptyView : EmptyView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: NSNotification.Name.init("addNewDay"), object: nil)

        initViews()
        
        initData()
    }
    
    //MARK:- 刷新数据
    @objc func refreshData() {
        
        initData()
        
    }
    
    //MARK:- 初始化界面
    func initViews() {
        
        initNavBar()
        
        initMainView()
        
        initTableView()
        
        
        
    }
    
    
    //MARK: - 初始化导航栏
    func initNavBar() {
        
        self.navigationItem.title = "Count Down"
        
        let navigationBar : UINavigationBar = (self.navigationController?.navigationBar)!
        
        let frame = navigationBar.frame
        
        navigationBar.frame = CGRect(x: 0, y: 0, width: frame.width, height: navigationBarHeight)
    
        
        footerViewHeight = screenSize.height - navigationBarHeight - headerViewHeight
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.titleTextAttributes = [NSAttributedStringKey.font : UIFont(name: "Savoye LET", size: 38)!,
                                             NSAttributedStringKey.foregroundColor : UIColor.white]
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(add))
        let rightBarButton = UIBarButtonItem.createBarButtonItem(with: #imageLiteral(resourceName: "ic_add"), and: tap)
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(), style: .plain, target: nil, action: nil)
    }
    
    //MARK:- 初始化主界面
    func initMainView() {
        
        backgroundImageView = UIImageView()
        self.view.addSubview(backgroundImageView)
        
        backgroundImageView.snp.makeConstraints { (make) in
            
            make.left.right.top.bottom.equalTo(0)
            
        }
        backgroundImageView.image = #imageLiteral(resourceName: "bg_1")
        backgroundImageView.contentMode = .scaleAspectFill
        
        dayView = DayView()
        self.view.addSubview(dayView)
        dayView.snp.makeConstraints { (make) in
            
            make.top.equalTo(navigationBarHeight)
            make.left.right.equalTo(0)
            make.height.equalTo(headerViewHeight)
            
        }
        dayView.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(showDetailVC))
        dayView.addGestureRecognizer(tap)
        
    }
    
    
    
    //MARK: - Add New Day
    @objc func add() {
        
        let vc = NewDayTableVC(style: .grouped)
        
        self.present(UINavigationController.init(rootViewController: vc), animated: true, completion: nil)
        
    }
    
    //MARK: - 初始化TableView
    func initTableView() {
        
        tableView = UITableView()
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(navigationBarHeight)
            
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: headerViewHeight, left: 0, bottom: 0, right: 0)
        
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.addObserver(self, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.new, context: nil)
        
        tableView.register(DayTableCell.classForCoder(), forCellReuseIdentifier: DayTableCell.cellID)
        
        emptyView = EmptyView()
        self.view.addSubview(emptyView)
        emptyView.snp.makeConstraints { (make) in
            
            make.top.equalTo(0)
            make.left.right.equalTo(0)
            make.height.equalTo(headerViewHeight)
            
        }
        
        tableFooterView = MyView()
        self.view.addSubview(tableFooterView)
        tableFooterView.snp.makeConstraints { (make) in
            
            make.bottom.left.right.equalTo(0)
            make.height.equalTo(footerViewHeight)
            
        }
        tableFooterView.backgroundColor = UIColor.cellColor
     
        
    }
    
    //MARK: - Show Detail VC
    @objc func showDetailVC() {
        
        if self.day != nil {
            
            let vc = DayDetailVC()
            vc.day = self.day!
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    //MARK:- TableView Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DayTableCell.cellID, for: indexPath) as! DayTableCell
        
        let day = self.days[indexPath.row]
        
        cell.setData(day: day)
        
        if self.days.count <= 1 {
            
            cell.line.isHidden = true
            
        }else if indexPath.row == self.days.count - 1{
            
            cell.line.isHidden = true
            
        }else {
            
            cell.line.isHidden = false
            
        }
        
        return cell
    }
    
    
    //MARK:- TableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return cellHeight
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DayDetailVC()
        
        let temp : Day = self.days[indexPath.row]
        
        vc.day = temp
        //vc.dayView.setData(day: temp)
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .default, title: "删除") { (action, indexPath) in
            let temp = self.days[indexPath.row]
            
            if CoreDataTool.deleteDay(id: temp.id) {
                
                self.days.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                
                self.footerViewHeight = screenSize.height - self.navigationBarHeight - self.headerViewHeight - CGFloat(self.days.count) * self.cellHeight
                
                self.tableFooterView.snp.remakeConstraints { (make) in
                    
                    make.bottom.left.right.equalTo(0)
                    make.height.equalTo(self.footerViewHeight)
                    
                }
                
                if self.days.count <= 0 {
                    
                    self.emptyView.isHidden = false
                    self.dayView.isHidden = true
                }
                
                
            }
            
            
            
            
        }
        
        return [deleteAction]
    }
    
    //MARK:- 初始化数据
    func initData() {
        
        let tempData = CoreDataTool.getAllDays()
        self.days = tempData
        
        if self.days.count > 0 {
            
            self.day = self.days.first
            self.dayView.isHidden = false
            self.dayView.setData(day: self.day!)
            
            footerViewHeight = screenSize.height - navigationBarHeight - headerViewHeight - CGFloat(self.days.count) * cellHeight
            tableFooterView.snp.remakeConstraints { (make) in
                
                make.bottom.left.right.equalTo(0)
                make.height.equalTo(footerViewHeight)
                
            }
            self.emptyView.isHidden = true
            self.dayView.isHidden = false
            self.tableView.reloadData()

        }else {
            
            self.emptyView.isHidden = false
            self.dayView.isHidden = true
        }
        
        
        
    }
    
    
    //MARK: - 修改状态栏颜色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "contentOffset" {
            
            let offset = change![NSKeyValueChangeKey.newKey] as? CGPoint
            
            if offset != nil {
                
                print(offset!.y)
                
                let height : CGFloat = 305.0
                
                if offset!.y <= -height {
                    
                    if !self.emptyView.isHidden {
                        
                        self.emptyView.snp.remakeConstraints({ (make) in
                            
                            make.top.equalTo(navigationBarHeight - height - offset!.y)
                            make.left.right.equalTo(0)
                            make.height.equalTo(headerViewHeight)
                            
                        })
                        
                        
                    }
                    
                    self.dayView.snp.remakeConstraints({ (make) in
                        
                        make.top.equalTo(navigationBarHeight - height - offset!.y)
                        make.left.right.equalTo(0)
                        make.height.equalTo(headerViewHeight)
                        
                    })
                    
                    tableFooterView.snp.remakeConstraints { (make) in
                        
                        make.bottom.left.right.equalTo(0)
                        make.height.equalTo(footerViewHeight + height + offset!.y)
                        
                    }
                    
                }else {
                    
                    tableFooterView.snp.remakeConstraints { (make) in
                        
                        make.bottom.left.right.equalTo(0)
                        make.height.equalTo(footerViewHeight + height + offset!.y)
                        
                    }
                    
                }
                
            }
            
        }
        
    }

}
