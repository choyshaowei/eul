//
//  ContentView.swift
//  eul
//
//  Created by Gao Sun on 2020/6/21.
//  Copyright © 2020 Gao Sun. All rights reserved.
//

import SharedLibrary
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var preferenceStore: PreferenceStore
    @EnvironmentObject var componentsStore: ComponentsStore<EulComponent>
    @EnvironmentObject var uiStore: UIStore

    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 9) {
                    Image(systemName: "waveform.path.ecg")
                        .foregroundColor(.secondary)
                    VStack(alignment: .leading, spacing: 1) {
                        Text("Vela")
                            .font(.system(size: 16, weight: .semibold))
                        Text("System Monitor")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 14)
                Divider()
                ForEach(Preference.Section.allCases) {
                    Preference.PreferenceSectionView(activeSection: $uiStore.activeSection, section: $0)
                }
                Spacer()
                Text("Vela")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 12)
            }
            .padding(.vertical, 18)
            .padding(.horizontal, 8)
            .frame(width: 180)
            .background(Color.controlBackground)
            Divider()
            ScrollView([.vertical], showsIndicators: !Info.isBigSur) {
                VStack(alignment: .leading, spacing: 12) {
                    if uiStore.activeSection == .general {
                        SectionView(title: "ui.app".localized()) {
                            Preference.GeneralView()
                        }
                        SectionView(title: "ui.display".localized()) {
                            Preference.DisplayView()
                        }
                        SectionView(title: "ui.refresh_rate".localized()) {
                            Preference.RefreshRateView()
                        }
                    }
                    if uiStore.activeSection == .components {
                        SectionView(title: "ui.display".localized()) {
                            Preference
                                .ComponentsView()
                                .padding(.top, 8)
                        }
                        if componentsStore.showComponents {
                            ForEach(EulComponent.allCases) {
                                Preference.ComponentConfigView(component: $0)
                            }
                        }
                    }
                    if uiStore.activeSection == .menuView {
                        SectionView(title: "ui.display".localized()) {
                            Preference.PreferenceMenuViewView()
                        }
                    }
                    Spacer()
                }
                .padding(.vertical, 24)
                .padding(.horizontal, 28)
            }
            .clipped()
        }
        .frame(minWidth: 720, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity)
        .id(preferenceStore.language)
        .preferredColorScheme()
    }
}
