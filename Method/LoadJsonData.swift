
import UIKit
import SwiftUI
import CoreLocation
 
//JSONからオブジェクトの生成
func load<T: Decodable>(_ filename: String) -> T { // ラベルなしで引数を受け取る(T = Step)
    let data: Data
    // 受け取ったファイル名からURL?オブジェクトを取得
    // URLオブジェクトはただの文字列を持つオブジェクトではなく，URL操作が容易なオブジェクト
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    
    // URLからDataオブジェクトに変換
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    // さらにJSONデータからの変換を試みる
    do {
        let decoder = JSONDecoder()
        // もし成功すれば，ジェネリクスとして受け取ったDecodableなクラス・構造体<T>をデコードして返す
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
