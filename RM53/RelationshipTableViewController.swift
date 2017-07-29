import UIKit

struct Company {
    let name: String
    let address: String
}

class RelationshipTableViewController: UITableViewController {
    
    fileprivate let CellIdentifier = "relationshipCell"
    let searchController = UISearchController(searchResultsController: nil)
    var filteredCompany = [Company]()
    var collapseDetailViewController: Bool  = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.blue]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        self.title = "Companies"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 33/255.0, green: 61/255.0, blue: 159/255.0, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = false
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.barTintColor = UIColor(red: 33/255.0, green: 61/255.0, blue: 159/255.0, alpha: 1)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collapseDetailViewController = false
        performSegue(withIdentifier: "show_detail_segue_id_1", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show_detail_segue_id" {
            let vc = segue.destination as!  UINavigationController
            let targetController = vc.topViewController as! RelationshipDetailViewController
            if let selectedRowIndexPath = tableView.indexPathForSelectedRow {
                targetController.name = relationshipRepo[selectedRowIndexPath.row]["name"] as! String
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredCompany.count
        }else{
            return relationshipRepo.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as UITableViewCell
        if searchController.isActive && searchController.searchBar.text != "" {
            cell.textLabel?.text = filteredCompany[indexPath.row].name
            cell.detailTextLabel?.text = filteredCompany[indexPath.row].address
        } else {
            cell.textLabel?.text = relationshipRepo[indexPath.row]["name"] as! String?
            cell.detailTextLabel?.text = relationshipRepo[indexPath.row]["address"] as! String?
            cell.imageView?.image = UIImage(named: "business")?.withRenderingMode(.alwaysTemplate)
            cell.imageView?.tintColor = UIColor.blue
        }
        
        return cell
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //collapseDetailViewController = false
        performSegue(withIdentifier: "show_detail_segue_id", sender: self)
    }
    
}

extension RelationshipTableViewController:UISearchBarDelegate,UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
//         self.filteredCompany = relationshipRepo.filter({
//         nil != $0.name.range(of:searchController.searchBar.text!)
//         })
        tableView.reloadData()
    }
    
}
