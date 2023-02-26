//
//  Group.swift
//  StepLogger
//
//  Created by rei asahina on 2023/02/20.
//SwiftではUUIDが128bit(=16byte)の数値として表されデータ型はUUID型

//https://qiita.com/rei_012/items/df430d228577c041d61d


import Foundation
import RealmSwift

class Step: Object,Identifiable {
    @Persisted(primaryKey: true) var id : String = UUID().uuidString
    @Persisted  var title:String
    @Persisted  var created_at = Date()
    @Persisted  var updated_at = Date()
    @Persisted  var favorite:Bool
    @Persisted  var group : Group? //Gropuモデルと1対1の関係
//    let StepDetail = List<StepDetail> ()  // StepDetailモデルと1対Nの関係
    @Persisted var StepDetail: List<StepDetail>
    
}
