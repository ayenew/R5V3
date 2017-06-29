import UIKit
import SSCalendar

class CalendarVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
//        view.backgroundColor = UIColor.red
//        SSStyles.applyNavigationBarStyles()
//        
//        let annualViewController = SSCalendarAnnualViewController(events: generateEvents())
//        let navigationController = UINavigationController(rootViewController: annualViewController!)
//        navigationController.navigationBar.isTranslucent = false
//        self.present(navigationController, animated: true, completion: nil)
        SSStyles.applyNavigationBarStyles()
        let annualViewController = SSCalendarMonthlyViewController(events: generateEvents())
        annualViewController?.view.alpha = 0.7
        let navigationController = UINavigationController(rootViewController: annualViewController!)
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barTintColor = UIColor(red: 242255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
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
        //self.present(navigationController, animated: true, completion: nil)
    }
    
    fileprivate func generateEvents() -> [SSEvent] {
        var events: [SSEvent] = []
        for year in 2016...2021 {
            for _ in 1...200 {
                events.append(generateEvent(year));
            }
        }
        return events
    }
    
    fileprivate func generateEvent(_ year: Int) -> SSEvent {
        let month = Int(arc4random_uniform(12)) + 1
        let day = Int(arc4random_uniform(28)) + 1
        
        let event = SSEvent()
        event.startDate = SSCalendarUtils.date(withYear: year, month: month, day: day)
        event.startTime = "09:00"
        event.name = "Example Event"
        event.desc = "Details of the event"
        
        return event
    }
    
}
