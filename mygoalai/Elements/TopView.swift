//
//  TopView.swift
//  mygoalai
//
//  Created by Alexander Orlov on 27.10.2025.
//

import SwiftUI
import Combine

struct TopView: View {
    var title: String = ""
    
    var body: some View {
        HStack(spacing: 0) {
            Text(title)
                .font(.system(.title2, weight: .bold))
                .foregroundStyle(Color.white)
            Spacer()
        }
        .padding(.leading, 16)
        .padding(.trailing, 16)
        
    }
}
