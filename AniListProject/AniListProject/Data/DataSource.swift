//
//  DataSource.swift
//  AniListProject
//
//  Created by juan on 1/11/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import Foundation
import CoreData

struct DataSource {
    
    static func retrieve<T: NSManagedObject>(entityClass: T.Type,
                                             context: NSManagedObjectContext,
                                             sortBy: String? = nil,
                                             isAscending: Bool = true,
                                             predicate: NSPredicate? = nil) -> [T]? {
        let entityName = NSStringFromClass(entityClass)
        let request    = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        request.returnsObjectsAsFaults = false
        request.predicate = predicate
        
        if (sortBy != nil) {
            let sorter = NSSortDescriptor(key:sortBy , ascending:isAscending)
            request.sortDescriptors = [sorter]
        }
        
        let commits = try? context.fetch(request) as! [T]
        return commits
        
    }
    
    static func store(queryType: QueryTypeEnum, context: NSManagedObjectContext) -> Bool {
        let queryTypeModel: QueryType = QueryType(context: context)
        queryTypeModel.queryType = queryType.queryTypeDesc
        
        if (try? context.save()) != nil {
            return true
        }else {
            return false
        }
    }
    
    static func storePageInfo(to queryType: QueryTypeEnum, aplResponse: APLResponse, context: NSManagedObjectContext, completion:@escaping(Bool) -> Void){
        //1. Find and entity with taht queryTypeEnum
        let predicate = NSPredicate(format: "queryType == %@", queryType.queryTypeDesc)
        let queryTypeRetrieve = retrieve(entityClass: QueryType.self, context: context, predicate: predicate)
        
        guard let queryTypes = queryTypeRetrieve else {
            if store(queryType: queryType, context: context) {
                storePageInfo(to: queryType, aplResponse: aplResponse, context: context) { success in
                    completion(success)
                }
            }else {
                completion(false)
            }
            return
        }
        
        let queryTypeModel = queryTypes.last
        
        
        guard let aplPage = aplResponse.dataResponse["Page"] as! [String:Any]?,
            let pageInfo = aplPage["pageInfo"] as! [String:Any]? else {
            completion(false)
            return
        }
        
        let pageInfoModel = PageInfo(context: context)
        pageInfoModel.populateProperties(dictionary: pageInfo)
        pageInfoModel.queryType = queryTypeModel
        
        if (try? context.save()) != nil {
            completion(true)
        }else {
            completion(false)
        }
    }
    
    
    static func increaseCurrentPage(to queryType: QueryTypeEnum, context: NSManagedObjectContext, completion:@escaping(Bool) -> Void) {
        //1. Find and entity with taht queryTypeEnum
        let predicate = NSPredicate(format: "queryType == %@", queryType.queryTypeDesc)
        let queryTypeRetrieve = retrieve(entityClass: QueryType.self, context: context, predicate: predicate)
        
        guard let queryTypes = queryTypeRetrieve else {
            completion(false)
            return
        }
        
        let queryTypeModel = queryTypes.last!
        
        var currentPageInfo = queryTypeModel.pageInfo!
        currentPageInfo.currentPage = currentPageInfo.currentPage + 1
        
        
        if (try? context.save()) != nil {
            completion(true)
        }else {
            completion(false)
        }
    }
    
    static func retrievePageInfo(to queryType: QueryTypeEnum, context: NSManagedObjectContext, completion:@escaping(PageInfo?) -> Void) {
        //1. Find and entity with taht queryTypeEnum
        let predicate = NSPredicate(format: "queryType == %@", queryType.queryTypeDesc)
        let queryTypeRetrieve = retrieve(entityClass: QueryType.self, context: context, predicate: predicate)
        
        
        guard let queryTypes = queryTypeRetrieve else {
            completion(nil)
            return
        }
        
        let queryTypeModel = queryTypes.last!
        
        if let pageInfo = queryTypeModel.pageInfo {
            completion(pageInfo)
        }else {
            completion(nil)
        }
    }
    
    static func storeMedia(to queryType: QueryTypeEnum, aplResponse: APLResponse, context: NSManagedObjectContext, completion:@escaping(Bool) -> Void ) {
        
    }
}

