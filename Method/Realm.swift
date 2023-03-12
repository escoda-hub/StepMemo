//
//  Realm.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/03.
//

import Foundation
import RealmSwift
import SwiftUI

//ステップデータの取得
func getStepData(groupName:String,stepName:String)->(Step) {
    
    let realm = try! Realm()
    
    var step :Step = Step()
    do{
        let StepData = realm.objects(Group.self).filter("name == %@ && ANY steps.title == %@",groupName,stepName)//type is Results<Group>
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

    } catch {
      print("Error \(error)")
    }

}

func updateStepDetail(groupName:String,stepName:String,index:Int,isR:Bool,location:CGPoint,angle:Angle)->(Step) {

    let realm = try! Realm()
    let group = realm.objects(Group.self)
    let subquery_getStepID = group.where {
        ($0.name == groupName && $0.steps.title == stepName)
    }
    let step_id = Array(subquery_getStepID)[0].steps[0].id
    let results = realm.objects(StepDetail.self).filter("step_id == %@ && Order == %@",step_id,index).first!

    do{
      try realm.write{
          if isR {
              results.R_x = location.x
              results.R_y = location.y
              results.R_angle = angle.degrees
          }else{
              results.L_x = location.x
              results.L_y = location.y
              results.L_angle = angle.degrees
          }
      }
    }catch {
      print("Error \(error)")
    }
    
    return getStepData(groupName: groupName, stepName: stepName)
}

func updateMode(groupName:String,stepName:String,index:Int,isR:Bool,mode:Int)->(Step) {

    let realm = try! Realm()
    let group = realm.objects(Group.self)
    let subquery_getStepID = group.where {
        ($0.name == groupName && $0.steps.title == stepName)
    }
    let step_id = Array(subquery_getStepID)[0].steps[0].id
    let results = realm.objects(StepDetail.self).filter("step_id == %@ && Order == %@",step_id,index).first!

    do{
      try realm.write{
          if isR {
              results.R_mode = mode
          }else{
              results.L_mode = mode
          }
      }
    }catch {
      print("Error \(error)")
    }
    
    return getStepData(groupName: groupName, stepName: stepName)
}

func updateMemo(groupName:String,stepName:String,index:Int,isR:Bool,memo:String)->(Step) {

    let realm = try! Realm()
    let group = realm.objects(Group.self)
    let subquery_getStepID = group.where {
        ($0.name == groupName && $0.steps.title == stepName)
    }
    let step_id = Array(subquery_getStepID)[0].steps[0].id
    let results = realm.objects(StepDetail.self).filter("step_id == %@ && Order == %@",step_id,index).first!

    do{
      try realm.write{
          if isR {
              results.memo = memo
          }else{
              results.memo = memo
          }
      }
    }catch {
      print("Error \(error)")
    }
    
    return getStepData(groupName: groupName, stepName: stepName)
}

func addStepDetail(groupName:String,stepName:String)->(step:Step, order:Int){
    
    let realm = try! Realm()
    let group = realm.objects(Group.self)

    let subquery_getStepID = group.where {
        ($0.name == groupName && $0.steps.title == stepName)
    }
    let step_id = Array(subquery_getStepID)[0].steps[0].id
    let step = realm.objects(Step.self).filter("id == %@",step_id).first!

    let stepDetail = realm.objects(StepDetail.self).filter("step_id == %@",step_id)
    
    let stepDetail_default = StepDetail()
    stepDetail_default.step_id = step_id
    stepDetail_default.imagename = "g1_s1_1"
    stepDetail_default.memo = "memomemomemo_adddata"
    stepDetail_default.L_x = 80
    stepDetail_default.L_y = 250
    stepDetail_default.L_angle = 315
    stepDetail_default.L_mode = 2
    stepDetail_default.R_x = 320
    stepDetail_default.R_y = 250
    stepDetail_default.R_angle = 45
    stepDetail_default.R_mode = 2
    stepDetail_default.Order = Array(stepDetail)[Array(stepDetail).count-1].Order + 1

    do{
      try realm.write{
          step.stepDetails.append(stepDetail_default)
      }
    }catch {
      print("Error \(error)")
    }
    return (getStepData(groupName: groupName, stepName: stepName),stepDetail_default.Order)
}
