//
//  ViewController.swift
//  gRPC Demo
//
//  Created by omrobbie on 23/04/24.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        GrpcManager.setup(config: GrpcManager.Config(
            host: "172.18.139.190",
            port: 8443
        ))
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        GrpcManager.shared.getPriceFeed { price in
            print(price)
        }
    }
}
