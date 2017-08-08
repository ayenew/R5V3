import UIKit
import SSCalendar

class CalendarVC: UIViewController {
    var annualViewController: SSCalendarMonthlyViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor.lightGray
        self.view.backgroundColor = UIColor.white
       // SSStyles.applyNavigationBarStyles()
        
        let annualViewController = SSCalendarMonthlyViewController(events: generateEvents())
        annualViewController?.view.alpha = 0.7
        let date = Date()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
         annualViewController?.startingIndexPath = NSIndexPath(item: 0, section: month-1) as IndexPath!
        let navigationController = UINavigationController(rootViewController: annualViewController!)
        navigationController.navigationBar.isTranslucent = false
       navigationController.navigationBar.barTintColor = UIColor.groupTableViewBackground
        navigationController.navigationBar.tintColor = UIColor.black
        navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black]
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
        var year = 2017; var month = 08; var day = 03
        var event = SSEvent()
        event.startDate = SSCalendarUtils.date(withYear: year, month: month, day: day)
        event.startTime = "09:00"
        event.name = "Meet CFO of ABC Consulting at his Office"
        event.desc = "First Round Metting"
        events.append(event)
   
        event = SSEvent()
        event.startDate = SSCalendarUtils.date(withYear: year, month: month, day: day)
        event.startTime = "11:00"
        event.name = "Meet CEO of DEF Logistics"
        event.desc = "Discuss Business Opportunities"
        events.append(event)
        
        year = 2017; month = 8; day = 05
        event = SSEvent()
        event.startDate = SSCalendarUtils.date(withYear: year, month: month, day: day)
        event.startTime = "09:00"
        event.name = "Meeting CFO of ABC Consulting at his Office"
        event.desc = "Follow up Round Meeting"
        events.append(event)
        return events
    }
    
}
