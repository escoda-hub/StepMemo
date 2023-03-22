//
//  Realm.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/03.
//

import Foundation
import RealmSwift
import SwiftUI

/// ステップを取得する
/// - Parameters:
///   - mode: ステップの取得モード（全て、更新順、お気に入り、グループごと）
///   - groupID: グループに紐づくステップを取得する際にキーとして使用する
/// - Returns:  Results<Step> ：ステップ取得クエリを実行して得られた結果
func getStepLists(mode: filterMode, groupID: String) -> Results<Step> {
    let realm = try! Realm()
    switch mode {
    case .all:
        let results: Results<Step> = realm.objects(Step.self)
        return results
    case .rescent:
        let sortProperties = [SortDescriptor(keyPath: "updated_at", ascending: false)]
        let results: Results<Step> = realm.objects(Step.self).sorted(by: sortProperties)
        return results
    case .favorite:
        let results: Results<Step> = realm.objects(Step.self).filter("favorite == true")
        return results
    case .groupID:
        guard let group = realm.objects(Group.self).filter("id == %@", groupID).first else {
            fatalError("Group not found")
        }
        let results: Results<Step> = realm.objects(Step.self).filter("group_id == %@", group.id)
        return results
    }
}

/// グループIDに紐づくグループ名を取得する
/// - Parameter group_id: グループID
/// - Returns: グループ名
func getGroupName(group_id:String) -> (String) {
    let realm = try! Realm()
    
    if let group = realm.objects(Group.self).filter("id == %@", group_id).first {
        return group.name
    }
    return ""
}

/// グループ名に紐づくグループIDを取得する
/// - Parameter groupName: グループ名
/// - Returns: グループID
func getGroupID(groupName:String) -> (String) {
    let realm = try! Realm()
    guard let group = realm.objects(Group.self).filter("name == %@", groupName).first else {
        // 該当するGroupが見つからなかった場合
        return ""
    }
    return group.id
}

/// ステップIDからステップオブジェクトを取得する
/// - Parameter step_id: ステップID
/// - Returns: ステップオブジェクト
func getStep(step_id: String) -> Step {
    
    let realm = try! Realm()
    guard let stepData = realm.object(ofType: Step.self, forPrimaryKey: step_id) else {
        // 該当するGroupが見つからなかった場合
        return Step()
    }

    return stepData
}

/// ステップIDに紐づく、ステップの空間情報（位置、角度）を更新する
/// - Parameters:
///   - step_id: ステップID
///   - index: ステップ詳細データのインデックス
///   - isR: 右足か
///   - location: 位置
///   - angle: 角度
/// - Returns: 更新されたステップオブジェクト
func updateStepDetail(step_id:String,index:Int,isR:Bool,location:CGPoint,angle:Angle)->(Step) {

    let realm = try! Realm()
    if let StepDetail = realm.objects(StepDetail.self).filter("step_id == %@ && Order == %@",step_id,index).first{
        if let step = realm.objects(Step.self).filter("id == %@", step_id).first {
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
                  step.updated_at = Date()
              }
            }catch {
              print("Error \(error)")
            }
        }
 
    }
    
    return getStep(step_id: step_id)
}

/// ステップIDに紐づく足のモードを更新する
/// - Parameters:
///   - step_id: ステップID
///   - index: ステップ詳細データのインデックス
///   - isR: 右足か
///   - mode: モード（つま先、平足、かかと、空中）
/// - Returns: 更新されたステップオブジェクト
func updateMode(step_id:String,index:Int,isR:Bool,mode:Int)->(Step) {

    let realm = try! Realm()
    if let StepDetail = realm.objects(StepDetail.self).filter("step_id == %@ && Order == %@",step_id,index).first{
        if let step = realm.objects(Step.self).filter("id == %@", step_id).first {
            do{
              try realm.write{
                  if isR {
                      StepDetail.R_mode = mode
                  }else{
                      StepDetail.L_mode = mode
                  }
                  step.updated_at = Date()
              }
                
            }catch {
              print("Error \(error)")
            }
        }
    }

    return getStep(step_id: step_id)
}

/// ステップIDとステップ詳細インデックスに紐づくメモを更新する
/// - Parameters:
///   - step_id: ステップID
///   - index: ステップ詳細データのインデックス
///   - memo: ステップ詳細データのインデックスに紐づくメモ
/// - Returns: 更新されたステップオブジェクト
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

/// タイトルを更新する
/// - Parameters:
///   - step_id: ステップID
///   - title: 更新したいタイトル
/// - Returns: 更新されたステップオブジェクト
func upDateTitle(step_id:String,title:String)->(Step) {

    let realm = try! Realm()
    if let step = realm.objects(Step.self).filter("id == %@", step_id).first {
        // `step`を使って何らかの処理を行う
        do{
          try realm.write{
              step.title = title
              step.updated_at = Date()
          }
        }catch {
          print("Error \(error)")
        }
    } else {
        // `step`がnilだった場合の処理
    }
    return getStep(step_id: step_id)
}

/// お気に入り情報を更新する
/// - Parameter step_id: ステップID
/// - Returns: 更新されたステップオブジェクト
func upDateFavorite(step_id:String)->(Step) {

    let realm = try! Realm()
    if let step = realm.objects(Step.self).filter("id == %@", step_id).first {
        
        do{
          try realm.write{
              step.toggleFavorite()
              step.updated_at = Date()
          }
        }catch {
          print("Error \(error)")
        }

    } else {
        // `step`がnilだった場合の処理
    }
    return getStep(step_id: step_id)
}

/// ステップ詳細データを追加する
/// - Parameters:
///   - step_id:ステップ詳細データが属するステップのID
///   - deviceWidth: デバイスの横幅
///   - height: ステップ操作画面の高さ
/// - Returns: ステップオブジェクトと追加された順番
func addStepDetail(step_id:String,deviceWidth:Double,height:Double)->(step:Step, order:Int){
    
    let realm = try! Realm()
    if let step = realm.objects(Step.self).filter("id == %@",step_id).first{
        
        let stepDetail = realm.objects(StepDetail.self).filter("step_id == %@",step_id)
        
        let stepDetail_default = StepDetail()
        stepDetail_default.step_id = step_id
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
              step.updated_at = Date()
              step.stepDetails.append(stepDetail_default)
          }
        }catch {
          print("Error \(error)")
        }
        
        return (getStep(step_id: step_id),stepDetail_default.Order)
    }
    
    return (Step(),1)

}

/// ステップを削除する
/// - Parameter step_id: ステップID
func deleteStep(step_id: String) {
    let realm = try! Realm()
    guard let step = realm.object(ofType: Step.self, forPrimaryKey: step_id) else {
        // idに対応するStepが存在しない場合の処理
        return
    }
    try! realm.write {
        realm.delete(step)
//        print("delete")
    }
}

/// ステップ詳細データを削除する
/// - Parameters:
///   - step_id: 削除したいステップ詳細データが属するステップのID
///   - index: 削除したいステップ詳細データのインデックス
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

/// 全てのグループを取得する
/// - Returns: グループオブジェクトリスト
func getGroup() -> Results<Group> {
    let realm = try! Realm()
    let groups = realm.objects(Group.self)
    return groups
}

/// グループ名からグループを削除する
/// - Parameter groupName: グループ名
func deleteGroup(groupName:String){
    // Realmのインスタンスを取得する
    let realm = try! Realm()
    // 指定された名前でGroupを検索する
    let groupsToDelete = realm.objects(Group.self).filter("name == %@", groupName)
    
    if groupsToDelete.count > 0 {
        // 全てのGroupオブジェクトを削除する
        try? realm.write {
            realm.delete(groupsToDelete)
        }
    }
}

/// ステップが所属するグループを変更する
/// - Parameters:
///   - oldGroupName: 所属しているグループ名
///   - newGroupName: 移動さきのグループ名
///   - step_id: 移動させたいステップのステップID
func changeGroup(oldGroupName: String, newGroupName: String, step_id: String) {
    
    if oldGroupName != newGroupName{
        let realm = try! Realm()
        try! realm.write {
            // 移動元と移動先のGroupオブジェクトを取得する
            guard let oldGroup = realm.objects(Group.self).filter("name == %@", oldGroupName).first,
                  let newGroup = realm.objects(Group.self).filter("name == %@", newGroupName).first else {
                return
            }
            // 移動対象のStepオブジェクトを取得する
            guard let step = oldGroup.steps.first(where: { $0.id == step_id }) else {
                return
            }
            // 移動元からStepオブジェクトを削除する
            if let index = oldGroup.steps.firstIndex(where: { $0.id == step_id }) {
                oldGroup.steps.remove(at: index)
            }

            step.group_id = newGroup.id// Stepオブジェクトのgroup_idを更新する
            newGroup.steps.append(step)// 移動先にStepオブジェクトを追加する
            
        }
    }
}

/// グループIDをもとにステップデータを追加する
/// - Parameters:
///   - groupID: グループID
///   - deviceWidth: デバイスの横幅
///   - height: ステップ操作画面の高さ
/// - Returns: ステップデータが追加されたステップオブジェクト
func addStepFromId(groupID:String,deviceWidth:Double,height:Double) -> Step{

    let newStep = Step()
    newStep.title = "untitled"
    newStep.created_at = Date()
    newStep.updated_at = Date()
    newStep.favorite = false
    newStep.group_id = groupID

    let stepDetail_default = StepDetail()
    stepDetail_default.step_id = newStep.id
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
    if let group = realm.objects(Group.self).filter("id == %@", groupID).first {
        // Realmのトランザクション内で、グループに新しいステップを追加する
        try! realm.write {
            group.steps.append(newStep)
        }
    } else {
        // `group`オブジェクトがnilの場合の処理
    }

    return newStep
}

/// ステップデータを追加する
/// - Parameters:
///   - name: 追加するグループ名
///   - deviceWidth: デバイスの横幅
///   - height: ステップ操作画面の高さ
/// - Returns: ステップデータが追加されたステップオブジェクト
func addStep(name:String,deviceWidth:Double,height:Double) -> Step{

    let newStep = Step()
    newStep.title = "untitled"
    newStep.created_at = Date()
    newStep.updated_at = Date()
    newStep.favorite = false
    newStep.group_id = getGroupID(groupName: name)

    let stepDetail_default = StepDetail()
    stepDetail_default.step_id = newStep.id
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
    if let group = realm.objects(Group.self).filter("name == %@", name).first {
        // Realmのトランザクション内で、グループに新しいステップを追加する
        try! realm.write {
            group.steps.append(newStep)
        }
    } else {
        // `group`オブジェクトがnilの場合の処理
    }

    return newStep
}

/// グループの存在を確認する
/// - Parameter groupname: 存在を確認したいグループ名
/// - Returns: グループが既に存在する(t)
func checkGroup(groupname:String)->Bool{
    let realm = try! Realm()
    if let group = realm.objects(Group.self).filter("name == %@", groupname).first {
        return true
    }
    return false
}

/// グループ追加
/// - Parameter groupName: 追加したいグループ名
/// - Returns: グループが既に存在する（t）
func addNewGroupIfNeeded(groupName: String)->Bool {
    
    let realm = try! Realm()
    let existingGroup = realm.objects(Group.self).filter("name = %@", groupName).first

    if existingGroup == nil {
        let newGroup = Group()
        newGroup.name = groupName
        try! realm.write {
            realm.add(newGroup)
        }

        return false
    }else{
        return true
    }
    
     return false
}

//デバッグ用：DBデータ全削除
func deleteAll() {

    let realm = try! Realm()
    try! realm.write {
      realm.deleteAll()
    }
}

/// デバッグ用：シーダー
func setStepData() {
    
    let base = "abcdefghijklmnopqrstuvwxyz1234567890/:*=~^|¥<,>.?/"

    //１０文字のランダムな文字列を生成
    let randomStr = String((0..<10).map{ _ in base.randomElement()! })
    
    let group = Group()
    group.name = randomStr

    let step = Step()
    step.title = "step_1"
    step.group_id = group.id
    step.created_at = Date()
    step.updated_at = Date()
    step.favorite = true

    let stepDetail_1 = StepDetail()
    stepDetail_1.step_id = step.id
    stepDetail_1.memo = "memo1"
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
    stepDetail_2.memo = "memo2"
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
    stepDetail_3.memo = "memo3"
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
