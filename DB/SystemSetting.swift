//
//  SystemSetting.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/23.
//

import Foundation
import RealmSwift

class SystemSetting: Object,Identifiable {
    
    @Persisted var isDark = true//表示モードの設定
    @Persisted var isFirst = true//初回起動の判定
    
}
