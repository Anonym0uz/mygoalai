//
//  GoalRowView.swift
//  mygoalai
//
//  Created by Alexander Orlov on 27.10.2025.
//

import SwiftUI
import Combine

struct GoalRowView: View {
    @State var item: Goal
    
    var body: some View {
        //        HStack {
        return VStack(alignment: .center) {
            Text(item.title ?? "")
                .frame(maxWidth: .infinity)
                .font(.system(size: 15))
                .lineLimit(nil)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundStyle(Color.black)
                .padding()
            if item.steps == nil || (item.steps ?? []).isEmpty {
                Text("Список пуст!")
                    .font(.system(.footnote, design: .default, weight: .medium))
                    .foregroundStyle(Color.black)
                    .padding(.bottom, 10)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
            } else {
                ProgressView(value: item.calculatePercent(), total: 100)
                    .progressViewStyle(CustomProgressViewStyle())
                    .padding(.bottom, 10)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
            }
            
            //                    .multilineTextAlignment(.leading)
//            generateSteps()
        }
        .background(item.calculatePercent() == 100 ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
        .clipShape(.rect(cornerRadius: 10))
        //        }
        
    }
}
