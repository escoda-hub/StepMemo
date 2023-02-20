//
//  Group.swift
//  StepLogger
//
//  Created by rei asahina on 2023/02/20.
//SwiftではUUIDが128bit(=16byte)の数値として表されデータ型はUUID型

//https://qiita.com/rei_012/items/df430d228577c041d61d


import Foundation
import RealmSwift

class Step: Object {
    @Persisted  var id = UUID()
    @Persisted  var title:String = ""
    @Persisted  var created_at = Date()
    @Persisted  var deleted_at = Date()
    @Persisted  var gropu : Gropu? //Gropuモデルと1対1の関係
    let stepdetail_id = List<StepDetail> ()  // StepDetailモデルと1対Nの関係
    
    override static func primaryKey() -> String? {
            return "id"
    }
}
