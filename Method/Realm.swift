//
//  Realm.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/03.
//

import Foundation
import RealmSwift
import SwiftUI

func getStepList(groupName: String) -> [Step] {
    let realm = try! Realm()
    guard let group = realm.objects(Group.self).filter("name == %@", groupName).first else {
        // 該当するGroupが見つからなかった場合
        return []
    }
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

func updateStepDetail(step_id:String,index:Int,isR:Bool,location:CGPoint,angle:Angle)->(Step) {

    let realm = try! Realm()
    if let StepDetail = realm.objects(StepDetail.self).filter("step_id == %@ && Order == %@",step_id,index).first{
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
    }
    
    return getStep(step_id: step_id)
}

func updateMode(step_id:String,index:Int,isR:Bool,mode:Int)->(Step) {

    let realm = try! Realm()
    if let StepDetail = realm.objects(StepDetail.self).filter("step_id == %@ && Order == %@",step_id,index).first{
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
    if let step = realm.objects(Step.self).filter("id == %@", step_id).first {
        // `step`を使って何らかの処理を行う
        do{
          try realm.write{
              step.title = title
          }
        }catch {
          print("Error \(error)")
        }
    } else {
        // `step`がnilだった場合の処理
    }
    return getStep(step_id: step_id)
}

func addStepDetail(step_id:String,deviceWidth:Double,height:Double)->(step:Step, order:Int){
    
    let realm = try! Realm()
    if let step = realm.objects(Step.self).filter("id == %@",step_id).first{
        
        let stepDetail = realm.objects(StepDetail.self).filter("step_id == %@",step_id)
        
        let stepDetail_default = StepDetail()
        stepDetail_default.step_id = step_id
        stepDetail_default.imagename = "g1_s1_1"
        stepDetail_default.memo = ""
        stepDetail_default.L_x = deviceWidth/2 - 40
        stepDetail_default.L_y = height/2
        stepDetail_default.L_angle = 340
        stepDetail_default.L_mode = 2
        stepDetail_default.R_x = deviceWidth/2 + 40.0
        stepDetail_default.R_y = height/2
        stepDetail_default.R_angle = 20
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
    
    return (Step(),1)

}

func deleteStepDetail(step_id:String,index:Int) {

    let realm = try! Realm()
    guard let results = realm.objects(StepDetail.self).filter("step_id == %@ && Order == %@",step_id,index).first else {
        // 結果が見つからなかった場合の処理
        return
    }
    
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
func deleteGroup(groupName:String){
    // Realmのインスタンスを取得する
    let realm = try! Realm()
    // 指定された名前でGroupを検索する
    let groupToDelete = realm.objects(Group.self).filter("name == %@", groupName).first
    // もしGroupが存在したら、それをRealmから削除する
    if let group = groupToDelete {
        try! realm.write {
            realm.delete(group)
        }
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


func addStep(name:String,deviceWidth:Double,height:Double) {

    let newStep = Step()
    newStep.title = "untitled"
    newStep.created_at = Date()
    newStep.updated_at = Date()
    newStep.favorite = false

    let stepDetail_default = StepDetail()
    stepDetail_default.step_id = newStep.id
    stepDetail_default.imagename = "g1_s1_1"
    stepDetail_default.memo = ""
    stepDetail_default.L_x = deviceWidth/2 - 40
    stepDetail_default.L_y = height/2
    stepDetail_default.L_angle = 340
    stepDetail_default.L_mode = 2
    stepDetail_default.R_x = deviceWidth/2 + 40.0
    stepDetail_default.R_y = height/2
    stepDetail_default.R_angle = 20
    stepDetail_default.R_mode = 2
    stepDetail_default.Order = 1
    
    newStep.stepDetails.append(stepDetail_default)

    let realm = try! Realm()
    // nameで指定したグループを取得
    let group = realm.objects(Group.self).filter("name == %@", name).first!
    
    
    if let group = realm.objects(Group.self).filter("name == %@", name).first {
        // `group`オブジェクトが存在する場合の処理
        // Realmのトランザクション内で、グループに新しいステップを追加する
        try! realm.write {
            group.steps.append(newStep)
        }
    } else {
        // `group`オブジェクトがnilの場合の処理
    }
    
}

func addGroup(groupname:String)->Bool {
    
    var isError :Bool
    let realm = try! Realm()
    var groupList: [String] = []
    let groupData = realm.objects(Group.self)//.value(forKey: "name")
    
    for i in 0 ..< groupData.count {
        groupList.append(groupData[i].name)
    }
    
    if groupList.firstIndex(of: groupname)  != nil {
        isError = true
    }else{
        isError = false
        do{
            
          try realm.write{
              let group = Group()
              group.name = groupname
              realm.add(group)
          }
        }catch {
          print("Error \(error)")
        }
    }
    
    return isError
}

//グループ名の取得
func deleteAll() {

    let realm = try! Realm()
    try! realm.write {
      realm.deleteAll()
    }
}

func setStepData() {
    
    let base = "abcdefghijklmnopqrstuvwxyz"

    //１０文字のランダムな文字列を生成
    let randomStr = String((0..<10).map{ _ in base.randomElement()! })
    
    
    let group = Group()
    group.name = randomStr

    let step = Step()
    step.title = "step_1"
    step.created_at = Date()
    step.updated_at = Date()
    step.favorite = true

    let stepDetail_1 = StepDetail()
    stepDetail_1.step_id = step.id
    stepDetail_1.imagename = "g1_s1_1"
    stepDetail_1.memo = "memomemomemo_1"
    stepDetail_1.L_x = 100
    stepDetail_1.L_y = 100
    stepDetail_1.L_angle = 100
    stepDetail_1.L_mode = 2
    stepDetail_1.R_x = 300
    stepDetail_1.R_y = 200
    stepDetail_1.R_angle = 50
    stepDetail_1.R_mode = 1
    stepDetail_1.Order = 1
    
    let stepDetail_2 = StepDetail()
    stepDetail_2.step_id = step.id
    stepDetail_2.imagename = "g1_s1_2"
    stepDetail_2.memo = "memomemomemo_2"
    stepDetail_2.L_x = 120
    stepDetail_2.L_y = 120
    stepDetail_2.L_angle = 10
    stepDetail_2.L_mode = 1
    stepDetail_2.R_x = 320
    stepDetail_2.R_y = 220
    stepDetail_2.R_angle = 20
    stepDetail_2.R_mode = 2
    stepDetail_2.Order = 2
    
    let stepDetail_3 = StepDetail()
    stepDetail_3.step_id = step.id
    stepDetail_3.imagename = "g1_s1_3"
    stepDetail_3.memo = "memomemomemo_3"
    stepDetail_3.L_x = 80
    stepDetail_3.L_y = 90
    stepDetail_3.L_angle = 80
    stepDetail_3.L_mode = 2
    stepDetail_3.R_x = 300
    stepDetail_3.R_y = 290
    stepDetail_3.R_angle = 50
    stepDetail_3.R_mode = 3
    stepDetail_3.Order = 3
    
    step.stepDetails.append(stepDetail_1)
    step.stepDetails.append(stepDetail_2)
    step.stepDetails.append(stepDetail_3)
    group.steps.append(step)


    let realm = try! Realm()

    do{
      try realm.write{
          realm.add(group)
      }
    }catch {
      print("Error \(error)")
    }
}
