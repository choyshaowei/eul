//
//  View.swift
//  eul
//
//  Created by Gao Sun on 2020/9/11.
//  Copyright © 2020 Gao Sun. All rights reserved.
//

import SwiftUI

extension View {
    func menuInfo() -> some View {
        font(.system(size: 14, weight: .regular))
            .foregroundColor(.info)
            .padding(.leading, 20)
            .padding(.trailing, 12)
            .padding(.top, -2)
            .padding(.bottom, 4)
            .fixedSize()
    }

    func menuBlock(radius: CGFloat = 8) -> some View {
        padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .fill(Color.controlBackground.opacity(0.72))
                    .overlay(
                        RoundedRectangle(cornerRadius: radius, style: .continuous)
                            .stroke(Color.primary.opacity(0.08), lineWidth: 1)
                    )
            )
    }
}
