import UIKit

class MainViewController: UISplitViewController, UITableViewDelegate, UITableViewDataSource {
    
    let dataSource = CosmeticsDataSource.getUniqueInstance()
    var navListViewController: UINavigationController?
    var listViewController: CosmeticsViewController?
    var detailViewController: CosmeticsItemViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navListViewController = self.viewControllers[0] as? UINavigationController
        listViewController = navListViewController!.viewControllers.first as? CosmeticsViewController
        listViewController!.delegate = self;
        self.preferredDisplayMode = UISplitViewControllerDisplayMode.PrimaryOverlay
        initViews()
    }
    
    private func initViews() {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.getAllData().count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CosmeticsViewController.cosmeticsTableIdentifier, forIndexPath: indexPath)
        cell.textLabel?.text = self.dataSource.getAllData()[indexPath.row].name
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if self.collapsed {
            detailViewController = CosmeticsItemViewController()
            navListViewController!.pushViewController(detailViewController!, animated: true)
        } else {
            detailViewController = self.viewControllers[1] as? CosmeticsItemViewController
        }
        detailViewController!.lblName.text = dataSource.getAllData()[indexPath.row].name
    }


}

