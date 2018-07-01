//
// File         : IFAddress.swift
// Module       : NetConnect
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-06-30
//

import Foundation

#if os(Linux)
    import Glibc
#else
    import Darwin
#endif

/// Static class with methods for retrieving IP addresses.
public class IFAddress {

    #if os(Linux)
    public static let defaultIFName = "ens160"
    #else
    public static let defaultIFName = "en0"
    #endif
    
    /// Returns the local IPv4 address of this machine as a string.
    ///
    /// Returns `nil` if no ip addresses were found for a given ifname or
    /// something went wrong when calling the underlying C functions.
    ///
    /// - parameters:
    ///     - ifname: The name of the network interface to get the ip address
    ///         for. On mac this defaults to 'en0' where as on ubuntu, the
    ///         default ifname may be something like `ens160` or `eth0`.
    ///
    /// From: https://stackoverflow.com/questions/30748480/swift-get-devices-ip-address
    public static func localIP(ifname: String = defaultIFName) -> String? {
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else {
            return nil
        }
        guard let firstAddr = ifaddr else {
            return nil
        }
        var addresses = [String]()
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) {
                let name = String(cString: interface.ifa_name)
                if name == ifname {
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    #if os(Linux)
                    let socklen = 64
                    #else
                    let socklen = interface.ifa_addr.pointee.sa_len
                    #endif
                    getnameinfo(
                        interface.ifa_addr,
                        socklen_t(socklen),
                        &hostname,
                        socklen_t(hostname.count),
                        nil,
                        socklen_t(0),
                        NI_NUMERICHOST
                    )
                    addresses.append(String(cString: hostname))
                }
            }
        }
        return addresses.first
    }

}
