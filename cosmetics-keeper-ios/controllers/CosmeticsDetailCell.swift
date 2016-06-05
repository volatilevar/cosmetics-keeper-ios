import UIKit

class CosmeticsDetailCell: UITableViewCell {
    
    private var newInputView: UIView?
    private var newInputAccessoryView: UIView?
    var tableVC: CosmeticsDetailViewController?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Value1, reuseIdentifier: reuseIdentifier)
        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func overrideInputView(inputView: UIView) {
        self.newInputView = inputView
    }

    override var inputView: UIView? {
        get {
            return self.newInputView
        }
    }
    
    func overrideInputAccessoryView(inputAccessoryView: UIView) {
        self.newInputAccessoryView = inputAccessoryView
    }
    
    override var inputAccessoryView: UIView? {
        get {
            return self.newInputAccessoryView
        }
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true;
    }
    
    func itemStatePickerDone() {
        resignFirstResponder()
        tableVC!.dataSource.getItem(tableVC!.index!).state = CosmeticsState(rawValue: tableVC!.itemStatePickerView.selectedRowInComponent(0))!
        tableVC!.tableView.reloadData()
    }
    
    func itemStatePickerCancel() {
        resignFirstResponder()
    }
    
    func itemDOMPickerDone() {
        resignFirstResponder()
        tableVC!.dataSource.getItem(tableVC!.index!).dom = tableVC!.itemDOMPicker.date
        tableVC!.tableView.reloadData()
    }
    
    func itemDOMPickerCancel() {
        resignFirstResponder()
    }


}
