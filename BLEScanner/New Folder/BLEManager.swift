//
//  BLEManager.swift
//  BLEScanner
//
//  Created by SAfonja on 2/19/26.
//

import Combine
import CoreBluetooth
import Foundation

// MARK: - BLEManager
final class BLEManager: NSObject, ObservableObject {
    
    @Published var isOn: Bool = false
    @Published var peripherals: [CBPeripheral] = []
    
    private lazy var centralManager: CBCentralManager = { [unowned self] () -> CBCentralManager in
        CBCentralManager(delegate: self, queue: nil)
    }()
    
    override init() {
        super.init()
        
    }
    
    func startScanning() {
        peripherals.removeAll()
        centralManager.scanForPeripherals(withServices: nil)
    }
    
    func stopScanning() {
        centralManager.stopScan()
    }
}

// MARK: - CBCentralManagerDelegate
extension BLEManager: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        DispatchQueue.main.async {
            self.isOn = central.state == .poweredOn
        }
    }
    
    func centralManager(
        _ central: CBCentralManager,
        didDiscover peripheral: CBPeripheral,
        advertisementData: [String : Any],
        rssi RSSI: NSNumber
    ) {
        DispatchQueue.main.async {
            if !self.peripherals.contains(peripheral) {
                self.peripherals.append(peripheral)
            }
        }
    }
    
    
}

