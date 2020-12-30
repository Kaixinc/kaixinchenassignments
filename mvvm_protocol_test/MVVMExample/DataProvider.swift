//
//  DataProvider.swift
//  MVVMExample
//
//  Created by Alok Upadhyay on 07/12/20.
//  Copyright © 2020 Alok Upadhyay. All rights reserved.
//

import Foundation

protocol DataProviderProtocol {
    func didFinishCloudResponse(error: Error?, data: [Item]?)
}

class DataProvider {
    
    var dataProviderProtocol: DataProviderProtocol?
    
    func getDataFromCloud() {
        
        let urlStr = "https://jsonplaceholder.typicode.com/todos/"
        let url = URL(string: urlStr)
        guard let urlUnwrapped = url else { return }
        URLSession.shared.dataTask(with: urlUnwrapped) { (data, response, error) in
            
            if error == nil {
                 let model = try! JSONDecoder.init().decode([Item].self, from: data!)
                self.dataProviderProtocol?.didFinishCloudResponse(error: error, data: model)

            } else {
                self.dataProviderProtocol?.didFinishCloudResponse(error: error, data: nil)
            }
        }.resume()
    }
}
