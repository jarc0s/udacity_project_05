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
        
        guard let queryTypes = queryTypeRetrieve, !queryTypes.isEmpty else {
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
        
        let currentPageInfo = queryTypeModel.pageInfo!
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
        
        //1. Find and entity with taht queryTypeEnum
        let predicate = NSPredicate(format: "queryType == %@", queryType.queryTypeDesc)
        let queryTypeRetrieve = retrieve(entityClass: QueryType.self, context: context, predicate: predicate)
        
        guard let queryTypes = queryTypeRetrieve else {
            if store(queryType: queryType, context: context) {
                storeMedia(to: queryType, aplResponse: aplResponse, context: context) { success in
                    completion(success)
                }
            }else {
                completion(false)
            }
            return
        }
        
        
        let queryTypeModel = queryTypes.last
        
        guard let aplPage = aplResponse.dataResponse["Page"] as! [String:Any]?,
            let media = aplPage["media"] as! [Any]? else {
            completion(false)
            return
        }
        
        var storedSuccessfully = true
        var dataStoredCount = 0
        for mediaDic in media {
            let mediaModel = Media(context: context)
            let titleModel = MTitle(context: context)
            let coverImageModel = MCoverImage(context: context)
            mediaModel.populateProperties(dictionary: mediaDic as! [String : Any], mTitle: titleModel, mCoverImage: coverImageModel)
            titleModel.media = mediaModel
            coverImageModel.media = mediaModel
            mediaModel.queryType = queryTypeModel
            if (try? context.save()) != nil {
                dataStoredCount += 1
                continue
            }else {
                storedSuccessfully = false
            }
        }
        
        
        if dataStoredCount == 0 && !storedSuccessfully {
            completion(false)
            return
        }
        
        completion(true)
    }
    
    static func retrieveMedia(to queryType: QueryTypeEnum, context: NSManagedObjectContext, completion:@escaping([Media]?) -> Void) {
        
        //1. Find and entity with taht queryTypeEnum
        let predicate = NSPredicate(format: "queryType == %@", queryType.queryTypeDesc)
        let queryTypeRetrieve = retrieve(entityClass: QueryType.self, context: context, predicate: predicate)
        
        guard let queryTypes = queryTypeRetrieve else {
            completion(nil)
            return
        }
        
        let queryTypeModel = queryTypes.last!
        
        if let media = queryTypeModel.media {
            completion(media.toArray())
        }else {
            completion(nil)
        }
        
    }
    
    
    static func deleteQueryType(to queryType:QueryTypeEnum, context: NSManagedObjectContext, completion:@escaping(Bool) -> Void) {
        //1. Find and entity with taht queryTypeEnum
        let predicate = NSPredicate(format: "queryType == %@", queryType.queryTypeDesc)
        let queryTypeRetrieve = retrieve(entityClass: QueryType.self, context: context, predicate: predicate)
        
        guard let queryTypes = queryTypeRetrieve else {
            completion(false)
            return
        }
        
        for queryTypeEntity in queryTypes {
            context.delete(queryTypeEntity)
        }
        
        do {
            try context.save()
            completion(false)
        }catch {
            completion(true)
        }
    }
    
    static func deleteAllContentQueryType(context: NSManagedObjectContext, completion:@escaping(Bool) -> Void) {
        let queryTypeRetrieve = retrieve(entityClass: QueryType.self, context: context)
        
        guard let queryTypes = queryTypeRetrieve else {
            completion(false)
            return
        }
        
        for queryTypeEntity in queryTypes {
            context.delete(queryTypeEntity)
        }
        
        do {
            try context.save()
            completion(false)
        }catch {
            completion(true)
        }
        
    }
}

