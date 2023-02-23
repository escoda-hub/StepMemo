//SwiftUI.TextField に returnKeyType を設定するために Notification を活用する
//https://zenn.dev/konomae/articles/5855ba8ac39ec8


import SwiftUI
import Combine
import RealmSwift

struct EditGroupView: View {

    @Environment(\.dismiss) var dismiss
    @FocusState var focus:Bool
    @State var enable: Bool = false
    @State var isHidden: Bool = true
    @State var text = ""
//    @Binding var category : String
    
    
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
                            print("groupname is \(text)")
                            addGroup(groupname: text)
                            dismiss()
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

func addGroup(groupname:String) {
    
    let group = Group()
    group.name = groupname
    let realm = try! Realm()
    
    try! realm.write {
        realm.add(group)
    }
}
