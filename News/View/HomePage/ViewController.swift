//
//  ViewController.swift
//  News
//
//  Created by Akhil on 27/06/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var mTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension ViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsVC = mTableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! newsCell
        return newsVC
    }
}

