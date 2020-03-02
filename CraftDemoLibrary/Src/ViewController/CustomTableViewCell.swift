//
//  CustomTableViewCell.swift
//  CraftDemoLibrary
//
//  Created by Suhail on 19/02/20.
//  Copyright © 2020 Suhail. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var scoreRangeLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var userScoreIndicator: UIImageView!
    @IBOutlet weak var userScoreDistanceConstraint: NSLayoutConstraint!
    @IBOutlet weak var scoreRangeConstraint: NSLayoutConstraint!

    static let identifier = "CustomTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userScoreIndicator.clipsToBounds = false
    }
    
    static func registerCellForTableView(_ tableView:UITableView)
    {
        tableView.register(UINib(nibName: identifier, bundle: Bundle(for: CustomTableViewCell.self)), forCellReuseIdentifier: identifier)
    }
    
    static func dequeueReusableCell(tableView:UITableView, indexPath: IndexPath) -> CustomTableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CustomTableViewCell
    }
    
    func populateCellData(category:Category, userScore: Int) {
        self.percentageLabel.text = "\(category.percentage)%"
        self.scoreRangeLabel.text = "\(category.minValue)-\(category.maxValue)"
        self.colorView.backgroundColor = UIColor(hex: "#\(category.color)")
        self.setScorePointer(minValue: category.minValue, maxValue: category.maxValue, userScore: userScore)
    }
    
    private final func setScorePointer(minValue:Int, maxValue:Int, userScore: Int) {
        var isUserCategory = false
        if userScore >= minValue && userScore <= maxValue {
            isUserCategory = true
        }
        
        if isUserCategory {
            DispatchQueue.main.async {
                let finalPoint = self.colorView.bounds.size.width
                let totalSteps = CGFloat(maxValue - minValue)
                let percentageOfDistanceCovered =  (CGFloat(userScore - minValue) / totalSteps ) * 100
                if percentageOfDistanceCovered < 21 {
                    self.updateLayoutForScoreRangeLabel()
                }else {
                    self.scoreRangeConstraint.constant = 15
                }
                
                let distanceinPX = finalPoint
                let totalPxCovered = (distanceinPX * percentageOfDistanceCovered) / 100
                    
                if(totalPxCovered + self.userScoreIndicator.frame.size.width > finalPoint) {
                    self.userScoreDistanceConstraint.constant = finalPoint - self.userScoreIndicator.frame.size.width
                }else {
                    self.userScoreDistanceConstraint.constant = totalPxCovered
                }
            }
        }else {
            self.scoreRangeConstraint.constant = 15
            self.userScoreIndicator.isHidden = true
            self.userScoreDistanceConstraint.constant = 0.0
        }
    }
    
    func updateLayoutForScoreRangeLabel() {
        let finalPoint = self.colorView.bounds.size.width
        self.scoreRangeConstraint.constant = finalPoint - self.scoreRangeLabel.frame.size.width - self.scoreRangeLabel.frame.origin.x
    }
}
