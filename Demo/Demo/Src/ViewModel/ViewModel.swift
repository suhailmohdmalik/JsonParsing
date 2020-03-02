//
//  ViewModel.swift
//  Demo
//
//  Created by Suhail on 19/02/20.
//  Copyright © 2020 Suhail. All rights reserved.
//

import UIKit
import Foundation

class ViewModel {
    
    // Closure use for notifi
    var data = {(data : Data) -> () in }
    var errorMessage = {(message : String) -> () in }
    
    // Get data from API
    func getServicecall() {
        
        let urlString: String = "http://localhost:3000/data"
        
        let encodedUrl = urlString.encodedUrl()
        // Create the Request with URLRequest
        var request = URLRequest(url: encodedUrl!)
        request.httpMethod = "GET"

        //create the session object
        let session = URLSession.shared
        //create dataTask using the session object to send data to the server
        session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            // Error
            if let error = error {
                self.errorMessage(error.localizedDescription)
                return
            }
            self.data(data!)

            }).resume()
    }
    
    func loadJsonFromFile() {
        if let url = Bundle.main.url(forResource: GlobalVariableInformation.instance().fileName, withExtension: GlobalVariableInformation.instance().extensionType) {
            do {
                let data = try Data(contentsOf: url)
                self.data(data)
            } catch {
                self.errorMessage(error.localizedDescription)
            }
        }else {
           self.errorMessage("Cannot load JSON file from Bundle")
        }
    }
}
