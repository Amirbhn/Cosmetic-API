//
//  CosmeticTableViewController.swift
//  Amir
//
//  Created by Map04 on 2021-04-15.
//

import UIKit

class CosmeticTableViewController: UITableViewController {
    
    var cosmeticArray = [Cosmetic]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let annnonymousfunc = { (fetchedCosmeticArray : [Cosmetic]) in
            DispatchQueue.main.async {
                self.cosmeticArray =  fetchedCosmeticArray
                self.tableView.reloadData()
            }
        }
        
        CosmeticApi.shared.fetchRootObject(onCompletion: annnonymousfunc)
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        tableView.reloadData()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cosmeticArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! CosmeticTableViewCell
        let cosmetic = cosmeticArray[indexPath.row]
        cell.setCellWithValuesOf(cosmetic: cosmetic)
        return cell
    }
    
    @IBAction func unwindToMainViewController(_ unwindSegue: UIStoryboardSegue) {
        guard unwindSegue.identifier == "From Save",
            let sourceViewController = unwindSegue.source as?
            StaticDetailTableViewController,
            let cosmetic = sourceViewController.cosmetic else { return }

        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            cosmeticArray[selectedIndexPath.row] = cosmetic
            tableView.reloadRows(at: [selectedIndexPath],
            with: .none)
        }
        else {
            let newIndexPath = IndexPath(row: cosmeticArray.count,
            section: 0)
            cosmeticArray.append(cosmetic)
            tableView.insertRows(at: [newIndexPath],
            with: .automatic)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "From Cell"{
            let indexPath = tableView.indexPathForSelectedRow!
            let cosmetic = cosmeticArray[indexPath.row]
            let navController = segue.destination as! UINavigationController
            let showMovieDetailController = navController.topViewController as! StaticDetailTableViewController
            showMovieDetailController.cosmetic = cosmetic
        }
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cosmeticArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedMovie = cosmeticArray.remove(at: fromIndexPath.row)
        cosmeticArray.insert(movedMovie, at: to.row)
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

}
