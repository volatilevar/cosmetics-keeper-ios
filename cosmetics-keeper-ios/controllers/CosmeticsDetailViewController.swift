import Foundation
import UIKit

class CosmeticsDetailViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var ready = false
    let dataSource = CosmeticsDataSource.getUniqueInstance()
    var index: Int?
    var stackView: UIStackView?
    static let CellId = "CosmeticsDetailTableCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    func updateContent(index: Int) {
        self.ready = true
        self.index = index
        self.tableView.reloadData()
        self.navigationItem.title = dataSource.getItem(index).name;
    }
    
    private func initViews() {
        tableView.registerClass(CosmeticsDetailCell.self, forCellReuseIdentifier: CosmeticsDetailViewController.CellId)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
        case 0:
            return "Item Information"
        default:
            return "INVALID"
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            return 3
        default:
            return -1
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CosmeticsDetailCell = tableView.dequeueReusableCellWithIdentifier(CosmeticsDetailViewController.CellId, forIndexPath: indexPath) as!CosmeticsDetailCell
        
        switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
            case 0:
                cell.textLabel!.text = "Name"
                cell.detailTextLabel!.text = dataSource.getItem(index!).name;
            case 1:
                cell.textLabel!.text = "Quantity"
                cell.detailTextLabel!.text = String(dataSource.getItem(index!).quantity);
            case 2:
                cell.textLabel!.text = "State"
                cell.detailTextLabel!.text = dataSource.getItem(index!).state.description;
                let picker = UIPickerView()
                picker.delegate = self
                picker.dataSource = self
                cell.overrideInputView(picker)
                let btnitemDone = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: cell, action: #selector(resignFirstResponder))
                let tb = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 32))
                tb.items = [btnitemDone]
                cell.overrideInputAccessoryView(tb)
            default:
                break
            }
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell:CosmeticsDetailCell = tableView.cellForRowAtIndexPath(indexPath) as! CosmeticsDetailCell
        cell.resignFirstResponder()
        
        switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
            case 0:
                let alert = UIAlertController(title: "Name", message: "Please input the name of the item", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
                    (aa: UIAlertAction!) in
                    let newName = alert.textFields![0].text!
                    self.dataSource.getItem(self.index!).name = newName
                    self.tableView.reloadData()
                    self.navigationItem.title = newName;
                }))
                alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
                    let item = self.dataSource.getItem(self.index!)
                    textField.text = item.name == "" ? "e.g. Estee Launder ANR" : item.name
                })
                self.presentViewController(alert, animated: true, completion: nil)
            case 1:
                let alert = UIAlertController(title: "Quantity", message: "Please input the quantity of the item", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
                    (aa: UIAlertAction!) in
                    self.dataSource.getItem(self.index!).quantity = Int(alert.textFields![0].text!)!
                    self.tableView.reloadData()
                }))
                alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
                    let item = self.dataSource.getItem(self.index!)
                    textField.text = String(item.quantity)
                    textField.keyboardType = UIKeyboardType.NumberPad
                })
                self.presentViewController(alert, animated: true, completion: nil)
            case 2:
                cell.becomeFirstResponder()
            default:
                break
            }
        default:
            break
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CosmeticsState.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CosmeticsState(rawValue: row)?.description;
    }


}