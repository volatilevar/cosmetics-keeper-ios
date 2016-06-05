import Foundation
import UIKit

class CosmeticsDetailViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var ready = false
    let dataSource = CosmeticsDataSource.getUniqueInstance()
    var listTVC: CosmeticsListViewController?
    var index: Int?
    static let CellId = "CosmeticsDetailTableCellId"
    var itemStatePickerView = UIPickerView()
    var itemDOMPicker = UIDatePicker()
    var itemRemindByPicker = UIDatePicker()
    var itemNotes = UITextView()
    
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
        itemStatePickerView.delegate = self
        itemStatePickerView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
        case 0:
            return "Basic Information"
        case 1:
            return "Reminder"
        case 2:
            return "Notes"
        default:
            return "INVALID"
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            return 4
        case 1:
            return 1
        case 2:
            return 1
        default:
            return -1
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CosmeticsDetailCell = tableView.dequeueReusableCellWithIdentifier(CosmeticsDetailViewController.CellId, forIndexPath: indexPath) as!CosmeticsDetailCell
        cell.tableVC = self
        
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
                let btnitemDone = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: cell, action: #selector(cell.itemStatePickerDone))
                let btnitemCancel = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: cell, action: #selector(cell.itemStatePickerCancel))
                let btnitemSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: cell, action: nil)
                let tb = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 32))
                tb.items = [btnitemDone, btnitemSpace, btnitemCancel]
                cell.overrideInputAccessoryView(tb)
                cell.overrideInputView(itemStatePickerView)
            case 3:
                cell.textLabel!.text = "Date of Manufacture"
                let df = NSDateFormatter()
                df.dateFormat = "yyyy-MM-dd"
                cell.detailTextLabel!.text = df.stringFromDate(dataSource.getItem(index!).dom!);
                let btnitemDone = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: cell, action: #selector(cell.itemDOMPickerDone))
                let btnitemCancel = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: cell, action: #selector(cell.itemDOMPickerCancel))
                let btnitemSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: cell, action: nil)
                let tb = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 32))
                tb.items = [btnitemDone, btnitemSpace, btnitemCancel]
                cell.overrideInputAccessoryView(tb)
                cell.overrideInputView(itemDOMPicker)
            default:
                break
            }
        case 1:
            switch (indexPath.row) {
            case 0:
                cell.textLabel!.text = "Date"
                let df = NSDateFormatter()
                df.dateFormat = "yyyy-MM-dd"
                cell.detailTextLabel!.text = df.stringFromDate(dataSource.getItem(index!).remindBy!);
                let btnitemDone = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: cell, action: #selector(cell.itemRemindByPickerDone))
                let btnitemCancel = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: cell, action: #selector(cell.itemRemindByPickerCancel))
                let btnitemSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: cell, action: nil)
                let tb = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 32))
                tb.items = [btnitemDone, btnitemSpace, btnitemCancel]
                cell.overrideInputAccessoryView(tb)
                cell.overrideInputView(itemRemindByPicker)
            default:
                break
            }
        case 2:
            switch (indexPath.row) {
            case 0:
                itemNotes.frame = CGRect(x: 0, y: 0, width: cell.contentView.frame.width, height: 200)
                itemNotes.font = UIFont.systemFontOfSize(15)
                cell.contentView.addSubview(itemNotes)
                let btnitemDone = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: cell, action: #selector(cell.itemNotesDone))
                let tb = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 32))
                tb.items = [btnitemDone]
                cell.overrideInputAccessoryView(tb)
                cell.accessoryView = UIView()
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
        
        let item = self.dataSource.getItem(self.index!)
        
        switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
            case 0:
                let alert = UIAlertController(title: "Name", message: "Please input the name of the item", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
                    (aa: UIAlertAction!) in
                    let newName = alert.textFields![0].text!
                    item.name = newName
                    self.tableView.reloadData()
                    self.listTVC!.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: self.index!, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
                    self.navigationItem.title = newName;
                }))
                alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
                    textField.text = item.name == "" ? "e.g. Estee Launder ANR" : item.name
                })
                self.presentViewController(alert, animated: true, completion: nil)
            case 1:
                let alert = UIAlertController(title: "Quantity", message: "Please input the quantity of the item", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
                    (aa: UIAlertAction!) in
                    item.quantity = Int(alert.textFields![0].text!)!
                    self.tableView.reloadData()
                }))
                alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
                    
                    textField.text = String(item.quantity)
                    textField.keyboardType = UIKeyboardType.NumberPad
                })
                self.presentViewController(alert, animated: true, completion: nil)
            case 2:
                itemStatePickerView.selectRow(item.state.rawValue, inComponent: 0, animated: true)
                cell.becomeFirstResponder()
            case 3:
                itemDOMPicker.setDate(item.dom!, animated: true)
                cell.becomeFirstResponder()
            default:
                break
            }
        case 1:
            switch(indexPath.row) {
            case 0:
                itemRemindByPicker.setDate(item.remindBy!, animated: true)
                cell.becomeFirstResponder()
            default:
                break
            }
        case 2:
            break;
        default:
            break
        }
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return 200
        }

        return 44
    }
    
    // MARK: - Item state picker view
    
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