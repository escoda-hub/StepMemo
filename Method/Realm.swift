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

func getStepList(groupName: String) -> [Step] {
    let realm = try! Realm()
    guard let group = realm.objects(Group.self).filter("name == %@", groupName).first else {
        // 該当するGroupが見つからなかった場合
        return []
    }
//    print(Array(group.steps))
    return Array(group.steps)
}


func getStep(step_id: String) -> Step {
    let realm = try! Realm()
    guard let stepData = realm.objects(Step.self).filter("id == %@", step_id).first else {
        // 該当するGroupが見つからなかった場合
        return Step()
    }

    return stepData
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

func updateStepDetail(step_id:String,index:Int,isR:Bool,location:CGPoint,angle:Angle)->(Step) {

    let realm = try! Realm()
    let StepDetail = realm.objects(StepDetail.self).filter("step_id == %@ && Order == %@",step_id,index).first!
    
    do{
      try realm.write{
          if isR {
              StepDetail.R_x = location.x
              StepDetail.R_y = location.y
              StepDetail.R_angle = angle.degrees
          }else{
              StepDetail.L_x = location.x
              StepDetail.L_y = location.y
              StepDetail.L_angle = angle.degrees
          }
      }
    }catch {
      print("Error \(error)")
    }
    
    return getStep(step_id: step_id)
}

func updateMode(step_id:String,index:Int,isR:Bool,mode:Int)->(Step) {

    let realm = try! Realm()
    let StepDetail = realm.objects(StepDetail.self).filter("step_id == %@ && Order == %@",step_id,index).first!

    do{
      try realm.write{
          if isR {
              StepDetail.R_mode = mode
          }else{
              StepDetail.L_mode = mode
          }
      }
    }catch {
      print("Error \(error)")
    }
    
    return getStep(step_id: step_id)
}

func updateMemo(step_id:String,index:Int,memo:String) -> Step? {
    let realm = try! Realm()
    
    guard let stepDetail = realm.objects(StepDetail.self)
            .filter("step_id == %@ && Order == %@",step_id,index)
            .first
    else {
        // StepDetailが見つからない場合はnilを返す
        return nil
    }
    
    do {
        try realm.write {
            stepDetail.memo = memo
        }
    } catch {
        print("Error updating memo: \(error)")
        // エラーが発生した場合はnilを返す
        return nil
    }
    
    // getStep関数で更新されたStepオブジェクトを取得して返す
    return getStep(step_id: step_id)
}

func upDateTitle(step_id:String,title:String)->(Step) {

    let realm = try! Realm()
    let Step = realm.objects(Step.self).filter("id == %@",step_id).first!

    do{
      try realm.write{
          Step.title = title
      }
    }catch {
      print("Error \(error)")
    }
    
    return getStep(step_id: step_id)
}

func addStepDetail(step_id:String)->(step:Step, order:Int){
    
    let realm = try! Realm()
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
    return (getStep(step_id: step_id),stepDetail_default.Order)
}

func deleteStepDetail(step_id:String,index:Int) {

    let realm = try! Realm()
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

func changeGroup(oldGroupName: String, newGroupName: String, step_id: String) {
    if oldGroupName != newGroupName {
        // Realmインスタンスを取得
        let realm = try! Realm()
        // group1とgroup2のGroupオブジェクトを取得
        let group1 = realm.objects(Group.self).filter("name == %@", oldGroupName).first
        let group2 = realm.objects(Group.self).filter("name == %@", newGroupName).first
        
        // group1から指定されたステップを取得
        let stepToMove = group1?.steps.first(where: { $0.id == step_id })
        if let stepToMove = stepToMove {
            // group2のstepsプロパティに指定されたステップを追加
            try! realm.write {
                group2?.steps.append(stepToMove)
                if let index = group1?.steps.firstIndex(where: { $0.id == step_id }) {
                    group1?.steps.remove(at: index)
                }
            }
        }
    }
}


func addStep(name:String) {

    let newStep = Step()
    newStep.title = "untitled"
    newStep.created_at = Date()
    newStep.updated_at = Date()
    newStep.favorite = true

    let stepDetail_default = StepDetail()
    stepDetail_default.step_id = newStep.id
    stepDetail_default.imagename = "g1_s1_1"
    stepDetail_default.memo = "memomemomemo_defaultStep"
    stepDetail_default.L_x = 80
    stepDetail_default.L_y = 250
    stepDetail_default.L_angle = 315
    stepDetail_default.L_mode = 2
    stepDetail_default.R_x = 320
    stepDetail_default.R_y = 250
    stepDetail_default.R_angle = 45
    stepDetail_default.R_mode = 2
    stepDetail_default.Order = 1
    
    newStep.stepDetails.append(stepDetail_default)

    let realm = try! Realm()
    // nameで指定したグループを取得
    let group = realm.objects(Group.self).filter("name == %@", name).first!
        // Realmのトランザクション内で、グループに新しいステップを追加する
        try! realm.write {
            group.steps.append(newStep)
        }
    
}
