//
//  PrivacyPolicyView.swift
//  StepLogger
//
//  Created by rei asahina on 2023/03/20.
//

import SwiftUI

struct PrivacyPolicyView: View {

    @EnvironmentObject var appEnvironment: AppEnvironment
    @State var terms : [article]
    @State private var isDarkMode = true
    
    init(terms: [article] = [article]()) {
        self.terms = initializePrivacyPolicy()
    }
    

    var body: some View {
        
        let isDarkMode = appEnvironment.isDark
        let privacyPolicyData: [PrivacyPolicy] = load("PrivacyPolicy.json") 
        
        ZStack {
            ComponentColor.background_dark.ignoresSafeArea()
                .opacity(isDarkMode ? 1 : 0)
            ComponentColor.background_light.ignoresSafeArea()
                .opacity(isDarkMode ? 0 : 1)
            VStack {
                HStack {
                    Spacer()
                    Text("プライバシーポリシー")
                        .foregroundColor(isDarkMode ? .white : .black)
                    Spacer()
                }
                List {
                    Text("　StepDraft（以下、「当方」といいます。）は、本アプリ上で提供するサービス（以下、「本サービス」といいます。）における、ユーザーの個人情報の取扱いについて、以下のとおりプライバシーポリシー（以下、「本ポリシー」といいます。）を定めます。")
                        .font(.caption2)
                        .foregroundColor(isDarkMode ? .white : .black)
                        .listRowBackground(isDarkMode ? ComponentColor.list_dark : ComponentColor.list_light)
                    ForEach(0 ..< terms.count) { index in
                        VStack {
                            HStack {
                                Text("第\(index + 1)条")
                                    .font(.headline)
                                    .foregroundColor(isDarkMode ? .white : .black)
                                    .bold()
                                Text(terms[index].title)
                                    .font(.headline)
                                    .foregroundColor(isDarkMode ? .white : .black)
                                    .bold()
                                Spacer()
                            }
                            Text(terms[index].content)
                                .font(.caption)
                                .foregroundColor(isDarkMode ? .white : .black)
                        }
                        .listRowBackground(isDarkMode ? ComponentColor.list_dark : ComponentColor.list_light)
                    }
                    HStack {
                        Spacer()
                        Text("以上")
                            .font(.subheadline)
                            .foregroundColor(isDarkMode ? .white : .black)
                    }
                    .listRowBackground(isDarkMode ? ComponentColor.list_dark : ComponentColor.list_light)
                    HStack{
                        Spacer()
                        Text(system.copyright)
                            .font(.caption2)
                            .foregroundColor(isDarkMode ? .white : .black)
                        Spacer()
                    }
                    .listRowBackground(isDarkMode ? ComponentColor.list_dark : ComponentColor.list_light)
                }
                .listRowSeparatorTint(isDarkMode ? .white : .gray)
            }
        }
        .scrollDisabled(false)
        .scrollContentBackground(.hidden)
        .onAppear(){
            print(privacyPolicyData)
        }
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}

func initializePrivacyPolicy()->[article]{
    let terms : [article] = [
        article(title : "個人情報", content : "　「個人情報」とは、個人情報保護法にいう「個人情報」を指すものとし、生存する個人に関する情報であって、当該情報に含まれる氏名、生年月日、住所、電話番号、連絡先その他の記述等により特定の個人を識別できる情報及び容貌、指紋、声紋にかかるデータ、及び健康保険証の保険者番号などの当該情報単体から特定の個人を識別できる情報（個人識別情報）を指します。"),
        article(title : "個人情報の収集方法", content : "　当方は、ユーザーが利用登録をする際に氏名、生年月日、住所、電話番号、メールアドレス、銀行口座番号、クレジットカード番号、運転免許証番号などの個人情報をお尋ねすることがあります。また、ユーザーと提携先などとの間でなされたユーザーの個人情報を含む取引記録や決済に関する情報を、当方の提携先（情報提供元、広告主、広告配信先などを含みます。以下、｢提携先｣といいます。）などから収集することがあります。"),
        article(title : "個人情報を収集・利用する目的", content : "　当方が個人情報を収集・利用する目的は、以下のとおりです。\n　・当方サービスの提供・運営のため\n　・ユーザーからのお問い合わせに回答するため（本人確認を行うことを含む）\n　・ユーザーが利用中のサービスの新機能、更新情報、キャンペーン等及び当方が提供する他のサービスの案内のメールを送付するため\n　・メンテナンス、重要なお知らせなど必要に応じたご連絡のため\n　・利用規約に違反したユーザーや、不正・不当な目的でサービスを利用しようとするユーザーの特定をし、ご利用をお断りするため\n　・ユーザーにご自身の登録情報の閲覧や変更、削除、ご利用状況の閲覧を行っていただくため\n　・有料サービスにおいて、ユーザーに利用料金を請求するため\n　・上記の利用目的に付随する目的"),
        article(title : "利用目的の変更", content : "　当方は、利用目的が変更前と関連性を有すると合理的に認められる場合に限り、個人情報の利用目的を変更するものとします。\n　利用目的の変更を行った場合には、変更後の目的について、当方所定の方法により、ユーザーに通知し、または本アプリ上に公表するものとします。"),
        article(title : "個人情報の第三者提供", content : "　当方は、次に掲げる場合を除いて、あらかじめユーザーの同意を得ることなく、第三者に個人情報を提供することはありません。ただし、個人情報保護法その他の法令で認められる場合を除きます。\n　・人の生命、身体または財産の保護のために必要がある場合であって、本人の同意を得ることが困難であるとき\n　・公衆衛生の向上または児童の健全な育成の推進のために特に必要がある場合であって、本人の同意を得ることが困難であるとき\n　・国の機関もしくは地方公共団体またはその委託を受けた者が法令の定める事務を遂行することに対して協力する必要がある場合であって、本人の同意を得ることにより当該事務の遂行に支障を及ぼすおそれがあるとき\n　・予め次の事項を告知あるいは公表し、かつ当方が個人情報保護委員会に届出をしたとき\n　1.利用目的に第三者への提供を含むこと\n　2.第三者に提供されるデータの項目\n　3.第三者への提供の手段または方法\n　4.本人の求めに応じて個人情報の第三者への提供を停止すること\n　5.本人の求めを受け付ける方法\n 前項の定めにかかわらず、次に掲げる場合には、当該情報の提供先は第三者に該当しないものとします。 \n　・当方が利用目的の達成に必要な範囲内において個人情報の取扱いの全部または一部を委託する場合\n　・合併その他の事由による事業の承継に伴って個人情報が提供される場合\n　・個人情報を特定の者との間で共同して利用する場合であって、その旨並びに共同して利用される個人情報の項目、共同して利用する者の範囲、利用する者の利用目的および当該個人情報の管理について責任を有する者の氏名または名称について、あらかじめ本人に通知し、または本人が容易に知り得る状態に置いた場合"),
        article(title : "個人情報の開示", content : "　当方は、本人から個人情報の開示を求められたときは、本人に対し、遅滞なくこれを開示します。ただし、開示することにより次のいずれかに該当する場合は、その全部または一部を開示しないこともあり、開示しない決定をした場合には、その旨を遅滞なく通知します。なお、個人情報の開示に際しては、1件あたり1,000円の手数料を申し受けます。\n　・本人または第三者の生命、身体、財産その他の権利利益を害するおそれがある場合\n　・当方の業務の適正な実施に著しい支障を及ぼすおそれがある場合\n　・その他法令に違反することとなる場合\n　前項の定めにかかわらず、履歴情報および特性情報などの個人情報以外の情報については、原則として開示いたしません"),
        article(title : "個人情報の訂正および削除", content : "　ユーザーは、当方の保有する自己の個人情報が誤った情報である場合には、当方が定める手続きにより、当方に対して個人情報の訂正、追加または削除（以下、「訂正等」といいます。）を請求することができます。\n　当方は、ユーザーから前項の請求を受けてその請求に応じる必要があると判断した場合には、遅滞なく、当該個人情報の訂正等を行うものとします。\n　当方は、前項の規定に基づき訂正等を行った場合、または訂正等を行わない旨の決定をしたときは遅滞なく、これをユーザーに通知します。"),
        article(title : "個人情報の利用停止等", content : "　当方は、本人から、個人情報が、利用目的の範囲を超えて取り扱われているという理由、または不正の手段により取得されたものであるという理由により、その利用の停止または消去（以下、「利用停止等」といいます。）を求められた場合には、遅滞なく必要な調査を行います。\n　前項の調査結果に基づき、その請求に応じる必要があると判断した場合には、遅滞なく、当該個人情報の利用停止等を行います。\n　当方は、前項の規定に基づき利用停止等を行った場合、または利用停止等を行わない旨の決定をしたときは、遅滞なく、これをユーザーに通知します。\n　前2項にかかわらず、利用停止等に多額の費用を有する場合その他利用停止等を行うことが困難な場合であって、ユーザーの権利利益を保護するために必要なこれに代わるべき措置をとれる場合は、この代替策を講じるものとします。"),
        article(title : "プライバシーポリシーの変更", content : "　本ポリシーの内容は、法令その他本ポリシーに別段の定めのある事項を除いて、ユーザーに通知することなく、変更することができるものとします。\n　当方が別途定める場合を除いて、変更後のプライバシーポリシーは、本アプリに掲載したときから効力を生じるものとします。")
    ]
    return terms
}
