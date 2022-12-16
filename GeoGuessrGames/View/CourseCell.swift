//
//  CourseCell.swift
//  GeoGuessrGames
//
//  Created by Vadim Merkalo on 16.12.2022.
//

import Foundation
import UIKit

class CourseCell: UITableViewCell {
    
    var courseViewModel: CourseViewModel! {
        didSet {
            
            let url = URL(string: courseViewModel.imageUrl)
            let data = try? Data(contentsOf: url!)
            imageView?.image = UIImage(data: data!)
            
            let itemSize:CGSize = CGSizeMake(100, 80)
            UIGraphicsBeginImageContextWithOptions(itemSize, false, UIScreen.main.scale)
            let imageRect : CGRect = CGRectMake(0, 0, itemSize.width, itemSize.height)
            imageView!.image?.draw(in: imageRect)
            imageView!.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            textLabel?.text = courseViewModel.name
            detailTextLabel?.text = courseViewModel.detailTextString
            accessoryType = courseViewModel.accessoryType

        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        contentView.backgroundColor = isHighlighted ? .highlightColor : .white
        textLabel?.textColor = isHighlighted ? UIColor.white : .mainTextBlue
        detailTextLabel?.textColor = isHighlighted ? .white : .black
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        // cell customization
        textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        textLabel?.numberOfLines = 0
        detailTextLabel?.textColor = .black
        detailTextLabel?.font = UIFont.systemFont(ofSize: 12, weight: .light)
        detailTextLabel?.numberOfLines = 10
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
