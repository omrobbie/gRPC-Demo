//
//  GrpcManager.swift
//  gRPC Demo
//
//  Created by omrobbie on 09/05/24.
//

import Foundation
import GRPC
import NIO

class GrpcManager {
    // Singleton. GRPC Manager must use the shared instance
    static let shared = GrpcManager()

    struct Config {
        let host: String
        let port: Int
    }

    private static var config: Config?

    // GRPC Manager must setup with host and port before using
    class func setup(config: Config) {
        GrpcManager.config = config
    }

    private let client: Streaming_PriceFeedClientProtocol!

    private init() {
        guard let config = GrpcManager.config else {
            fatalError("You must call setup before using the GRPC Manager")
        }

        let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)

        do {
            let channel = try GRPCChannelPool.with(
                configuration: .with(
                    target: .host(
                        config.host,
                        port: config.port
                    ),
                    transportSecurity: .plaintext,
                    eventLoopGroup: eventLoopGroup
                )
            )

            client = Streaming_PriceFeedNIOClient(channel: channel)
        } catch {
            client = nil
            print("Couldn't connect to gRPC server")
        }
    }
}

extension GrpcManager {
    func getPriceFeed(completion: @escaping ([Streaming_Saham]) -> Void) {
        guard let client = client else { return }

        _ = client.getPriceFeed(.init()) { response in
            completion(response.price)
        }
    }
}
