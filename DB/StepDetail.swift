//
//  StepDetail.swift
//  StepLogger
//
//  Created by rei asahina on 2023/02/20.
//

import Foundation
import RealmSwift

class StepDetail: Object {
    @Persisted  var id = UUID()
    @Persisted  var step_id = 0
    @Persisted  var imagename:String = ""
    @Persisted  var memo:String = ""
    @Persisted  var R_x:Double = 0
    @Persisted  var R_y:Double = 0
    @Persisted  var R_angle:Double = 0
    @Persisted  var R_mode:Int = 0
    @Persisted  var L_x:Double = 0
    @Persisted  var L_y:Double = 0
    @Persisted  var L_angle:Double = 0
    @Persisted  var L_mode:Int = 0
    
    override static func primaryKey() -> String? {
            return "id"
    }
}
