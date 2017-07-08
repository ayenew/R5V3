import UIKit
import SSCalendar

class CalendarVC: UIViewController {
    var annualViewController: SSCalendarMonthlyViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        SSStyles.applyNavigationBarStyles()
        
        let annualViewController = SSCalendarMonthlyViewController(events: generateEvents())
        annualViewController?.view.alpha = 0.7
        let date = Date()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
         annualViewController?.startingIndexPath = NSIndexPath(item: 0, section: month-1) as IndexPath!
        let navigationController = UINavigationController(rootViewController: annualViewController!)
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barTintColor = UIColor(red: 101/255.0, green: 143/255.0, blue: 25/255.0, alpha: 1)
        navigationController.navigationBar.tintColor = UIColor.white
        self.addChildViewController(navigationController)
        self.view.addSubview(navigationController.view)
        navigationController.view.frame = self.view.frame
    }
    
    @IBAction func showCalendar(_ sender: UIButton) {
        SSStyles.applyNavigationBarStyles()
        
        let annualViewController = SSCalendarMonthlyViewController(events: generateEvents())
        let navigationController = UINavigationController(rootViewController: annualViewController!)
        navigationController.navigationBar.isTranslucent = false
        
        self.addChildViewController(navigationController)
        self.view.addSubview(navigationController.view)
        navigationController.view.frame = self.view.frame
    }
    
    fileprivate func generateEvents() -> [SSEvent] {
        var events: [SSEvent] = []
        for year in 2016...2017 {
            for _ in 1...3 {
                events.append(generateEvent(year));
            }
        }
        return events
    }
    
    fileprivate func generateEvent(_ year: Int) -> SSEvent {
        //let month = Int(arc4random_uniform(12)) + 1
        //let day = Int(arc4random_uniform(28)) + 1
        let year = 2017
        let month = 07
        let day = 11
        let event = SSEvent()
        event.startDate = SSCalendarUtils.date(withYear: year, month: month, day: day)
        event.startTime = "09:00"
        event.name = "Meet CFO of X Company at his Office"
        event.desc = "To give introduction"
        
        return event
    }
    
}
