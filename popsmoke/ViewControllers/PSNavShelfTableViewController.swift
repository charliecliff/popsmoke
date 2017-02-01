//
//  PSNavShelfTableViewController.swift
//  popsmoke
//
//  Created by Charles Cliff on 2/1/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit

fileprivate let cell_reuse_identifier	= "nav_shelf_cell"
fileprivate let header_nib_filename		= "PSProfileHeaderView"

class PSNavShelfTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_reuse_identifier, for: indexPath)
		cell.textLabel?.text = "Hello"
        return cell
    }

	// MARK: - UITableViewDelegate
	
	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
		return CGFloat(110)
	}
	
	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
		guard let headerView = Bundle.main.loadNibNamed(header_nib_filename, owner: self, options: nil)?.first as? UIView? else {
			return UIView()
		}
		return headerView
	}
}
