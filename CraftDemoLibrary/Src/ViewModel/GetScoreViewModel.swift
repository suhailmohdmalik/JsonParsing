//
//  GetScoreViewModel.swift
//  CraftDemoLibrary
//
//  Created by Suhail on 19/02/20.
//  Copyright © 2020 Suhail. All rights reserved.
//

import Foundation

class GetScoreViewModel {
    
    // Closure use for notification
    var reloadList = {() -> () in }
    var errorMessage = {(message : String) -> () in }
    
    ///Array of List Model class
    var responseData : ResponseData? {
        ///Reload data when data set
        didSet{
            reloadList()
        }
    }

    func createSwiftModelObjFrom(data:Data) {
        
      do {
        let parsedDataModelObj = try ResponseData(data: data)
        DispatchQueue.main.async {
            self.responseData = parsedDataModelObj
        }
        } catch {
            self.errorMessage(error.localizedDescription)
        }
    }
    
    func getSelectedCategory() -> Category? {
        var category:Category? = nil
        for item in responseData!.data.categories {
            if item.minValue <= responseData!.data.score && item.maxValue >= responseData!.data.score {
                category = item
                break
            }
        }
        return category
    }
    
    func getCounterNumberForCounterView(selectedCategory: Category) -> Int {
        let totalSteps = Float(selectedCategory.maxValue - selectedCategory.minValue)
        let percentageOfDistanceCovered =  (Float(responseData!.data.score - selectedCategory.minValue) / totalSteps ) * 100
        let steps = (Float(GlobalLibInformation.instance().counterMaxValue) * percentageOfDistanceCovered) / 100
        return Int(steps)
    }
    
    func getDateStringForDateLabel() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(responseData!.data.timestamp))
        let dateFormatter = DateFormatter()
        //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = .current
        return "Current score as of \(dateFormatter.string(from: date))"
    }
    
    func isValidData() -> Bool {
        // check if score duplicate ranks are there in categories
        // check if total percentage of categories in 100% or not
        
        let totalPercentage = responseData!.data.categories.map({$0.percentage}).reduce(0, +)
        if totalPercentage != 100 {
            errorMessage("Total percentage of categories exceeds 100")
            return false
        }
        
        let crossReference = Dictionary(grouping: responseData!.data.categories, by: { $0.rank })
        
        let duplicates = crossReference.filter { $1.count > 1 }
        if duplicates.count > 0 {
            errorMessage("Multiple categories with same rank of \(duplicates[1]![0].rank)")
            return false
        }
        
        return true
    }
}
