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
    @Persisted var stepDetails: List<StepDetail>
    
//    init(id: String, title: String, created_at: Date = Date(), updated_at: Date = Date(), favorite: Bool, stepDetails: List<StepDetail>) {
//        self.id = id
//        self.title = title
//        self.created_at = created_at
//        self.updated_at = updated_at
//        self.favorite = favorite
//        self.stepDetails = stepDetails
//    }
    
}
