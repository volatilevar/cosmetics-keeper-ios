import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.backgroundColor = UIColor.whiteColor()
        
        let sVC = UISplitViewController()
        self.window!.rootViewController = sVC
        let clVC = CosmeticsListViewController();
        let clNC = UINavigationController(rootViewController: clVC)
        let cdVC = CosmeticsDetailViewController();
        let cdNC = UINavigationController(rootViewController: cdVC)
        sVC.viewControllers = [clNC,cdNC]
        sVC.delegate = clVC;
        
        self.window!.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }


}

