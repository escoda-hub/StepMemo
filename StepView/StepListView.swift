
import SwiftUI

struct StepListView: View {

    @State var ViewTitle :String
    
    var body: some View {

//        NavigationView{
        
            ZStack {
                VStack {
                    Text(ViewTitle)
                    List(Array(stepListData.indices),id:\.self){index in //Key-Path Expression : プロパティへ動的にアクセスするための表記
                        NavigationLink(destination:StepView(step:stepListData[index])){
                            StepRowView(step: stepListData[index])
                        }
                        .frame(height: 70)//概要セルのサイズ
                    }
                }
                VStack {
                    Spacer()
                    HStack { // --- 2
                        Spacer()
                        Button(action: {
                            print("Tapped!!") // --- 3
                        }, label: {
                            Image(systemName: "pencil")
                                .foregroundColor(.white)
                                .font(.system(size: 24)) // --- 4
                        })
                            .frame(width: 60, height: 60)
                            .background(Color.orange)
                            .cornerRadius(30.0)
                            .shadow(color: .gray, radius: 3, x: 3, y: 3)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 16.0, trailing: 16.0)) // --- 5
                    }
                }
            }
            
//        }
    }
    
}

struct StepListView_Previews: PreviewProvider {
    static var previews: some View {
        StepListView(ViewTitle:"title sample")
    }
}
