//
//  NSManagedObject+Extension.swift
//  AniListProject
//
//  Created by Juan Arcos on 18/01/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import Foundation
import CoreData

struct ReflectionEntities {
    
    static let primitiveDataTypes: Dictionary<String, Any> = [
        "c" : Int8.self,
        "s" : Int16.self,
        "i" : Int32.self,
        "q" : Int.self, //also: Int64, NSInteger, only true on 64 bit platforms
        "S" : UInt16.self,
        "I" : UInt32.self,
        "Q" : UInt.self, //also UInt64, only true on 64 bit platforms
        "B" : Bool.self,
        "d" : Double.self,
        "f" : Float.self,
        "{" : Decimal.self
    ]
    
    static func getTypesOfProperties(in clazz: NSObject.Type) -> Dictionary<String, Any>? {
        
        var count = UInt32()
        guard let properties = class_copyPropertyList(clazz, &count) else { return nil }
        var types: Dictionary<String, Any> = [:]
        for i in 0..<Int(count) {
            let property: objc_property_t = properties[i]
            guard let name = getNameOf(property: property) else { continue }
            let type = getTypeOf(property: property)
            types[name] = type
        }
        free(properties)
        return types
    }
    
    static func getTypeOf(property: objc_property_t) -> Any {
        guard let attributesAsNSString: NSString = NSString(utf8String: property_getAttributes(property)!) else { return Any.self }
        let attributes = attributesAsNSString as String
        let slices = attributes.components(separatedBy: "\"")
        guard slices.count > 1 else { return getPrimitiveDataType(withAttributes: attributes) }
        let objectClassName = slices[1]
        let objectClass = NSClassFromString(objectClassName) as! NSObject.Type
        return objectClass
    }
    
    static func getNameOf(property: objc_property_t) -> String? {
        guard let name: NSString = NSString(utf8String: property_getName(property)) else { return nil }
        return name as String
    }
    
    static func getPrimitiveDataType(withAttributes attributes: String) -> Any {
        let letter = attributes.substringRange(1..<2)
        guard let type = primitiveDataTypes[letter] else { return Any.self }
        return type
    }
    
    static func makeCast(value: Any, types: Any) -> Any?{
        
        switch types {
        case _ as Int32.Type:
            fallthrough
            
        default:
            return nil
        }
        
        
        if types is Int32.Type {
            if let newValue: Int = value as? Int {
                return Int32(newValue)
            }
        }
        return nil
    }
    
}

extension PageInfo {
    func populateProperties(dictionary dict: [String:Any]) {
        //1. get all properties names and types
        
        guard let types = ReflectionEntities.getTypesOfProperties(in: PageInfo.self) else { return }
        
        for (name, type) in types {
            print(dict[name] ?? "no key present")
            switch type {
                case _ as Int32.Type:
//                    if let value: Int = dict[name] as? Int {
//                        self.setValue(Int32(value), forKey: name)
//                    }
                    if let value = ReflectionEntities.makeCast(value: dict[name] as Any, types: type) {
                        self.setValue(value, forKey: name)
                    }
                    print("SI hacer cast to Int32")
                case _ as Int8.Type:
                    if let value: Int = dict[name] as? Int {
                        self.setValue(Int8(value), forKey: name)
                    }
                    print("SI hacer cast to Int8")
                case _ as Int16.Type:
                    if let value: Int = dict[name] as? Int {
                        self.setValue(Int16(value), forKey: name)
                    }
                    print("SI hacer cast to Int16")
                case _ as Int.Type:
                    if let value: Int = dict[name] as? Int {
                        self.setValue(value , forKey: name)
                    }
                    print("SI hacer cast to Int")
                case _ as UInt16.Type:
                    if let value: Int = dict[name] as? Int {
                        self.setValue(UInt16(value), forKey: name)
                    }
                    print("SI hacer cast to UInt16")
                case _ as UInt32.Type:
                    if let value: Int = dict[name] as? Int {
                        self.setValue(UInt32(value), forKey: name)
                    }
                    print("SI hacer cast to UInt32")
                case _ as UInt.Type:
                    if let value: Int = dict[name] as? Int {
                        self.setValue(UInt(value), forKey: name)
                    }
                    print("SI hacer cast to UInt")
                case _ as Bool.Type:
                    if let value: Bool = dict[name] as? Bool {
                        self.setValue(value, forKey: name)
                    }
                    print("SI hacer cast to Bool")
                case _ as Double.Type:
                    if let value: Double = dict[name] as? Double {
                        self.setValue(value, forKey: name)
                    }
                    print("SI hacer cast to Double")
                case _ as Float.Type:
                    if let value: Float = dict[name] as? Float {
                        self.setValue(value, forKey: name)
                    }
                    print("SI hacer cast to Float")
                case _ as Decimal.Type:
                    if let value: Decimal = dict[name] as? Decimal {
                        self.setValue(value, forKey: name)
                    }
                    print("SI hacer cast to Decimal")
                default:
                    print("NO hacer cast")
            }
        }
        
        print("setVAlues: \(self.description)")
        
    }
}
