//
//  ViewController.swift
//  GeoGuessrGames
//
//  Created by Vadim Merkalo on 16.12.2022.
//

import UIKit

class CoursesController: UITableViewController {
    
    var courseViewModels = [CourseViewModel]()
    let cellId = "cellId"
    var text: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupNavBar()
        setupTableView()
        fetchData()
    }
    
    fileprivate func fetchData() {
        Service.shared.fetchCourses { (courses, err) in
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            
            self.courseViewModels = courses?.map({return CourseViewModel(course: $0)}) ?? []
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CourseCell
        let courseViewModel = courseViewModels[indexPath.row]
        cell.courseViewModel = courseViewModel
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MapViewControllerID") as! MapViewController
        vc.curentPoints = courseViewModels[indexPath.row]
        self.present(vc, animated:false, completion:nil)
    }
    
    fileprivate func setupTableView() {
        tableView.register(CourseCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        tableView.separatorColor = .mainTextBlue
        tableView.backgroundColor = UIColor.white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.tableFooterView = UIView()
    }
    
    fileprivate func setupNavBar() {
                navigationItem.title = "Geo Guessr Game"
                navigationController?.navigationBar.prefersLargeTitles = true
                navigationController?.navigationBar.backgroundColor = .white
                navigationController?.navigationBar.isTranslucent = false
                navigationController?.navigationBar.barTintColor = UIColor.white
                navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
}
class CustomNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension UIColor {
    static let mainTextBlue = UIColor.rgb(r: 7, g: 71, b: 89)
    static let highlightColor = UIColor.rgb(r: 50, g: 199, b: 242)
    
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

