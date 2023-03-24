import Foundation
import SwiftUI
import RealmSwift
import UIKit
import GoogleMobileAds

class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      migration()
//      print("アプリが起動したよ")
      print(Realm.Configuration.defaultConfiguration.fileURL!)
      GADMobileAds.sharedInstance().start(completionHandler: nil)
      return true
  }
    
    func applicationWillTerminate(_ application: UIApplication) {
//        print("アプリを終了させたよ")
    }

}

// Realmマイグレーション処理
func migration() {
  // 次のバージョン（現バージョンが０なので、１をセット）
    let nextSchemaVersion : UInt64 = 35

  // マイグレーション設定
  let config = Realm.Configuration(
    schemaVersion: nextSchemaVersion,
    migrationBlock: { migration, oldSchemaVersion in
      if (oldSchemaVersion < nextSchemaVersion) {
         
      }
    })
    Realm.Configuration.defaultConfiguration = config
}


