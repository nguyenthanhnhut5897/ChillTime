//
//  DataCenter.swift
//  ChillTime
//
//  Created by Nguyen Thanh Nhut on 2023/04/07.
//

import UIKit

class DataCenter {
    static var shared = DataCenter()
    // Check app status is opened or launching
    var hasLoadedApp: Bool = false
    // Equal true when app has requested push noti authorization
    var hasRequestedNotiPermission: Bool = false
    // Save data of push noti when app open after quit
    var userDataNoti: [AnyHashable : Any]?
    
    // Save the last error code when show pop up (top alert view of pop up)
    var lastErrorCodePopup: Int = -1
    
    
    lazy var appConfiguration = ChillTimeAPIConfig(type: .development)
    
    // MARK: - Network
    lazy var apiDataTransferService: DataTransferService = {
//        let config = ApiDataNetworkConfig(
//            baseURL: URL(string: appConfiguration.apiBaseURL)!,
//            queryParameters: [
//                "api_key": appConfiguration.apiKey,
//                "language": NSLocale.preferredLanguages.first ?? "en"
//            ]
//        )
//
//        let apiDataNetwork = DefaultNetworkService(config: config)
//        return DefaultDataTransferService(with: apiDataNetwork)
        return DefaultDataTransferService()
    }()
    
    lazy var paymentDataTransferService: Int = {
        return 0
    }()
    
    func numberOfTokens(expiryLimit: Int, commands: [[Int]]) -> Int {
        var commandDicts: [Int: Int] = [:]
        var maxTime: Int = 0
        var total: Int = 0
        
        for command in commands {
            let type = command[0]
            let token = command[1]
            let time = command[2]
            
            if type == 0 {
                commandDicts[token] = time + expiryLimit
            } else if let expiryTime = commandDicts[token], expiryTime >= time {
                commandDicts[token] = time + expiryLimit
            }
            
            if time > maxTime {
                maxTime = time
            }
        }

        for commandDict in commandDicts {
            if commandDict.value > maxTime {
                total += 1
            }
        }
        
        return total
    }

    
    func getVisibleProfilesCount(connection_nodes: Int, connection_from: [Int], connection_to: [Int], queries: [Int]) -> [Int] {
        var connectionList: [[Int]] = Array(repeating: [], count: connection_nodes + 1)

        for i in 0..<connection_from.count {
            let from = connection_from[i]
            let to = connection_to[i]
            connectionList[from].append(to)
            connectionList[to].append(from)
        }

        var result: [Int] = Array(repeating: 0, count: queries.count)
        var visited: [Bool] = Array(repeating: false, count: connection_nodes + 1)

        for i in 0..<queries.count {
            dfs(queries[i], &visited, &connectionList, &result, queries[i])
        }

        return result
        
        // Create adjacency list
            var connectionList: [Int: [Int]] = [:]
            for i in 0..<connection_from.count {
                let from = connection_from[i]
                let to = connection_to[i]
                
                if connectionList[from] == nil {
                    connectionList[from] = [to]
                } else {
                    connectionList[from]?.append(to)
                }
                
                if connectionList[to] == nil {
                    connectionList[to] = [from]
                } else {
                    connectionList[to]?.append(from)
                }
            }
            
            // Count visible profiles for each query
            var results: [Int] = []
        
            for query in queries {
                var visible: Set<Int> = []
                
                if let connecteds = connectionList[query] {
                    for connected in connecteds {
                        visible.insert(connected)
                        
                        if let friends = connectionList[connected] {
                            visible.formUnion(friends)
                        }
                    }
                }
                
                results.append(visible.count)
            }
            
            return results
    }
    
    func dfs(_ node: Int, _ visited: inout [Bool], _ connectionList: inout [[Int]], _ visible: inout [Int], _ source: Int) {
        if visited[node] { return }
        
        visited[node] = true
        visible[source - 1] += 1
        
        for i in connectionList[node] {
            dfs(i, &visited, &connectionList, &visible, source)
        }
    }
    
    
    func findNumberSequence(direction: String) -> [Int] {
        let n = direction.count
        var sequence = [Int](repeating: 0, count: n)
        var range = 0..<1 << n
        var i = 0
        
        while !range.isEmpty {
            let center = range.lowerBound + range.count / 2
            let left = range.lowerBound..<center
            let right = center..<range.upperBound
            
            if direction[direction.index(direction.startIndex, offsetBy: i)] == "L" {
                range = left
            } else {
                range = right
            }
            
            sequence[center - 1] = i + 1
            i += 1
        }
        
        return sequence
    }
    
    func validateRequests(blacklisted_ips: [String], requests: [String]) -> [Int] {
        var blocked = [Int]()
        var blacklist = Set<String>()
        var counts = [String: Int]()
        var times = [String: Int]()
        
        // Helper function to check if an IP address matches a blacklisted IP regex
        func matches(ip: String, regex: String) -> Bool {
            let pattern = regex.replacingOccurrences(of: "*", with: "[0-9]+")
            let regex = try? NSRegularExpression(pattern: pattern)
            let range = NSRange(location: 0, length: ip.count)
            return regex?.firstMatch(in: ip, options: [], range: range) != nil
        }
        
        for ip in blacklisted_ips {
            blacklist.insert(ip)
        }
        
        for (i, req) in requests.enumerated() {
            // Check if the request should be blocked due to a blacklisted IP regex
            var blockedByRegex = false
            for ip in blacklist {
                if matches(ip: req, regex: ip) {
                    blockedByRegex = true
                    break
                }
            }
            if blockedByRegex {
                blocked.append(1)
                continue
            }
            
            // Check if the request should be blocked due to too many requests in the last 5 seconds
            counts[req] = (counts[req] ?? 0) + 1
            times[req] = i
            var numRecentRequests = 0
            for (ip, time) in times {
                if i - time <= 5 && counts[ip]! >= 2 {
                    numRecentRequests += 1
                }
            }
            if numRecentRequests >= 2 {
                blocked.append(1)
                continue
            }
            
            blocked.append(0)
        }
        
        return blocked
    }
}
