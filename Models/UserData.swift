//監視可能オブジェクト (Observable Object)
//監視したいデータを一つのクラスとしてまとめた物

import SwiftUI
import Combine
 
final class UserData: ObservableObject  {
    @Published var showFavoritesOnly = false
//    @Published var landmarks = landmarkData
    @Published var steps = stepListData
}
