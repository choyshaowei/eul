//
//  StatusMenuView.swift
//  eul
//
//  Created by Gao Sun on 2020/9/20.
//  Copyright © 2020 Gao Sun. All rights reserved.
//

import SwiftUI

struct StatusMenuView: SizeChangeView {
    @EnvironmentObject var uiStore: UIStore
    @EnvironmentObject var preferenceStore: PreferenceStore
    @EnvironmentObject var menuComponentsStore: ComponentsStore<EulMenuComponent>

    var onSizeChange: ((CGSize) -> Void)?
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 8) {
                Image(systemName: "waveform.path.ecg")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.secondary)
                    .frame(width: 26, height: 26)
                    .background(Color.primary.opacity(0.08))
                    .clipShape(Circle())
                VStack(alignment: .leading, spacing: 1) {
                    Text("Vela")
                        .font(.system(size: 13, weight: .semibold))
                    Text("SYSTEM MONITOR")
                        .font(.system(size: 9, weight: .medium))
                        .foregroundColor(.secondary)
                }
                Spacer()
                Text("v\(preferenceStore.version ?? "?")")
                    .secondaryDisplayText()
                Button(action: AppDelegate.openPreferences) {
                    Image(systemName: "gearshape")
                }
                .buttonStyle(PlainButtonStyle())
                .help("Preferences")
                Button(action: AppDelegate.quit) {
                    Image(systemName: "power")
                }
                .buttonStyle(PlainButtonStyle())
                .help("Quit Vela")
            }
            Divider()
            ForEach(menuComponentsStore.activeComponents) {
                $0.getView()
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 15)
        .frame(minWidth: uiStore.menuWidth)
        .fixedSize()
        .background(Color.controlBackground.opacity(0.55))
        .animation(.none)
        .background(GeometryReader { self.reportSize($0) })
        .onPreferenceChange(SizePreferenceKey.self, perform: { value in
            if let size = value.first {
                onSizeChange?(size)
            }
        })
        .preferredColorScheme()
    }
}
