//
//  ContentView.swift
//  BLEScanner
//
//  Created by SAfonja on 2/19/26.
//

import CoreBluetooth
import SwiftUI

struct ContentView: View {
    @StateObject private var bleManager = BLEManager()
    
    var body: some View {
        NavigationView {
            VStack {
                Text(bleManager.isOn ? "Bluetooth is ON" : "Bluetooth is OFF")
                    .font(.headline)
                    .padding()
                VStack(spacing: 20) {
                    Button("Start Scan") {
                        bleManager.startScanning()
                    }
                    
                    Button("Stop") {
                        bleManager.stopScanning()
                    }
                    .foregroundStyle(.red)
                }
                .padding()
                
                List(bleManager.peripherals, id: \.identifier) { device in
                    VStack(alignment: .leading) {
                        Text(device.name ?? "Unknown Device")
                            .font(.headline)
                        Text(device.identifier.uuidString)
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                }
                .navigationTitle("BLE Scanner")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
