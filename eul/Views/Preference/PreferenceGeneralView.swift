//
//  PreferenceGeneralView.swift
//  eul
//
//  Created by Gao Sun on 2020/9/12.
//  Copyright © 2020 Gao Sun. All rights reserved.
//

import LaunchAtLogin
import SharedLibrary
import SwiftUI
import SwiftyJSON

extension Preference {
    struct GeneralView: View {
        @ObservedObject var launchAtLogin = LaunchAtLogin.observable
        @EnvironmentObject var preference: PreferenceStore

        var body: some View {
            VStack(alignment: .leading, spacing: 14) {
                HStack(spacing: 10) {
                    Image(systemName: "waveform.path.ecg")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.secondary)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Vela")
                            .font(.system(size: 15, weight: .semibold))
                        Text("System monitor for your Mac")
                            .secondaryDisplayText()
                    }
                    Spacer()
                    if let version = preference.version {
                        Text("v\(version)")
                            .secondaryDisplayText()
                            .fixedSize()
                    }
                }
                Divider()
                Toggle(isOn: $launchAtLogin.isEnabled) {
                    Text("ui.launch_at_login".localized())
                        .inlineSection()
                }
                Toggle(isOn: $preference.checkStatusItemVisibility) {
                    Text("ui.check_status_item_visibility".localized())
                        .inlineSection()
                }
            }
            .padding(.vertical, 10)
        }
    }
}
