//
//  NewDayTableVC.swift
//  CountDown
//
//  Created by 王坤田 on 2017/10/30.
//  Copyright © 2017年 王坤田. All rights reserved.
//

import UIKit

class NewDayTableVC: UITableViewController, DatePickerViewDeleagte, UITextFieldDelegate {
    
    var titles : [[String]] = [["标题","日期","分类"],["设为封面","重复"]]
    
    var titleTextField : UITextField!
    
    var dateLabel : UILabel!
    
    var typeLabel : UILabel?
    
    var setCoverSwitch : UISwitch!
    
    var repeatedLabel : UILabel?
    
    var datePicker : DatePickerView?
    
    var typeName : String = NewDay.current.type
    
    var repeated : String = NewDay.current.repeat
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        typeName = NewDay.current.type
        typeLabel?.text = typeName
        self.typeLabel?.setNeedsLayout()
        self.typeLabel?.setNeedsDisplay()
        
        repeated = NewDay.current.repeat
        repeatedLabel?.text = repeated
        repeatedLabel?.setNeedsDisplay()
        repeatedLabel?.setNeedsLayout()
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "新建"
        
        initViews()
    }
    
    //MARK: - 初始化视图
    func initViews() {
        
        initNavBar()
        
        configTableView()
        
        
    }
    
    //MARK: - 初始化导航栏
    func initNavBar() {
        
        let navigationBar : UINavigationBar = (self.navigationController?.navigationBar)!
        
        let frame = navigationBar.frame
        
        navigationBar.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height + 30 * heightScale)
        
        let leftBarTap = UITapGestureRecognizer(target: self, action: #selector(disMiss))
        
        let leftBarButton = UIBarButtonItem.createBarButtonItem(with: #imageLiteral(resourceName: "ic_x"), and: leftBarTap)
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        let rightBarTap = UITapGestureRecognizer(target: self, action: #selector(addNewDay))
        
        let rightBarButton = UIBarButtonItem.createBarButtonItem(with: #imageLiteral(resourceName: "ic_check"), and: rightBarTap)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(), style: .plain, target: nil, action: nil)
        
        
    }
    
    //MARK: - 配置TableView
    func configTableView() {
        
        //self.tableView.backgroundColor = UIColor.tableBgColor
        
        //self.tableView.tableFooterView = UIView(frame: .zero)
        
        self.tableView.register(NewDayTableCell.classForCoder(), forCellReuseIdentifier: NewDayTableCell.cellID)
        
    }
    
    
    //MARK: - 关闭视图
    @objc func disMiss() {
        
        if datePicker != nil&&(datePicker?.isShowed)!{
            
            datePicker?.disMiss()
            
        }
        if self.titleTextField.isFirstResponder {
            
            self.titleTextField.resignFirstResponder()
            
        }
        self.dismiss(animated: true, completion: nil)
        
    }
    
    //MARK: - 增加日子
    @objc func addNewDay() {
        
        let title : String? = self.titleTextField.text
        
        if (title?.isNotEmptyOrWhiteSpaces)! {
            
            NewDay.current.title = title!
            
            var day = Day()
            day.date = NewDay.current.date
            day.dateString = NewDay.current.dateString
            day.id = Date.longCurrentDateString
            day.isCover = NewDay.current.isCover
            day.repeat = NewDay.current.repeat
            day.title = NewDay.current.title
            day.typeImage = NewDay.current.typeImage
            day.typeName = NewDay.current.type
            
            let flag =  CoreDataTool.addNewDay(day: day)
            
            if flag {
                
                if self.setCoverSwitch.isOn {
                    
                    let userDefaults = UserDefaults.standard
                    userDefaults.setValue(day.id, forKey: "dayId")
                    userDefaults.synchronize()
                    
                    UIApplication.shared.applicationIconBadgeNumber = Int(day.date.getDay)!
                    
                }
                
                
                
                NotificationCenter.default.post(.init(name: Notification.Name.init("addNewDay")))
                
                NewDay.reset()
                self.disMiss()
                
            }
            
        }
        
        
        
        
    }

   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return 3
            
        }
        
        return 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NewDayTableCell.cellID, for: indexPath) as! NewDayTableCell
        
        cell.titleLabel.text = self.titles[indexPath.section][indexPath.row]
        
        switch (indexPath.section, indexPath.row) {
            
        case (0,0):
            
            titleTextField = UITextField()
            cell.contentView.addSubview(titleTextField)
            
            titleTextField.snp.makeConstraints({ (make) in
                
                make.left.equalTo(cell.titleLabel.snp.right)
                make.right.equalTo(-30 * widthScale)
                make.centerY.equalTo(cell.contentView)
                
            })
            
            titleTextField.clearButtonMode = .whileEditing
            titleTextField.placeholder = "Title"
            titleTextField.textAlignment = .right
            titleTextField.textColor = UIColor.textColor
            titleTextField.delegate = self
            
        case (0,1):
            
            dateLabel = UILabel()
            cell.contentView.addSubview(dateLabel)
            
            dateLabel.snp.makeConstraints({ (make) in
                
                make.left.equalTo(cell.titleLabel.snp.right)
                make.right.equalTo(-30 * widthScale)
                make.centerY.equalTo(cell.contentView)
                
            })
            dateLabel.textAlignment = .right
            dateLabel.text = Date.currentDateString
            dateLabel.textColor = UIColor.textColor
            
        case (0,2):
            
            let imageView = UIImageView()
            cell.contentView.addSubview(imageView)
            
            imageView.snp.makeConstraints({ (make) in
                
                make.right.equalTo(-30 * widthScale)
                make.height.width.equalTo(40 * widthScale)
                make.centerY.equalTo(cell.contentView)
                
            })
            imageView.image = #imageLiteral(resourceName: "ic_arrow")
            
            typeLabel = UILabel()
            cell.contentView.addSubview(typeLabel!)
            
            typeLabel?.snp.makeConstraints({ (make) in
                
                make.left.equalTo(cell.titleLabel.snp.right)
                make.right.equalTo(imageView.snp.left).offset(-12 * widthScale)
                make.centerY.equalTo(cell.contentView)
                
            })
            typeLabel?.textAlignment = .right
            typeLabel?.text = typeName
            typeLabel?.textColor = UIColor.textColor
            
        case (1,0):
            
            setCoverSwitch = UISwitch()
            cell.contentView.addSubview(setCoverSwitch)
            
            setCoverSwitch.snp.makeConstraints({ (make) in
                
                make.right.equalTo(-30 * widthScale)
                make.width.equalTo(100 * widthScale)
                make.centerY.equalTo(cell.contentView)
                
            })
            
            setCoverSwitch.isOn = false
            setCoverSwitch.onTintColor = UIColor.textColor
            
        case (1,1):
            
            let imageView = UIImageView()
            cell.contentView.addSubview(imageView)
            
            imageView.snp.makeConstraints({ (make) in
                
                make.right.equalTo(-30 * widthScale)
                make.height.width.equalTo(40 * widthScale)
                make.centerY.equalTo(cell.contentView)
                
            })
            imageView.image = #imageLiteral(resourceName: "ic_arrow")
            
            repeatedLabel = UILabel()
            cell.contentView.addSubview(repeatedLabel!)
            
            repeatedLabel?.snp.makeConstraints({ (make) in
                
                make.left.equalTo(cell.titleLabel.snp.right)
                make.right.equalTo(imageView.snp.left).offset(-12 * widthScale)
                make.centerY.equalTo(cell.contentView)
                
            })
            
            repeatedLabel?.textAlignment = .right
            repeatedLabel?.text = repeated
            repeatedLabel?.textColor = UIColor.textColor
        default:
            break
        }
        
        
        
        return cell
    }
    
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90 * heightScale
        
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0
        
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        if indexPath.section == 1 && indexPath.row == 0 {
            
            return nil
            
        }
        
        return indexPath
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch (indexPath.section, indexPath.row) {
            
        case (0,0):
            
            if !self.titleTextField.isFirstResponder {
                
                self.titleTextField.becomeFirstResponder()
                
            }
            
        case (0,1):
            
            self.titleTextField.resignFirstResponder()
            
            if datePicker != nil {
                
                if !(datePicker?.isShowed)! {
                    
                    
                    datePicker = DatePickerView.show()
                    datePicker?.delegate = self
                    
                }
                
            }else {
                
                datePicker = DatePickerView.show()
                datePicker?.delegate = self
            }
            
        case (0,2):
            
            if datePicker != nil && (datePicker?.isShowed)!{
                
                datePicker?.disMiss()
                
            }
            
            let vc = TypeTableVC(style: .grouped)
            self.navigationController?.pushViewController(vc, animated: true)
            
        case (1,1):
            
            if datePicker != nil && (datePicker?.isShowed)!{
                
                datePicker?.disMiss()
                
            }
            
            let vc = RepeatTableVC(style: .grouped)
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        default:
            
            break
        
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    //MARK: - DatePickerView Delegate
    func datePickerValueChanged(date: String, dateString: String) {
        
        self.dateLabel.text = dateString
        NewDay.current.date = date
        NewDay.current.dateString = dateString
        
    }
    
    //MARK: - ScrollView Delegate
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        if datePicker != nil && (datePicker?.isShowed)!{
            
            datePicker?.disMiss()
            
        }
        
        if self.titleTextField.isFirstResponder {
            
             self.titleTextField.resignFirstResponder()
            
        }
        
    }
    
    //MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if datePicker != nil && (datePicker?.isShowed)!{
            
            datePicker?.disMiss()
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
