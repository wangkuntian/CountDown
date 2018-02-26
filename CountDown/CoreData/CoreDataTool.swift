//
//  CoreDataTool.swift
//  CountDown
//
//  Created by 王坤田 on 2017/11/6.
//  Copyright © 2017年 王坤田. All rights reserved.
//
import UIKit
import Foundation
import CoreData

struct CoreDataTool {
    
    
    
    //MARK: - 获取上下文
    private static var context : NSManagedObjectContext {
        
        get {
            
            let app = UIApplication.shared.delegate as! AppDelegate
            
            return app.persistentContainer.viewContext
            
        }
        
    }
    
    //MARK: - 保存
    private static func save() -> Bool {
        
        var result : Bool = true
        
        do {
            
            try self.context.save()
            
            print("保存成功")
        
            
        }catch{
            
            result = false
            
            fatalError("不能保存：\(error)")

        }
        
        return result
    }
    
    //MARK: - 增加新分类
    static func addNewType(type : Type) -> Bool {
        
        let EntityName = "TypeModel"
        
        let temp = NSEntityDescription.insertNewObject(forEntityName: EntityName, into: self.context) as! TypeModel
        
        temp.imageName = type.image
        temp.typeName = type.name
        temp.level = type.level
        temp.id = type.id
        
        let result =  save()
        
        return result
    }
    
    //MARK: - 获取分类数组
    private static func getTypesArray() -> [TypeModel] {
        
        var objects : [TypeModel] = []
        
        let EntityName = "TypeModel"
        
        //声明数据的请求
        let fetchRequest = NSFetchRequest<TypeModel>.init(entityName: EntityName)
        
        do {
            
            objects = try context.fetch(fetchRequest)
            
        }catch{
            
            fatalError("查询失败:\(error)")
        }
        
        return objects
    }
    
    //MARK: - 获取所有分类
    static func getAllTypes() -> [Type] {
        
        var objects : [Type] = []
        
        for typeModel in getTypesArray() {
            
            let temp = Type(id: typeModel.id!, name: typeModel.typeName!, image: typeModel.imageName!, level: typeModel.level)
            
            objects.append(temp)
            
        }
        
        return objects
    }
    
    //MARK: - 删除某个分类
    static func deleteType(id : String) -> Bool {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "TypeModel")
        
        let predicate = NSPredicate.init(format: "id == %@",id)
        
        fetchRequest.predicate = predicate
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        deleteRequest.resultType = .resultTypeStatusOnly
        
        do {
            
            let batchResult = try context.execute(deleteRequest) as! NSBatchDeleteResult
            
            let f = batchResult.result as! Bool
            
            context.refreshAllObjects()
            
            print("delete \(f)")
            
            return f
            
        }catch{
            
            print("delete error")
            
            return false
        }
        
        
    }
    
    
    //MARK: - 增加新日子
    static func addNewDay(day : Day) -> Bool {
        
        let EntityName = "DayModel"
        
        let temp = NSEntityDescription.insertNewObject(forEntityName: EntityName, into: self.context) as! DayModel
        
        temp.date = day.date
        temp.id = day.id
        temp.isCover = day.isCover
        temp.title = day.title
        temp.type = day.typeName
        temp.typeImage = day.typeImage
        temp.dateString = day.dateString
        temp.repeatString = day.repeat
        
        let result =  save()
        
        return result
    }
    
    //MARK: - 获取日子数组
    private static func getDaysArray() -> [DayModel] {
        
        var objects : [DayModel] = []
        
        let EntityName = "DayModel"
        
        //声明数据的请求
        let fetchRequest = NSFetchRequest<DayModel>.init(entityName: EntityName)
        
        do {
            
            objects = try context.fetch(fetchRequest)
            
        }catch{
            
            fatalError("查询失败:\(error)")
        }
        
        return objects
        
    }
    
    //MARK: - 获取所有日子
    static func getAllDays() -> [Day] {
        
        var objects : [Day] = []
        
        for dayModel in getDaysArray() {
            
            let temp = Day(id: dayModel.id!, title: dayModel.title!, date: dayModel.date!,dateString: dayModel.dateString!, typeName: dayModel.type!, typeImage: dayModel.typeImage!, repeat: dayModel.repeatString!, isCover: dayModel.isCover)
            objects.append(temp)
        }
        
        return objects
    }
    
    //MARK: - 删除日子
    static func deleteDay(id : String) -> Bool {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "DayModel")
        
        let predicate = NSPredicate.init(format: "id == %@",id)
        
        fetchRequest.predicate = predicate
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        deleteRequest.resultType = .resultTypeStatusOnly
        
        do {
            
            let batchResult = try context.execute(deleteRequest) as! NSBatchDeleteResult
            
            let f = batchResult.result as! Bool
            
            context.refreshAllObjects()
            
            print("delete \(f)")
            
            return f
            
        }catch{
            
            print("delete error")
            
            return false
        }
        
    }
    
    //MARK: - 修改日子
    static func updateDay(id : String ,isCover : Bool) -> Bool {
        
        let entityName = "DayModel"
        
        let updateRequest = NSBatchUpdateRequest.init(entityName: entityName)
        
        updateRequest.predicate = NSPredicate.init(format: "id == %@",id)
        
        updateRequest.propertiesToUpdate = ["isCover" : isCover]
        
        updateRequest.resultType = .statusOnlyResultType
        
        do {
            
            let batchResult = try context.execute(updateRequest) as!  NSBatchUpdateResult
            
            let flag = batchResult.result as! Bool
            
            print("更新：\(flag)")
            
            return flag
            
        }catch{
            
            print("更新：失败")
            
            return false
            
        }
        
    }
    
}
