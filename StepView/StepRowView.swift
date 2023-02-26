//リストビューの一つ一つの行データを構成する構造体を作る

import SwiftUI

struct StepRowView: View {
//    var step:StepList//JSONから読み込んで生成した，stepモデル使うためのプロパティを定義
    var title:String
    var update_at:String
    
    var body: some View {
        VStack(alignment: .leading){
            Text(title).font(.title)
            HStack{
                Text(update_at)
            }
        }.padding()
    }
}

struct StepRowView_Previews: PreviewProvider {
    static var previews: some View {
//        Group{
            StepRowView(title: "titiledata", update_at: "2023-11-11")
                .previewLayout(.sizeThatFits)
//        }
    }
}
