//
//  PreferenceSectionView.swift
//  eul
//
//  Created by Gao Sun on 2020/10/24.
//  Copyright © 2020 Gao Sun. All rights reserved.
//

import SwiftUI

extension Preference {
    enum Section: String, Identifiable, CaseIterable {
        case general
        case components
        case menuView

        var id: String {
            rawValue
        }

        var localizedDescription: String {
            switch self {
            case .general:
                return "ui.general".localized()
            case .components:
                return "ui.components".localized()
            case .menuView:
                return "ui.menu_view".localized()
            }
        }

        var symbolName: String {
            switch self {
            case .general:
                return "gearshape"
            case .components:
                return "rectangle.3.group"
            case .menuView:
                return "menubar.rectangle"
            }
        }
    }

    struct PreferenceSectionView: View {
        @Binding var activeSection: Section
        let section: Section

        var isActive: Bool {
            activeSection == section
        }

        var body: some View {
            Button(action: {
                activeSection = section
            }) {
                HStack(spacing: 8) {
                    Image(systemName: section.symbolName)
                        .frame(width: 14)
                    Text(section.localizedDescription)
                        .inlineSection()
                    Spacer()
                }
                .foregroundColor(.primary)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(isActive ? Color.primary.opacity(0.08) : Color.clear)
                .cornerRadius(6)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}
