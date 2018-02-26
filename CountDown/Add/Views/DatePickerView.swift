//
//  DatePickerView.swift
//  CountDown
//
//  Created by 王坤田 on 2017/11/2.
//  Copyright © 2017年 王坤田. All rights reserved.
//

import UIKit

protocol  DatePickerViewDeleagte{
    
    func datePickerValueChanged(date : String, dateString : String)
    
}

typealias Handle = (String) -> Void

class DatePickerView: UIView {
    
    var calendarSegment : UISegmentedControl!
    
    var datePicker : UIDatePicker!
    
    var date : String!
    
    var delegate : DatePickerViewDeleagte?
    
    static let flag = 100000
    
    var isShowed : Bool {
        
        get {
            
            let view = UIApplication.shared.keyWindow?.viewWithTag(DatePickerView.flag) as? DatePickerView
            
            return view != nil
            
        }
        
    }

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        initViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initViews() {
        
        calendarSegment = UISegmentedControl(items: ["公历","农历"])
        self.addSubview(calendarSegment)
        
        calendarSegment.snp.makeConstraints { (make) in
            
            make.left.right.top.right.equalTo(0)
            make.height.equalTo(80 * heightScale)
            
        }
        
        
        calendarSegment.tintColor = UIColor.clear
        calendarSegment.selectedSegmentIndex = 0
        calendarSegment.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.black], for: .selected)
        calendarSegment.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.lightGray, NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16, weight: .regular)], for: .normal)
        
        calendarSegment.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        
        calendarSegment.addTarget(self, action: #selector(calendarChanged), for: .valueChanged)
        
        
        datePicker =  UIDatePicker()
        self.addSubview(datePicker)
        
        datePicker.snp.makeConstraints { (make) in
            
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(calendarSegment.snp.bottom)
            
        }
        
        datePicker.backgroundColor = UIColor.init(white: 0.99, alpha: 1)
        datePicker.datePickerMode = .date
        
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        
        
    }
    
    @objc func datePickerValueChanged() {
        
        var dateString = ""
        
        let date = datePicker.date
        
        let formatter = DateFormatter()
        
        if calendarSegment.selectedSegmentIndex == 0 {
            
            formatter.dateFormat = "YYYY-MM-dd"
            
            dateString = formatter.string(from: date)
            
        }else {
            
            formatter.dateFormat = "YYYY"
            let year = formatter.string(from: date)
            var calendar = Calendar.init(identifier: .chinese)
            calendar.locale = Locale.init(identifier: "zh_CN")
            let dateComponents = calendar.dateComponents([.year,.day,.month,], from: date)
            let month : String = calendar.monthSymbols[dateComponents.month! - 1]
            let day : String = Days[dateComponents.day! - 1]
            dateString = "\(year)年 \(month) \(day)"
            
        }
        
        formatter.dateFormat = "YYYY-MM-dd"
        
        delegate?.datePickerValueChanged(date: formatter.string(from: date), dateString: dateString)
        
    }
    
    @objc func calendarChanged() {
        
        switch calendarSegment.selectedSegmentIndex {
            
        case 0:
            
            datePicker.calendar = Calendar.current
            

        default:
            
            datePicker.calendar = Calendar.init(identifier: .chinese)
            datePicker.locale = Locale.init(identifier: "zh_CN")
            

        }
        
    }

    class func show() -> DatePickerView {
        
        let datePickerbView = DatePickerView()
        datePickerbView.tag = flag
        UIApplication.shared.keyWindow?.addSubview(datePickerbView)
        
        datePickerbView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height / 3)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            
            
            
            datePickerbView.frame = CGRect(x: 0, y: screenSize.height / 3 * 2, width: screenSize.width, height: screenSize.height / 3)
            
        }, completion: nil)
        
        
        return datePickerbView
    }
    
    func disMiss() {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            
            self.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height / 3)
            
            
        }) { (finished) in
            
            if finished {
                
                self.removeFromSuperview()
                
            }
            
        }
        
        
        
        
    }

}
