//
//  StepDetail.swift
//  StepLogger
//
//  Created by rei asahina on 2023/02/20.
//

import Foundation
import RealmSwift

class StepDetail: Object,Identifiable {
    @Persisted(primaryKey: true) var id : String = UUID().uuidString
    @Persisted  var step_id:String
    @Persisted  var imagename:String
    @Persisted  var memo:String
    @Persisted  var R_x:Double
    @Persisted  var R_y:Double
    @Persisted  var R_angle:Double
    @Persisted  var R_mode:Int
    @Persisted  var L_x:Double
    @Persisted  var L_y:Double
    @Persisted  var L_angle:Double
    @Persisted  var L_mode:Int
    @Persisted  var Order:Int
    
//    init(id: String, step_id: String, imagename: String, memo: String, R_x: Double, R_y: Double, R_angle: Double, R_mode: Int, L_x: Double, L_y: Double, L_angle: Double, L_mode: Int, Order: Int) {
//        self.id = id
//        self.step_id = step_id
//        self.imagename = imagename
//        self.memo = memo
//        self.R_x = R_x
//        self.R_y = R_y
//        self.R_angle = R_angle
//        self.R_mode = R_mode
//        self.L_x = L_x
//        self.L_y = L_y
//        self.L_angle = L_angle
//        self.L_mode = L_mode
//        self.Order = Order
//    }
    
}
