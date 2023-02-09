//
//  File.swift
//  
//
//  Created by Kanstantsin Bucha on 03/02/2023.
//


import Foundation
import Socket

struct Message: Codable {
    let type: String
    let data: MessageData
}

struct MessageData: Codable {
    let text: String
    let data: Data
}

struct TestClient {
    private let delimeter = "\r".data(using: .utf8)!
    private let dataSizeKB = 0.1

    func run() throws {
        let socket = try Socket.create(family: .unix)
        try socket.connect(
            to: "/tmp/swift-bindings.socket"
        )
        if !socket.isConnected {
            preconditionFailure("Failed to connect to the server...")
        }
        print("\tSocket signature: \(String(describing: socket.signature?.description))\n")
        
        try sendMessage(socket: socket)
        try readMessage(socket: socket)
        
        socket.close()
        Thread.sleep(forTimeInterval: 1)
    }
    
    private func sendMessage(socket: Socket) throws {
        let message = Message(
            type: "message",
            data: MessageData(
                text: "Hello from client...",
                data: Data(repeating: 7, count: Int(dataSizeKB * 1024))
            )
        )
        guard let data = try? JSONEncoder().encode(message) else {
            preconditionFailure("Failed to encode the message")
        }
        try socket.write(from: data + delimeter)
        print("Wrote the messave into socket")
    }
    
    private func readMessage(socket: Socket) throws {
        guard let receivedData = read(socket: socket) else {
            preconditionFailure("Failed to receive data from the server")
        }
        print("Read '\(String(describing: String(data: receivedData, encoding: .utf8)))' from socket...")
        guard let receivedMessage = try? JSONDecoder().decode(Message.self, from: receivedData) else {
            preconditionFailure("Failed to parse a message from data from the server")
        }
        print("Received '\(receivedMessage))' from socket...")
        print("Received data \(receivedMessage.data.data.hexEncodedString())' from socket...")
    }
    
    private func read(socket: Socket) -> Data? {
        var data = Data()
        do {
            print("Reading from socket")
            let bytesRead = try socket.read(into: &data)
            print("Read \(bytesRead) bytes from socket...")
            if bytesRead > 0 {
                return data
            }
            return nil
        } catch {
            print("Read socket error: \(error)")
            return nil
        }
    }
}

try? TestClient().run()
