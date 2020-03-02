//
//  GetScoreViewController.swift
//  CraftDemoLibrary
//
//  Created by Suhail on 18/02/20.
//  Copyright © 2020 Suhail. All rights reserved.
//

import UIKit

public class GetScoreViewController: UIViewController {

    // Class Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var counterSuperView: UIView!
    @IBOutlet weak var counterCardView: UIView!
    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var minValueLabel: UILabel!
    @IBOutlet weak var maxValueLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!

    // Class Varibles
    let responseData:Data
    let viewModel = GetScoreViewModel()
    
    public init(data: Data) {
        self.responseData = data
        super.init(nibName: "GetScoreViewController", bundle: Bundle(for: GetScoreViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit for GetScoreViewController")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.setupUserInterface()
        self.setupViewData()
    }
    
    private func setupUserInterface() {
        self.counterCardView.dropShadow()
        CustomTableViewCell.registerCellForTableView(self.tableView)
    }
    
    private func setupViewData() {
            viewModel.createSwiftModelObjFrom(data: responseData)
            self.closureSetUp()
    }
    
    private func closureSetUp()  {
        viewModel.reloadList = { [weak self] ()  in
            ///UI chnages in main tread
            guard let blockSelf = self else {
                return
            }
            DispatchQueue.main.async {
                if blockSelf.viewModel.isValidData(){
                    blockSelf.tableView.reloadData()
                    blockSelf.setupGraphicalView()
                }
            }
        }
        
        viewModel.errorMessage = { [weak self] (message)  in
            DispatchQueue.main.async {
                self?.popupAlert(title: "", message: message)
            }
        }
    }
    
    private func setupGraphicalView() {
        
        guard let selectedCategory = viewModel.getSelectedCategory() else {
            self.popupAlert(title: "Category not found", message: "User score of: \(String(describing: viewModel.responseData!.data.score)) not falling in any range")
            return
        }
        counterSuperView.isHidden = false
        counterView.counter = viewModel.getCounterNumberForCounterView(selectedCategory: selectedCategory)
        counterLabel.text = "\(viewModel.responseData!.data.score)"
        minValueLabel.text = "\(selectedCategory.minValue)"
        maxValueLabel.text = "\(selectedCategory.maxValue)"
        dateLabel.text = viewModel.getDateStringForDateLabel()
    }
}

extension GetScoreViewController : UITableViewDelegate, UITableViewDataSource {
        
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let numberOfRows = viewModel.responseData?.data.categories.count {
            return numberOfRows
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = CustomTableViewCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
        let category = viewModel.responseData!.data.categories[indexPath.row]
        cell.populateCellData(category: category, userScore: viewModel.responseData!.data.score)
        return cell
    }
}
