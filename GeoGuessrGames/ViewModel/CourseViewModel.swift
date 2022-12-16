//
//  CourseViewModel.swift
//  GeoGuessrGames
//
//  Created by Vadim Merkalo on 16.12.2022.
//

import Foundation
import UIKit

struct CourseViewModel {
    
    let imageUrl: String
    let name: String
    let title: String
    let latitude1, longitude1, latitude2, longitude2, latitude3, longitude3, latitude4, longitude4, latitude5, longitude5, latitude6, longitude6, latitude7, longitude7, latitude8, longitude8: String
    let detailTextString: String
    let accessoryType: UITableViewCell.AccessoryType
    
    // Dependency Injection (DI)
    init(course: Course) {
        self.imageUrl = course.imageUrl
        self.name = course.author
        self.title = course.title
        
        self.latitude1 = course.latitude1
        self.longitude1 = course.longitude1
        
        self.latitude2 = course.latitude2
        self.longitude2 = course.longitude2
        
        self.latitude3 = course.latitude3
        self.longitude3 = course.longitude3
        
        self.latitude4 = course.latitude4
        self.longitude4 = course.longitude4
        
        self.latitude5 = course.latitude5
        self.longitude5 = course.longitude5
        
        self.latitude6 = course.latitude6
        self.longitude6 = course.longitude6
        
        self.latitude7 = course.latitude7
        self.longitude7 = course.longitude7
        
        self.latitude8 = course.latitude8
        self.longitude8 = course.longitude8
        
        if course.id > 35 {
            detailTextString = "Check it Out!"
            accessoryType = .detailDisclosureButton
        } else {
            detailTextString = course.title
            accessoryType = .none
        }
    }
}
