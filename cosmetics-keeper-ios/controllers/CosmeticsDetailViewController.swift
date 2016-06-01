import Foundation
import UIKit

class CosmeticsDetailViewController: UIViewController {

    var lblName:UILabel?
    var ready = false

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    private func initViews() {
        lblName = UILabel()
        let stackView = UIStackView()
        self.view = stackView
        stackView.addArrangedSubview(lblName!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}