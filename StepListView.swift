
import SwiftUI

struct StepListView: View {

    @State var ViewTitle :String
    
    var body: some View {
        VStack {
            NavigationView{
                List(Array(stepListData.indices),id:\.self){index in //Key-Path Expression : プロパティへ動的にアクセスするための表記
                    NavigationLink(destination:StepView(step:stepListData[index])){
                        StepRowView(step: stepListData[index])
                    }
                    .frame(height: 70)//概要セルのサイズ
                }
            }
            .navigationBarTitle(ViewTitle, displayMode: .inline)
        }
    }
}

struct StepListView_Previews: PreviewProvider {
    static var previews: some View {
        StepListView(ViewTitle:"hi")
    }
}
