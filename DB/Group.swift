//
//  Group.swift
//  StepLogger
//
//  Created by rei asahina on 2023/02/20.
//SwiftではUUIDが128bit(=16byte)の数値として表されデータ型はUUID型


import Foundation
import RealmSwift

class Gropu: Object {
    @Persisted  var id : Int = 0
    @Persisted  var name:String = "" //Gropu名
//    @Persisted  var memo:String = "" 
    
    override static func primaryKey() -> String? {
            return "id"
    }
}
