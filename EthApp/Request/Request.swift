//
//  Request.swift
//  EthApp
//
//  Created by Данила on 02.08.2022.
//

import Foundation
import UIKit


class Request {
//    let date1970
    var eth = String()
    func getEth() -> String {
        let str: String = "https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=USD"
        var request = URLRequest(url: URL(string: str)!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["AuthToken": "null"]
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let ans = try? JSONDecoder().decode(Welcome.self, from: data) {
                self.eth = String(ans.usd!)
            }
        }
        task.resume()
        return eth
    }
    
    var ethDate = String()
    func getEthDate(time: Double) -> String {
        let str: String = "https://min-api.cryptocompare.com/data/v2/histominute?fsym=ETH&tsym=USD&limit=1&aggregate=1&toTs=\(time)"
        var request = URLRequest(url: URL(string: str)!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["AuthToken": "null"]
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let ans = try? JSONDecoder().decode(WelcomeSec.self, from: data) {
                self.ethDate = String((ans.data?.data?[0].high)!)
            }
        }
        task.resume()
        return ethDate
    }
}


