//
//  NetworkConnectionCheck.swift
//  TimeCapsule
//
//  Created by 이승준 on 12/16/24.
//

import Network

struct NetworkConnectionCheck {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    func startCheckingNetwork(){
        monitor.start(queue: queue)
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied{ //네트워크 상태가 정상일 경우
                print("Online")
            }else { //네트워크 상태가 비정상일 경우
                print("Offline")
            }
        }
    }
    
    func stopCheckingNetwork(){
        monitor.cancel()
    }
}
