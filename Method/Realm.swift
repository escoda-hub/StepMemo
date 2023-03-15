//
//  Realm.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/03.
//

import Foundation
import RealmSwift
import SwiftUI
import Realm

//ステップデータの取得
func getStepData(groupName:String,stepName:String)->(Step) {
    
    let realm = try! Realm()
    
    var step :Step = Step()
    do{
        let StepData = realm.objects(Group.self).filter("name == %@ && ANY steps.title == %@",groupName,stepName)//type is Results<Group>

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

//グールが持つステップ名の取得
func getStepName(groupName:String)->Array<String> {
    
    let realm = try! Realm()
    let group = realm.objects(Group.self).filter("name == %@",groupName).first!//type is Results<Group>
    
    var steps: [String] = []
    for step in Array(group.steps){
        steps.append(step.title)
    }

    return steps
}

//ステップ詳細データの取得
func getStepDetailData(groupName:String,stepName:String,index:Int)->(StepDetail){
    
    let realm = try! Realm()
    let group = realm.objects(Group.self)
    let subquery_getStepID = group.where {
        ($0.name == groupName && $0.steps.title == stepName)
    }
    let step_id = Array(subquery_getStepID)[0].steps[0].id
    let results = realm.objects(StepDetail.self).filter("step_id == %@ && Order == %@",step_id,index).first!
    return results

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

func updateMemo(groupName:String,stepName:String,index:Int,memo:String)->(Step) {

    let realm = try! Realm()
    let group = realm.objects(Group.self)
    let subquery_getStepID = group.where {
        ($0.name == groupName && $0.steps.title == stepName)
    }
    let step_id = Array(subquery_getStepID)[0].steps[0].id
    let results = realm.objects(StepDetail.self).filter("step_id == %@ && Order == %@",step_id,index).first!

    do{
      try realm.write{
              results.memo = memo
      }
    }catch {
      print("Error \(error)")
    }
    
    return getStepData(groupName: groupName, stepName: stepName)
}

func upDateTitle(groupName:String,stepName:String,title:String)->(Step) {

    let realm = try! Realm()
    let group = realm.objects(Group.self)
    let subquery_getStepID = group.where {
        ($0.name == groupName && $0.steps.title == stepName)
    }
    let step_id = Array(subquery_getStepID)[0].steps[0].id
    let results = realm.objects(Step.self).filter("id == %@",step_id).first!

    do{
      try realm.write{
          results.title = title
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

func deleteStepDetail(groupName:String,stepName:String,index:Int) {

    let realm = try! Realm()
    let group = realm.objects(Group.self)
    let subquery_getStepID = group.where {
        ($0.name == groupName && $0.steps.title == stepName)
    }

    let step_id = Array(subquery_getStepID)[0].steps[0].id
    let results = realm.objects(StepDetail.self).filter("step_id == %@ && Order == %@",step_id,index).first!
    
    //長押しされたステップ詳細情報を削除
    do{
      try realm.write{
          realm.delete(results)
      }
    }catch {
      print("Error \(error)")
    }
    
    let results_after = realm.objects(StepDetail.self).filter("step_id == %@",step_id)

    //Orderの振り直し
    do{
      try realm.write{
          var i = 1
          for result in results_after {
              result.Order = i
              i = i + 1
          }
      }
    }catch {
      print("Error \(error)")
    }
    
}

func getGroup() -> Results<Group>? {
    let realm = try! Realm()
    let groups = realm.objects(Group.self)
    return groups
}

//グループの削除
func deleteGroup(indexSet:IndexSet){
    let realm = try! Realm()
    let groupsToDelete = indexSet.map { getGroup()![$0] }
    try! realm.write {
        groupsToDelete.forEach { group in
            // 削除するGroupオブジェクトからStepオブジェクトを取得し、削除する
            let stepsToDelete = group.steps
            stepsToDelete.forEach { step in
                // 削除するStepオブジェクトからStepDetailオブジェクトを取得し、削除する
                let stepDetailToDelete = step.stepDetails
                realm.delete(stepDetailToDelete)
            }
            realm.delete(stepsToDelete)
        }
        realm.delete(groupsToDelete)
    }
}

func changeGroup(oldGroupName:String,newGroupName:String){
    // Realmインスタンスを取得
    let realm = try! Realm()

    // group1とgroup2のGroupオブジェクトを取得
    let group1 = realm.objects(Group.self).filter("name == %@", oldGroupName).first
    let group2 = realm.objects(Group.self).filter("name == %@", newGroupName).first

    // group1からステップデータを取得
    let stepsToMove = group1?.steps
    // group2のstepsプロパティにステップデータを追加
    try! realm.write {
        if let stepsToMove = group1?.steps {
//            group2?.steps.append(objectsIn: List(collection: stepsToMove as! RLMCollection))
            group2?.steps.append(objectsIn: stepsToMove)
            group1?.steps.removeAll()
        }
    }
}
