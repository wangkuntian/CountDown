//
//  TypeImageCollectionView.swift
//  CountDown
//
//  Created by 王坤田 on 2017/11/3.
//  Copyright © 2017年 王坤田. All rights reserved.
//

import UIKit

protocol  TypeImageCollectionViewDelegate {
    
    func selectedImageDidChanged(imageName : String)
    
}

class TypeImageCollectionView: UIView, UICollectionViewDataSource,  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{

    
    var collectionView : UICollectionView!
    
    var selectedImage : String = "ic_calendar.png"
    
    var lastSelectedIndexPath : IndexPath!
    
    let images : [String] = ["ic_book.png","ic_ding.png","ic_exam.png","ic_star.png","ic_music.png","ic_computer.png","ic_draw.png"]
    
    var delegate : TypeImageCollectionViewDelegate?
    
    static let flag = 100000
    
    var isShowed : Bool {
        
        get {
            
            let view = UIApplication.shared.keyWindow?.viewWithTag(TypeImageCollectionView.flag) as? TypeImageCollectionView
            
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
        
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 70 * heightScale, height: 70 * heightScale)
        
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        self.addSubview(collectionView)
    
        collectionView.snp.makeConstraints { (make) in
            
            make.margins.equalTo(self)
            
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.unSelectedColor
        
        collectionView.register(TypeImageCollectionCell.classForCoder(), forCellWithReuseIdentifier: TypeImageCollectionCell.cellID)
        
    }
    
    
    //MARK: - Collection View Data Source
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 5
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 7
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TypeImageCollectionCell.cellID, for: indexPath) as! TypeImageCollectionCell
        
        
        if indexPath.section == 0 && indexPath.row == 0 {
            
            self.lastSelectedIndexPath = indexPath
            cell.isSelected = true
            cell.backgroundColor = UIColor.selectedColor
            
        }
        
        cell.imageView.image = UIImage(named: self.images[indexPath.row])
        cell.imageName = self.images[indexPath.row]
        
        if indexPath.section == 0 {
            
            cell.imageView.image = #imageLiteral(resourceName: "ic_calendar")
            cell.imageName = "ic_calendar.png"
        }
        
        
        
        return cell
        
    }
    
    //MARK: - Collection View Delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: itemHeight, height: itemHeight)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if lastSelectedIndexPath != indexPath {
            
            let cell = collectionView.cellForItem(at: indexPath) as! TypeImageCollectionCell
            
            cell.backgroundColor = UIColor.selectedColor
            
            selectedImage = cell.imageName
            
            let lastSelectedCell = collectionView.cellForItem(at: lastSelectedIndexPath)
            
            lastSelectedCell?.backgroundColor = UIColor.unSelectedColor
            
            lastSelectedIndexPath = indexPath
            
            if delegate != nil {
                
                delegate?.selectedImageDidChanged(imageName: selectedImage)
                
            }
            
        }
        
    }

    
    //MARK: - Show
    class func show() -> TypeImageCollectionView {
        
        let collectionView = TypeImageCollectionView()
        
        collectionView.tag = flag
        
        UIApplication.shared.keyWindow?.addSubview(collectionView)
        
        collectionView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height * 0.4)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            
            collectionView.frame = CGRect(x: 0, y: screenSize.height * 0.6, width: screenSize.width, height: screenSize.height * 0.4)
            
        }, completion: nil)
        
        
        return collectionView
    }
    
    //MARK: - Dismiss
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
