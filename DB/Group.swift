//
//  Group.swift
//  StepLogger
//
//  Created by rei asahina on 2023/02/20.
//SwiftではUUIDが128bit(=16byte)の数値として表されデータ型はUUID型

import Foundation
import RealmSwift

class Group: Object,Identifiable {
    
    @Persisted var name:String
    @Persisted var steps: List<Step>

}
