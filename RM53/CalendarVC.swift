import UIKit
import SSCalendar

class CalendarVC: UIViewController {
    let backgroundColor = UIColor(red: 228/255.0, green: 242/255.0, blue: 244/255.0, alpha: 1)
    var annualViewController: SSCalendarMonthlyViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 106/255.0, green: 173/255.0, blue: 228/255.0, alpha: 1)
        //SSStyles.applyNavigationBarStyles()
        let annualViewController = SSCalendarMonthlyViewController(events: generateEvents())
        annualViewController?.view.backgroundColor = UIColor.clear
        let date = Date()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
         annualViewController?.startingIndexPath = NSIndexPath(item: 0, section: month-1) as IndexPath!
        annualViewController?.dataSource.view.backgroundColor = backgroundColor

        let navigationController = UINavigationController(rootViewController: annualViewController!)
        navigationController.navigationBar.isTranslucent = false
       navigationController.navigationBar.barTintColor = backgroundColor
        navigationController.navigationBar.tintColor = UIColor.black
        navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black]
        navigationController.view.backgroundColor = UIColor.clear
        self.addChildViewController(navigationController)
        self.view.addSubview(navigationController.view)
        navigationController.view.frame = self.view.frame
    }
    
    @IBAction func showCalendar(_ sender: UIButton) {        
        let annualViewController = SSCalendarMonthlyViewController(events: generateEvents())
        let navigationController = UINavigationController(rootViewController: annualViewController!)
        navigationController.navigationBar.isTranslucent = false
        
        self.addChildViewController(navigationController)
        self.view.addSubview(navigationController.view)
        navigationController.view.frame = self.view.frame
    }
    
    fileprivate func generateEvents() -> [SSEvent] {
        var events: [SSEvent] = []
        var year = 2017; var month = 09; var day = 08
        var event = SSEvent()
        event.startDate = SSCalendarUtils.date(withYear: year, month: month, day: day)
        event.startTime = "11:00"
        event.name = "Builders Plus Inc - Strategic with CFO"
        event.desc = "Talk with Justin and Mark - our ACH solution too expensive. Also do not think need ECL"
        events.append(event)
   
        event = SSEvent()
        event.startDate = SSCalendarUtils.date(withYear: year, month: month, day: day)
        event.startTime = "3:00"
        event.name = "09/09/2017 MPW Industrial Service"
        event.desc = "Meet with Dana to reciew account set ups. Need to change signers and close two accounts. The BCBS activity will grow quickly.Follow up in November to review to see if should change to analyzed account type. alos discussed CC for T & E and how can automate and streamline the process."
        events.append(event)
        
        year = 2017; month = 09; day = 12
        event = SSEvent()
        event.startDate = SSCalendarUtils.date(withYear: year, month: month, day: day)
        event.startTime = "03:00"
        event.name = "09/12/2017 Specialized Service"
        event.desc = "KALI R NANDI - Strategic"
        events.append(event)
        return events
    }
    
}
