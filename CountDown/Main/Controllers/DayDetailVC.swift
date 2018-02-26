//
//  DayDetailVC.swift
//  CountDown
//
//  Created by 王坤田 on 2017/11/20.
//  Copyright © 2017年 王坤田. All rights reserved.
//

import UIKit

class DayDetailVC: UIViewController {
    
    var dayView : DayView!
    
    var day : Day!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        initViews()
    }
    
    //MARK:- 初始化界面
    func initViews() {
        
        initNavBar()
        
        initMainView()
        
    }
    
    //MARK: - 初始化导航栏
    func initNavBar() {
        
        self.navigationItem.title = "Count Down"
        
        let navigationBar : UINavigationBar = (self.navigationController?.navigationBar)!
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        
        navigationBar.titleTextAttributes = [NSAttributedStringKey.font : UIFont(name: "Savoye LET", size: 38)!,
                                             NSAttributedStringKey.foregroundColor : UIColor.white]
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(showEditorVC))
        let rightBarButton = UIBarButtonItem.createBarButtonItem(with: #imageLiteral(resourceName: "ic_editor"), and: tap)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    //MARK: - Show VC
    @objc func showEditorVC() {
        
        
    }
    
    //MARK:- 初始化主界面
    func initMainView() {
        
        let backgroundImageView = UIImageView()
        self.view.addSubview(backgroundImageView)
        
        backgroundImageView.snp.makeConstraints { (make) in
            
            make.margins.equalTo(self.view)
            
        }
        backgroundImageView.image = #imageLiteral(resourceName: "bg_1")
        backgroundImageView.contentMode = .scaleAspectFill
        
        dayView = DayView()
        self.view.addSubview(dayView)
        dayView.snp.makeConstraints { (make) in
            
            make.center.equalTo(self.view)
            make.height.equalTo(480 * heightScale)
            make.width.equalTo(screenSize.width)
            
        }
        
        dayView.isHidden = false
        dayView.setData(day: day)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
