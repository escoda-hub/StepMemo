//
//  memoInputView.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/11.
//

import SwiftUI

struct memoInputView: View {
    
    @FocusState private var isFocused: Bool
    @Binding var stepData:Step
    @Binding var showMemoView : Bool
    @State var index:Int
    
    init(stepData: Binding<Step>, showMemoView: Binding<Bool>,index:Int) {
        self._stepData = stepData
        self._showMemoView = showMemoView
        self.index = index
    }
    
    var body: some View {
        VStack {
            TextField("メモ", text: $stepData.stepDetails[index].memo,axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                .lineLimit(3...5)
            Button("完了") {
                showMemoView = false
            }
        }
        
    }
    
}

//struct memoInputView_Previews: PreviewProvider {
//    static var previews: some View {
//        memoInputView()
//    }
//}
