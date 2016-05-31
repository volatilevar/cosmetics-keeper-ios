import Foundation
import UIKit

class CosmeticsItemViewController: UIViewController {
    var lblName:UILabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    private func initViews() {
        let stackView = UIStackView()
        self.view = stackView
        stackView.addArrangedSubview(lblName)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}