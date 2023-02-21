//SwiftUI.TextField に returnKeyType を設定するために Notification を活用する
//https://zenn.dev/konomae/articles/5855ba8ac39ec8


import SwiftUI

struct EditGroupView: View {
    
    @Environment(\.dismiss) var dismiss
    @FocusState var focus:Bool
    @State var enable: Bool = true
    @State var text = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Group name", text: self.$text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .keyboardType(.asciiCapable)
                    .focused(self.$focus)
                    .onAppear(){
                        self.focus = true
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    // 通知を受信する
                    .onReceive(
                        NotificationCenter.default.publisher(for: UITextField.textDidBeginEditingNotification),
                        perform: textDidBeginEditing
                    )
                    .onAppear(){
                        enable = false
                    }
                    .onChange(of: text) { newValue in
                        if newValue.count > 0 {
                            enable = true
                        }
                    }
            }
            .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            print("canceled")
                           dismiss()
                        }) {
                            Text("キャンセル")
                        }
                    }
                    ToolbarItem(placement: .principal) {
                        Text("グループリスト")
                            .font(.subheadline)
                            .accessibilityAddTraits(.isHeader)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            print("完了")
                        }){
                            HStack {
                                Text("完了")
                            }
                        }
                        .disabled(!enable)
                    }
                }
        }
    }
}

struct EditGroupView_Previews: PreviewProvider {
    static var previews: some View {
        EditGroupView()
    }
}


func textDidBeginEditing(_ notification: Notification) {
     // UITextField を取り出せる
     let textField = notification.object as! UITextField
     // returnKeyType を設定できる
     textField.returnKeyType = .done
 }
