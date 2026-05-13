//
//  GoalAddRowView.swift
//  mygoalai
//
//  Created by Alexander Orlov on 27.10.2025.
//

import SwiftUI
import Combine
import SafeSFSymbols

struct GoalAddRowView: View {
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            Image(.plus.appFill)
                .resizable()
                .renderingMode(.template)
                .frame(width: 25, height: 25)
                .foregroundStyle(Color.black)
            Text("Добавить")
                .font(.system(.callout, weight: .regular))
                .foregroundStyle(Color.black)
            Spacer()
        }
    }
}
