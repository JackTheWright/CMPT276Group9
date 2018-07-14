//
// File         : NodeDelegate.swift
// Module       : TrackITServer
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-07-07
//

import Foundation
import NetConnect
import Threading

protocol NodeDelegate {

    init()

    var socket: UDPSocket! { get set }

    var active: Atomic<Bool>! { get set }

    var messageQueue: ThreadedQueue<NodePacket>! { get set }

    func start()

    func didEnd()

}
