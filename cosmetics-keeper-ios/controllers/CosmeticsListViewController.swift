import Foundation
import UIKit

class CosmeticsListViewController: UITableViewController, UISplitViewControllerDelegate {
    
    let dataSource = CosmeticsDataSource.getUniqueInstance()
    static let CellId = "CosmeticsTableCellId"
    
    weak var nc: UINavigationController?
    weak var clVC: CosmeticsListViewController?
    weak var cdVC: CosmeticsDetailViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: CosmeticsListViewController.CellId)
        self.splitViewController?.delegate = self
        nc = self.splitViewController!.viewControllers[0] as? UINavigationController
        cdVC = self.splitViewController!.viewControllers[1] as? CosmeticsDetailViewController
        clVC = nc!.viewControllers.first as? CosmeticsListViewController

        initViews()
    }
    
    private func initViews() {
        dispatch_async(dispatch_get_main_queue()) {
            switch (self.traitCollection.horizontalSizeClass) {
            case UIUserInterfaceSizeClass.Compact:
                self.splitViewController!.preferredDisplayMode = UISplitViewControllerDisplayMode.PrimaryOverlay
            case UIUserInterfaceSizeClass.Regular:
                self.splitViewController!.preferredDisplayMode = UISplitViewControllerDisplayMode.AllVisible
            default:
                break
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.getAllData().count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CosmeticsListViewController.CellId, forIndexPath: indexPath)
        cell.textLabel?.text = self.dataSource.getAllData()[indexPath.row].name
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        cdVC!.lblName!.text = dataSource.getAllData()[indexPath.row].name
        cdVC!.ready = true
        self.splitViewController?.showDetailViewController(cdVC!, sender: self)
    }

    // Make sure the master view will be shown when the detail view is not ready (e.g. upon app start)
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
        if secondaryViewController.isKindOfClass(CosmeticsDetailViewController) && (secondaryViewController as! CosmeticsDetailViewController).ready == false {
            return true;
        } else {
            return false;
        }
    }


}