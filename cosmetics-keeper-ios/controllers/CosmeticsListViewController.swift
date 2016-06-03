import Foundation
import UIKit

class CosmeticsListViewController: UITableViewController, UISplitViewControllerDelegate {
    
    let dataSource = CosmeticsDataSource.getUniqueInstance()
    static let CellId = "CosmeticsTableCellId"
    
    weak var clNC: UINavigationController?
    weak var cdNC: UINavigationController?
    weak var clVC: CosmeticsListViewController?
    weak var cdVC: CosmeticsDetailViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: CosmeticsListViewController.CellId)
        self.splitViewController!.delegate = self
        self.splitViewController!.view.backgroundColor = UIColor.whiteColor()
        clNC = self.splitViewController!.viewControllers[0] as? UINavigationController
        clVC = clNC!.viewControllers.first as? CosmeticsListViewController
        cdNC = self.splitViewController!.viewControllers[1] as? UINavigationController
        cdVC = cdNC!.viewControllers.first as? CosmeticsDetailViewController

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
        
        let btnitmAdd = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(addItem))
        let btnitmMenu = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: nil)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = btnitmAdd
        self.navigationItem.leftBarButtonItem = btnitmMenu
        self.navigationItem.title = "Cosmetics Keeper"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addItem() {
        let item = Item(name: "Untitled item")
        dataSource.addItem(item)
        self.tableView.reloadData()
        cdVC?.updateContent(dataSource.count - 1)
        self.splitViewController?.showDetailViewController(cdNC!, sender: self)
    }
    
    // MARK: - Table
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CosmeticsListViewController.CellId, forIndexPath: indexPath)
        cell.textLabel?.text = self.dataSource.getItem(indexPath.row).name
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        cdVC!.updateContent(indexPath.row)
        self.splitViewController?.showDetailViewController(cdNC!, sender: self)
    }

    // Make sure the master view will be shown when the detail view is not ready (e.g. upon app start)
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
        if cdVC!.isKindOfClass(CosmeticsDetailViewController) && (cdVC!.ready == false) {
            return true;
        } else {
            return false;
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            self.dataSource.deleteItem(indexPath.row)
            self.tableView.reloadData()
        }
    }


}