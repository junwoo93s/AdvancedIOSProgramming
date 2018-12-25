

import UIKit

protocol CategoryDelegate {
    func display(section: Int, row: Int)
    func checkHeart(heart: UIImage, row: Int)
}

class CategoryTableViewController: UITableViewController,InfoDelegate, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    
    func StoreImages(changedImageIndexPath: [IndexPath : UIImage], editedText: [String:String], changedHeight: [String:CGFloat]) {
        recievedIndexPath = changedImageIndexPath
        savedTextView = editedText
        changedHeightCate = changedHeight
        
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text!
        if !text.isEmpty {
            let filter = {(BuildingName :BuildingName) in BuildingName.searchKey.contains(text)}
            mapModel.updateFilter(filter: filter)
            self.tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        let filter = {(BuildingName :BuildingName) in true}
        mapModel.updateFilter(filter: filter)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "CategoryTableViewController") as! CategoryTableViewController
//        self.present(controller, animated: true, completion: nil)
//
   

//        tableView.beginUpdates()
//
//        tableView.endUpdates()
        tableView.reloadData()
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            let filter = {(BuildingName :BuildingName) in true}
            mapModel.updateFilter(filter: filter)
            tableView.reloadData()
        }
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        searchController.becomeFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            searchBar.keyboardType = UIKeyboardType.default
        case 1:
            searchBar.keyboardType = UIKeyboardType.alphabet
        case 2:
            searchBar.keyboardType = UIKeyboardType.numberPad
        default:
            assert(false, "Unhandled scope")
        
        }
        searchBar.reloadInputViews()
    }
    
    
    let searchController =  UISearchController(searchResultsController: nil)

    

    
    func InfoDisplay(indexPath: IndexPath) {
        indexPathFromInfoPage = indexPath
        delegate?.display(section: indexPathFromInfoPage.section, row: indexPathFromInfoPage.row)
    }
    
    
    var currentHeartTag = Int()
    var changedHeightCate = [String:CGFloat]()
    var recievedIndexPath = [IndexPath: UIImage]()
    var savedTextView = [String:String]()
    var indexPathFromInfoPage = IndexPath()
    let mapModel = MapModel.sharedInstance
    var delegate : CategoryDelegate?
    var buttonTag = 0
    var isChecked = [Bool](repeating: false, count: 324)
    var FavData = [BuildingName]()
    var whichSectionRowSelected = IndexPath()
    
    override func viewDidLoad() {
//        for i in isChecked{
//            if i == true{
//            }
//        }
        super.viewDidLoad()
        self.title = "Building List"
        self.navigationItem.prompt = "Select One to DropPin"
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        tableView.tableHeaderView = searchController.searchBar
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = false
        searchController.searchBar.scopeButtonTitles = ["All", "Name", "Built Year"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return mapModel.AlphabetName().count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mapModel.AlphabetName()[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mapModel.eachRowsInSection(index: section).count
        
    }

    @objc func FavButtonPressed(sender: UIButton){
        if searchController.isActive == true{
            let cell = sender.superview as! UITableViewCell
            let nameOfBuilding = cell.textLabel?.text!
            let whichIndex = mapModel.FindIndexInfoWithName(name: nameOfBuilding!)
            currentHeartTag = whichIndex
            if sender.currentImage == #imageLiteral(resourceName: "Heart"){
                sender.setImage(#imageLiteral(resourceName: "favorite"), for: .normal)
                isChecked[whichIndex] = true
                delegate?.checkHeart(heart: sender.currentImage!, row: whichIndex)
                FavData.append(mapModel.allBuilding[whichIndex])

            }
            else{
                sender.setImage(#imageLiteral(resourceName: "Heart"), for: .normal)
                isChecked[whichIndex] = false
                delegate?.checkHeart(heart: sender.currentImage!, row: whichIndex)
                for i in 0..<FavData.count{
                    if FavData[i].name == nameOfBuilding{
                        FavData.remove(at: i)
                        break
                    }
                }
            }
            
        }
        else{
            if sender.currentImage == #imageLiteral(resourceName: "Heart"){
                sender.setImage(#imageLiteral(resourceName: "favorite"), for: .normal)
                isChecked[sender.tag] = true
                delegate?.checkHeart(heart: sender.currentImage!, row: sender.tag)
                FavData.append(mapModel.Building[sender.tag])
            }
            else{
                sender.setImage(#imageLiteral(resourceName: "Heart"), for: .normal)
                isChecked[sender.tag] = false
                delegate?.checkHeart(heart: sender.currentImage!, row: sender.tag)
                let name = mapModel.Building[sender.tag].name
                for i in 0..<FavData.count{
                    if FavData[i].name == name{
                        FavData.remove(at: i)
                        break
                    }
                }
                
            }
        }

    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Category", for: indexPath)
        let FavButton = UIButton(type: .custom)
        FavButton.tag = buttonTag
        buttonTag = buttonTag + 1
        if isChecked[FavButton.tag] == true{
            FavButton.setImage(#imageLiteral(resourceName: "favorite"), for: .normal)
        }
        else{
            FavButton.setImage(#imageLiteral(resourceName: "Heart"), for: .normal)

        }
        FavButton.addTarget(self, action: #selector(FavButtonPressed(sender:)), for: .touchUpInside)
        FavButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)


        cell.accessoryView = FavButton
        cell.textLabel?.text = mapModel.eachRowsInSection(index: indexPath.section)[indexPath.row]
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        whichSectionRowSelected = indexPath
        performSegue(withIdentifier: "infoPage", sender: self)

//        delegate?.display(section: indexPath.section, row: indexPath.row)
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return mapModel.AlphabetName()
    }

    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if searchController.isActive == true{

        }
        else{
            let name = cell.textLabel?.text!
            let whichIndex = mapModel.FindIndexInfoWithName(name: name!)
            let FavButton = UIButton(type: .custom)
            FavButton.tag = whichIndex
            if isChecked[whichIndex] == true{
                
                
                FavButton.setImage(#imageLiteral(resourceName: "favorite"), for: .normal)

            }
            else{
                FavButton.setImage(#imageLiteral(resourceName: "Heart"), for: .normal)

            }
            FavButton.addTarget(self, action: #selector(FavButtonPressed(sender:)), for: .touchUpInside)
            FavButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            cell.accessoryView = FavButton

        }

        
    }
    
    

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "Favorite":
            let FavTableViewController = segue.destination as! FavTableViewController
            
//            FavTableViewController.isChecked = isChecked
            FavTableViewController.FavData = FavData
            
        case "This":
            let MapViewController = segue.destination as! MapViewController
            MapViewController.FavData = FavData
            MapViewController.recievedIndexPath = recievedIndexPath
            MapViewController.saveTextView = savedTextView
        case "infoPage":
            let navController = segue.destination as! UINavigationController
            let infoViewController = navController.topViewController as! InfoViewController
            infoViewController.delegate = self
            infoViewController.indexPathForSelectedBuilding = whichSectionRowSelected
            infoViewController.changedImageIndexPath = recievedIndexPath
            infoViewController.savedTextView = savedTextView
            infoViewController.changedHeight = changedHeightCate
            
        default:
            assert(false, "Unhandled Segue")
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
