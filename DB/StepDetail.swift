//
//  StepDetail.swift
//  StepLogger
//
//  Created by rei asahina on 2023/02/20.
//

import Foundation
import RealmSwift

class StepDetail: Object {
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
}
