//
//  GlobalLibInformation.swift
//  CraftDemoLibrary
//
//  Created by Suhail on 20/02/20.
//  Copyright © 2020 Suhail. All rights reserved.
//

import UIKit

@IBDesignable class CounterView: UIView {
  
  private struct Constants {
    static let counterMaxValue = GlobalLibInformation.instance().counterMaxValue
    static let lineWidth: CGFloat = 20
    static let arcWidth: CGFloat = 20
    
    static var halfOfLineWidth: CGFloat {
      return lineWidth / 2
    }
  }
  
  @IBInspectable var counter: Int = 0 {
    didSet {
      if counter <=  Constants.counterMaxValue {
        //the view needs to be refreshed
        setNeedsDisplay()
      }
    }
  }
  @IBInspectable var outlineColor: UIColor = UIColor.red
  @IBInspectable var counterColor: UIColor = UIColor.green
  
  override func draw(_ rect: CGRect) {
    // 1
    let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
    
    // 2
    let radius: CGFloat = max(bounds.width, bounds.height)
    
    // 3
    let startAngle: CGFloat = 3 * .pi / 4
    let endAngle: CGFloat = .pi / 4
    
    // 4
    let path = UIBezierPath(arcCenter: center,
                            radius: radius/2 - Constants.arcWidth/2,
                            startAngle: startAngle,
                            endAngle: endAngle,
                            clockwise: true)
    
    // 5
    path.lineWidth = Constants.arcWidth
    counterColor.setStroke()
    path.stroke()
    
    
    //Draw the outline
    
    //1 - first calculate the difference between the two angles
    //ensuring it is positive
    let angleDifference: CGFloat = 2 * .pi - startAngle + endAngle
    //then calculate the arc for each single glass
    let arcLengthPerGlass = angleDifference / CGFloat(Constants.counterMaxValue)
    //then multiply out by the actual glasses drunk
    let outlineEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle
    
    //2 - draw the outer arc
    let outlinePath = UIBezierPath(arcCenter: center,
                                   radius: bounds.width/2 - Constants.halfOfLineWidth,
                                   startAngle: startAngle,
                                   endAngle: outlineEndAngle,
                                   clockwise: true)
    
    //3 - draw the inner arc
    outlinePath.addArc(withCenter: center,
                       radius: bounds.width/2 - Constants.arcWidth + Constants.halfOfLineWidth,
                       startAngle: outlineEndAngle,
                       endAngle: startAngle,
                       clockwise: false)
    
    //4 - close the path
    outlinePath.close()
    
    outlineColor.setStroke()
    outlinePath.lineWidth = Constants.lineWidth
    outlinePath.stroke()
  }
}
