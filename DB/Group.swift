//
//  Group.swift
//  StepLogger
//
//  Created by rei asahina on 2023/02/20.
//SwiftではUUIDが128bit(=16byte)の数値として表されデータ型はUUID型


import Foundation
import RealmSwift

class Gropu: Object {
    @Persisted  var id = UUID()
    @Persisted  var name:String = "" //Gropu名
    
    override static func primaryKey() -> String? {
            return "id"
    }
}
