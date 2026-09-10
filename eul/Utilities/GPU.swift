//
//  GPU.swift
//  eul
//
//  Created by Gao Sun on 2021/1/23.
//  Copyright © 2021 Gao Sun. All rights reserved.
//

import Foundation

struct GPU: Identifiable {
    var deviceId: String
    var model: String?
    var vendor: String?

    var id: String {
        deviceId
    }
}

extension GPU {
    struct Statistic {
        var pciMatch: String
        var usagePercentage: Int
        var temperature: Double?
        var coreClock: Int?
        var memoryClock: Int?
    }
}

extension GPU {
    static func getGPUs() -> [GPU]? {
        if let data = shellData(["system_profiler SPDisplaysDataType -xml"]),
           let plistArray = try? PropertyListDecoder().decode(SystemProfilerPlistArray.self, from: data)
        {
            let gpus: [GPU] = plistArray.first?.items.compactMap {
                guard $0.isGPU, let deviceId = $0.deviceId else {
                    return nil
                }
                return GPU(deviceId: deviceId, model: $0.model, vendor: $0.vendor)
            } ?? []

            if !gpus.isEmpty {
                return gpus
            }
        }

        return IOHelper.getPropertyList(for: kIOAcceleratorClassName)?.compactMap {
            guard let model = $0["model"] as? String else {
                return nil
            }
            return GPU(deviceId: model, model: model, vendor: nil)
        }
    }

    // https://stackoverflow.com/questions/10110658/programmatically-get-gpu-percent-usage-in-os-x/22440235#22440235
    // https://github.com/exelban/stats/blob/master/Modules/GPU/reader.swift
    static func getInfo() -> [Statistic]? {
        guard let propertyList = IOHelper.getPropertyList(for: kIOAcceleratorClassName) else {
            return nil
        }

        return propertyList.compactMap {
            guard
                let statistics = $0["PerformanceStatistics"] as? [String: Any],
                let usagePercentage = statistics["Device Utilization %"] as? Int ?? statistics["GPU Activity(%)"] as? Int
            else {
                return nil
            }

            let pciMatch = $0["IOPCIMatch"] as? String ?? $0["IOPCIPrimaryMatch"] as? String ?? ""

            Print("📊 statistics", statistics)

            return Statistic(
                pciMatch: pciMatch,
                usagePercentage: usagePercentage,
                temperature: statistics["Temperature(C)"] as? Double ?? SmcControl.shared.gpuProximityTemperature,
                coreClock: statistics["Core Clock(MHz)"] as? Int,
                memoryClock: statistics["Memory Clock(MHz)"] as? Int
            )
        }
    }
}
