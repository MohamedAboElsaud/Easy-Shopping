//
//  SectionTitleAll.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 19/02/2025.
//

import SwiftUI

struct SectionTitleAll: View {
    @State var title = "title"
    @State var titleAll = "view all"
    var didTap: (() -> Void)?
    var body: some View {
        HStack {
            Text(title)
                .font(.customFont(.semibold, fontSize: 24))
                .foregroundColor(.primaryText)

            Spacer()
            Text(titleAll)
                .font(.customFont(.semibold, fontSize: 16))
                .foregroundColor(.primaryApp)
        }
        .frame(height: 40)
    }
}

struct SectionTitleAll_Previews: PreviewProvider {
    static var previews: some View {
        SectionTitleAll()
            .padding(20)
    }
}
