//
//  Realm.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/03.
//

import Foundation
import RealmSwift

//ステップデータの取得
func getStepData(groupName:String,stepName:String)->(Step) {
    
    let realm = try! Realm()
    
    var step :Step = Step()
    do{
        let StepData = realm.objects(Group.self).filter("name == %@ && ANY steps.title == %@",groupName,stepName)//type is Results<Group>
//        print(StepData)
//        print(type(of: StepData))
//        print(Array(Array(StepData)[0].steps)[0])
//        print(Array(StepData).count)
//        print(type(of: Array(StepData)[0]))
        
        if (Array(StepData).count == 1){
            if(Array(Array(StepData)[0].steps).count == 1){
                step = Array(Array(StepData)[0].steps)[0]
            }
        }
        
        return step
    }catch {
      print("Error \(error)")
    }

}

//ステップ詳細データの取得
func getStepDetailData(groupName:String,stepName:String,index:Int)->(StepDetail){
    
    let realm = try! Realm()
    do{
        let StepData = realm.objects(Group.self).filter("name == %@ && ANY steps.title == %@",groupName,stepName)//type is Results<Group>
        
        var stepDetailElement : StepDetail = StepDetail()
        
        if (Array(StepData).count == 1){
            let step = Array(StepData)[0].steps
            if(step.count == 1){
                let stepDetail = Array(Array(StepData)[0].steps)[0].stepDetails
                if(stepDetail.count > 0){
                    stepDetailElement = Array(Array(Array(StepData)[0].steps)[0].stepDetails)[index]
                }
            }
        }
        
        return stepDetailElement

    }catch {
      print("Error \(error)")
    }

}
