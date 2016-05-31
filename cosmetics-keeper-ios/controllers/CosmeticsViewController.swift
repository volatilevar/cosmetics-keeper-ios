import Foundation
import UIKit

class CosmeticsViewController: UITableViewController {
    
    static let cosmeticsTableIdentifier = "CosmeticsTableItem"
    weak var delegate: MainViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    private func initViews() {
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: CosmeticsViewController.cosmeticsTableIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (delegate?.numberOfSectionsInTableView(tableView))!
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (delegate?.tableView(tableView, numberOfRowsInSection: section))!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return (delegate?.tableView(tableView, cellForRowAtIndexPath: indexPath))!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        return (delegate?.tableView(tableView, didSelectRowAtIndexPath: indexPath))!
    }

}