//
//  FeedViewController.swift
//  ios
//
//  Created by Chanintorn Asavavichairoj on 9/18/2559 BE.
//  Copyright © 2559 JO. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class FeedViewController: UITableViewController {
    
    var items = [Item]()
    var viewModel: ViewModel?
    var initializeLoad = false
    var cacheHeight = [Int:CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        title = "Feeds"
        if let main = navigationController?.parent as? MainViewController {
            viewModel = main.viewModel
        }
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 540
        
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.done, target: self, action: #selector(FeedViewController.logout))
        
        viewModel?.subscribe { (items) in
            if let items = items {
                guard items.count > 0 else { return }
                self.initializeLoad = true
                let currentSize = self.items.count
                self.items.append(contentsOf: items)
                
                if currentSize == 0 {
                    self.tableView.reloadData()
                } else {
                    var indexPaths = [IndexPath]()
                    for i in currentSize...self.items.count-1 {
                        indexPaths.append(IndexPath.init(row: i, section: 0))
                    }
                    self.tableView.insertRows(at: indexPaths, with: UITableViewRowAnimation.none)
                }
            }
        }
    }
    
    func logout() {
        let alert = UIAlertController(title: "Application", message: "Are you sure you want to logout?", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let comfirmAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) { (action) in
            UserDefaults.standard.removeObject(forKey: APP_USERNAME)
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(comfirmAction)
        
        let cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedCell

        // Configure the cell...
        cell.setupCell(item: items[indexPath.row])

        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cacheHeight[indexPath.row] = cell.frame.size.height
        
        let lastElement = items.count - 1
        if indexPath.row == lastElement {
            viewModel?.loadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = cacheHeight[indexPath.row] {
            return height
        }
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
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

extension FeedViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = initializeLoad ? "You don't have any photos" : "Loading .."
        let attributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18),
                          NSForegroundColorAttributeName: UIColor.darkGray]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .byWordWrapping
        paragraph.alignment = .center
        
        let attributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14),
                          NSForegroundColorAttributeName: UIColor.lightGray,
                          NSParagraphStyleAttributeName: paragraph]
        
        return initializeLoad ? NSAttributedString(string: text, attributes: attributes) : nil
    }
    
}
