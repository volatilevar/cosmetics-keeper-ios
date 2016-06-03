import UIKit

class CosmeticsDetailCell: UITableViewCell {
    
    private var newInputView: UIView?
    private var newInputAccessoryView: UIView?

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
}
