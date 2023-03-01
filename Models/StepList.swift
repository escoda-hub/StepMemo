import SwiftUI

struct StepModel:Hashable,Codable,Identifiable{
    var id :Int
    var title :String
    var created_at:String
    var updated_at:String
    var favorite:Bool
    var stepDetails :[stepDetailData]
    
    struct stepDetailData:Hashable,Codable,Identifiable {
        var id :Int
        var step_id :Int
        var imagename: String
        var memo :String
        var R_x: Double
        var R_y: Double
        var R_angle: Double
        var R_mode: Int
        var L_x: Double
        var L_y: Double
        var L_angle: Double
        var L_mode : Int
        var Order:Int
    }

}

