import UIKit

struct Meeting {
    let name: String
    let date: String
}

class MeetingsTableViewController: UITableViewController {
    
    fileprivate let CellIdentifier = "relationshipCell"
    let searchController = UISearchController(searchResultsController: nil)
    var filteredMeetings = [Meeting]()
    var collapseDetailViewController: Bool  = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.blue]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        self.title = "Meetings"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 00/255.0, green: 24/255.0, blue: 168/255.0, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = false
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.barTintColor = UIColor(red: 00/255.0, green: 24/255.0, blue: 168/255.0, alpha: 1)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collapseDetailViewController = false
        //performSegue(withIdentifier: "show_detail_segue_id_1", sender: self)
        performSegue(withIdentifier: "show_detail_segue_id_1", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show_detail_segue_id_1" {
            let vc = segue.destination as!  UINavigationController
            let targetController = vc.topViewController as! MeetingsDetailViewController
            if let selectedRowIndexPath = tableView.indexPathForSelectedRow {
                targetController.name = meetingsRepo[selectedRowIndexPath.row]["name"] as! String
            } else{
                targetController.name = meetingsRepo[0]["name"] as! String
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredMeetings.count
        }else{
            return meetingsRepo.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as UITableViewCell
        if searchController.isActive && searchController.searchBar.text != "" {
            cell.textLabel?.text = filteredMeetings[indexPath.row].name
            cell.detailTextLabel?.text = filteredMeetings[indexPath.row].date
        } else {
            cell.textLabel?.text = meetingsRepo[indexPath.row]["name"] as! String?
            cell.detailTextLabel?.text = meetingsRepo[indexPath.row]["date"] as! String?
        }
        
        return cell
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //collapseDetailViewController = false
        performSegue(withIdentifier: "show_detail_segue_id_1", sender: self)
    }
    
}

extension MeetingsTableViewController:UISearchBarDelegate,UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
//         self.filteredCompany = relationshipRepo.filter({
//         nil != $0.name.range(of:searchController.searchBar.text!)
//         })
        tableView.reloadData()
    }
    
}
