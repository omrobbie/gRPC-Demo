//
//  ViewController.swift
//  gRPC Demo
//
//  Created by omrobbie on 23/04/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        setupTableView()

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

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            UINib(nibName: "CustomCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "CustomCollectionViewCell"
        )
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            UINib(nibName: "CustomTableViewCell", bundle: nil),
            forCellReuseIdentifier: "CustomTableViewCell"
        )
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CustomCollectionViewCell",
            for: indexPath
        ) as! CustomCollectionViewCell
        cell.backgroundColor = indexPath.row % 2 == 0 ? .systemGray5 : .systemGray6
        cell.nameLabel.text = "Name \(indexPath.row)"
        cell.priceLabel.text = "Price \(indexPath.row)"
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 2, height: 112)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "CustomTableViewCell",
            for: indexPath
        ) as! CustomTableViewCell
        cell.backgroundColor = indexPath.row % 2 == 0 ? .systemGray5 : .systemGray6
        cell.nameLabel.text = "Name \(indexPath.row)"
        cell.priceLabel.text = "Price \(indexPath.row)"
        return cell
    }
}
