//
//  PSPacketHistoryTableViewController.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/29/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit

class PSPacketHistoryTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		let documentNib = UINib(nibName: "PSPacketTableViewCell", bundle:nil)
		self.tableView?.register(documentNib, forCellReuseIdentifier: "tmp")
		tableView.separatorStyle = .none
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PSUserManager.sharedInstance.completedPackets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "tmp", for: indexPath)

        // Configure the cell...

        return UITableViewCell()
    }
}
