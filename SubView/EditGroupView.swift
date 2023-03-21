
import SwiftUI
import Combine
import RealmSwift

struct EditGroupView: View {

    @EnvironmentObject var appEnvironment: AppEnvironment
    @Environment(\.dismiss) var dismiss
    @FocusState var focus:Bool
    @State var isHidden: Bool = true
    @State var text = ""
    @State private var showingAlert_exist = false
    @State private var showingAlert_empty = false
    @State private var showingAlert = false
    @State  private var isDarkMode = true
    
    @State var alertText = ""
    
    var body: some View {
        
        let isDarkMode = appEnvironment.isDark
        let textLimit = system.maxGroupName
        
        ZStack {
            ComponentColor.background_dark.ignoresSafeArea()
                .opacity(isDarkMode ? 1 : 0)
            ComponentColor.background_light.ignoresSafeArea()
                .opacity(isDarkMode ? 0 : 1)
            VStack {
                HStack{
                    Button(action: {
                        dismiss()
                    }){
                        BtnCancel(isDarkMode: isDarkMode,size: 15)
                            .padding()
                    }
                    Spacer()
                    Text("新規グループ名")
                        .font(.subheadline)
                        .accessibilityAddTraits(.isHeader)
                        .foregroundColor(isDarkMode ? .white : .black)
                    Spacer()
                    Button(action: {
                        if text.count > 0 {
                            if addGroup(groupname: text) {
                                self.showingAlert = true
                                alertText = AlertData.Alert_1001.rawValue
                            }else{
                                appEnvironment.path.removeAll()//after transitioning, MainList doesn't update. So,I added this line.
                                dismiss()
                            }
                        }else{
                            self.showingAlert = true
                            alertText = AlertData.Alert_1002.rawValue
                        }
                    }){
                        BtnComplete(isDarkMode: isDarkMode, size: 15)
                            .padding()
                    }
                    .alert(isPresented: ($showingAlert)) {
                        Alert(title: Text(alertText))
                    }
                }
                    Spacer()
                    TextField("グループ名", text: self.$text)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .font(.title)
                        .keyboardType(.asciiCapable)
                        .foregroundColor(isDarkMode ? .black : .white)
                        .focused(self.$focus)
                        .onAppear(){
                            self.focus = true
                            isHidden = true
                        }
                        .onChange(of: text) { newValue in
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
        }
    }
}

