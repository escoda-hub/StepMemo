//リストビューの一つ一つの行データを構成する構造体を作る

import SwiftUI

struct StepRowView: View {
    var step:StepList//JSONから読み込んで生成した，stepモデル使うためのプロパティを定義
    
    var body: some View {
        VStack(alignment: .leading){
            Text(step.title).font(.title)
            HStack{
                Text(step.created_at)
            }
        }.padding()
    }
}

struct StepRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            StepRowView(step: stepListData[0])
                .previewLayout(.sizeThatFits)
        }
    }
}
