//
//  SubmittedAssignmentViewController.swift
//  MusicMaker
//
//  Created by Linh Bouniol on 11/28/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

class SubmittedAssignmentViewController: UITableViewController {

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
}
