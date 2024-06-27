//
//  NetworkMonitorManager.swift
//  FilmRoad
//
//  Created by 조유진 on 6/26/24.
//

import SwiftUI
import Network

final class NetworkMonitorManager: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    @Published private var isConnected: Bool = false
    
    func checkConnection() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self else { return }
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
