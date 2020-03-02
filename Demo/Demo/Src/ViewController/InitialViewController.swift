//
//  InitialViewController.swift
//  Demo
//
//  Created by Suhail on 18/02/20.
//  Copyright © 2020 Suhail. All rights reserved.
//

import UIKit
import CraftDemoLibrary

class InitialViewController: UIViewController {

    var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = GlobalVariableInformation.instance().craftDemoString
    }
    
    @IBAction func getScore(_ sender: Any) {
        self.closureSetUp()
        self.viewModel.loadJsonFromFile()
    }

    private func closureSetUp()  {
        
        viewModel.data = { [weak self] (data) in
            DispatchQueue.main.async {
                guard let blockSelf = self else {
                    return
                }
                
                let vc = GetScoreViewController(data: data)
                vc.modalPresentationStyle = .fullScreen
                blockSelf.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        viewModel.errorMessage = { [weak self] (message)  in
            DispatchQueue.main.async {
                guard let blockSelf = self else {
                    return
                }
                blockSelf.popupAlert(title: "", message: message)
            }
        }
    }
}
