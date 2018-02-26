//
//  NewTypeTableVC.swift
//  CountDown
//
//  Created by 王坤田 on 2017/11/3.
//  Copyright © 2017年 王坤田. All rights reserved.
//

import UIKit
import Presentr
class NewTypeTableVC: UITableViewController, TypeImageCollectionViewDelegate, UITextFieldDelegate {
    
    let titles : [String] = ["名称","图标"]
    
    var imageName : String = "ic_calendar.png"
    
    var typeTextField : UITextField!
    
    var typeImageView : UIImageView!
    
    var collectionView : TypeImageCollectionView?

    
    //MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "新分类"
        
        initViews()
        
    }
    
    //MARK: - 初始化视图
    func initViews() {
        
        initNavBar()
        
        configTableView()
    }
    
    

    //MARK: - 初始化导航栏
    func initNavBar() {
        
        
        let leftBarTap = UITapGestureRecognizer(target: self, action: #selector(disMiss))
        
        let leftBarButton = UIBarButtonItem.createBarButtonItem(with: #imageLiteral(resourceName: "ic_x"), and: leftBarTap)
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        let rightBarTap = UITapGestureRecognizer(target: self, action: #selector(addNewType))
        
        let rightBarButton = UIBarButtonItem.createBarButtonItem(with: #imageLiteral(resourceName: "ic_check"), and: rightBarTap)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(), style: .plain, target: nil, action: nil)
        
        
        
    }
    
    //MARK: - 配置TableView
    func configTableView() {
        
        self.tableView.register(NewTypeTableCell.classForCoder(), forCellReuseIdentifier: NewTypeTableCell.cellID)
        
    }
    
    //MARK: - 关闭视图
    @objc func disMiss() {
        
        if collectionView != nil && (collectionView?.isShowed)! {
            
            collectionView?.disMiss()
            
        }
        
        if self.typeTextField.isFirstResponder {
            
            self.typeTextField.resignFirstResponder()
            
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    //MARK: - 添加新分类
    @objc func addNewType() {
        
        let name : String = self.typeTextField.text!
        
        if name.isNotEmptyOrWhiteSpaces {
            
           
            print(Date.longCurrentDateString)
            
            let level = Double(CoreDataTool.getAllTypes().count) + 1.0
            
            let type = Type(id: Date.longCurrentDateString, name: name, image: imageName, level: level)

            let result = CoreDataTool.addNewType(type: type)

            if result {

                self.disMiss()

            }
            
            
            
        }else {
            
            let controller = UIAlertController(title: nil, message: "请输入分类名称", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "好的", style: .cancel, handler: nil)
            
            controller.addAction(cancelAction)
            
            self.present(controller, animated: true, completion: nil)
            
            
        }
        
        
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NewTypeTableCell.cellID, for: indexPath) as! NewTypeTableCell
        
        cell.titleLabel.text = self.titles[indexPath.row]
        
        if indexPath.row == 0 {
            
            typeTextField = UITextField()
            cell.contentView.addSubview(typeTextField)
            
            typeTextField.snp.makeConstraints({ (make) in
            
                make.left.equalTo(cell.titleLabel.snp.right)
                make.right.equalTo(-30 * widthScale)
                make.centerY.equalTo(cell.contentView)
                
            })
            
            typeTextField.placeholder = "名称"
            typeTextField.clearButtonMode = .whileEditing
            typeTextField.textAlignment = .right
            typeTextField.textColor = UIColor.textColor
            typeTextField.delegate = self
            
        }else {
            
            typeImageView = UIImageView()
            cell.contentView.addSubview(typeImageView)
            
            typeImageView.snp.makeConstraints({ (make) in
                
                make.right.equalTo(-30 * widthScale)
                make.centerY.equalTo(cell.contentView)
                make.height.width.equalTo(55 * heightScale)
                
            })
            typeImageView.image = UIImage(named: self.imageName)
        }

        return cell
    }
    
    //MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if indexPath.row == 1 {
            
            if self.typeTextField.isFirstResponder {
                
                self.typeTextField.resignFirstResponder()
                
            }
            
            
            
            if collectionView != nil {
                
                if !(collectionView?.isShowed)! {
                    
                    collectionView = TypeImageCollectionView.show()
                    collectionView?.delegate = self
                }
                
            }else {
                
                collectionView = TypeImageCollectionView.show()
                collectionView?.delegate = self
            }
            
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: - Scroll View Delegate
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        if collectionView != nil && (collectionView?.isShowed)! {
            
            collectionView?.disMiss()
            
        }
        
        if self.typeTextField.isFirstResponder {
            
            self.typeTextField.resignFirstResponder()
            
        }
        
        
        
    }
    
    //MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if collectionView != nil && (collectionView?.isShowed)! {
            
            collectionView?.disMiss()
            
        }
        
    }
    
    //MARK: - Type Image Collection View Delegate
    
    func selectedImageDidChanged(imageName: String) {
        
        self.typeImageView.image = UIImage(named: imageName)
        self.imageName = imageName
        
    }

}
