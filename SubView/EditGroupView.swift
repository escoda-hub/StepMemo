
import SwiftUI
import Combine
import RealmSwift

struct EditGroupView: View {

    @EnvironmentObject var appEnvironment: AppEnvironment
    @Environment(\.dismiss) var dismiss
    @FocusState var focus:Bool
    @State var enable: Bool = false
    @State var isHidden: Bool = true
    @State var text = ""
    @State private var showingAlert = false
    
    let textLimit = 10 //最大文字数
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Image(systemName: "rectangle.3.group")
                    .resizable()
                    .frame(width: 40,height: 40)
                    .foregroundColor(.gray)
                Spacer()
                TextField("グループ名", text: self.$text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .font(.title)
                    .keyboardType(.asciiCapable)
                    .focused(self.$focus)
                    .onAppear(){
                        self.focus = true
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onAppear(){
                        enable = false
                        isHidden = true
                    }
                    .onChange(of: text) { newValue in
                        if newValue.count > 0 {
                            enable = true
                        }
                        
                        if newValue.count >= textLimit {
                            isHidden = false
                        }else{
                            isHidden = true
                        }
                    }
                    .onReceive(Just(text)) { _ in
                        //最大文字数を超えたら、最大文字数までの文字列を代入する
                        if text.count > textLimit {
                            text = String(text.prefix(textLimit))
                        }
                    }
                if !isHidden{
                    Text("最大文字数は、\(textLimit)文字です")
                        .foregroundColor(.red)
                }else{
                    Text(" ")
                }
                Spacer()
                Spacer()
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
                        Text("新規グループ名")
                            .font(.subheadline)
                            .accessibilityAddTraits(.isHeader)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            if addGroup(groupname: text) {
                                self.showingAlert = true
                            }else{
                                self.showingAlert = false
                                appEnvironment.path.removeAll()//after transitioning, MainList doesn't update. So,I added this line.
                                dismiss()
                            }
                        }){
                            HStack {
                                Text("完了")
                            }
                        }
                        .disabled(!enable)
                        .alert(isPresented: $showingAlert) {  // ③アラートの表示条件設定
                            Alert(title: Text("入力されたグループは既に存在します。"))     // ④アラートの定義
                        }
                    }
                }
        }
    }
}

