import SwiftUI

struct StepList:Hashable,Codable,Identifiable{
    var id :Int//固有識別子
    var title :String//ステップ名
    var created_at:String//作成日
    var updated_at:String//作成日
    var category:String//カテゴリ
    var stepData :[stepDetailData]
    
//    enum Category :String,CaseIterable,Hashable,Codable{
//        case hiphop="HipHop"
//        case house="House"
//        case lock="Lock"
//    }
    
    struct stepDetailData:Hashable,Codable,Identifiable {
        var id :Int//固有識別子
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
    }

}

