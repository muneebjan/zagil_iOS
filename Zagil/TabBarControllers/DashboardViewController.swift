//

//

import UIKit
import CYLTabBarController

class DashboardViewController: UIViewController {
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        print("dashboard view will appear called")
        
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        self.hidesBottomBarWhenPushed = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // IBACTIONS
    
    @IBAction func shipmentButton(_ sender: Any) {
        print("shipment pressed")
    }
    @IBAction func tripButton(_ sender: Any) {
        print("trip pressed")
    }
    @IBAction func activityButton(_ sender: Any) {
        print("activity button pressed")
    }
    @IBAction func settingButton(_ sender: Any) {
        print("setting pressed")
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dsetting", bundle: nil)
        let settingVc = storyBoard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        settingVc.hidesBottomBarWhenPushed = true
        cyl_push(settingVc, animated: true)
    }

}
