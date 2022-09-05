//
//  QuoteManager.swift
//  PPL
//
//  Created by Chris Boshoff on 2022/09/02.
//

import Foundation

protocol QuoteProtocol {
    func getQuote(_ quote: QuoteModel)
}

struct QuoteManager {
    
    let API_KEY = "X-RapidAPI-Key"
    
    var delegate: QuoteProtocol?
    
    func QuoteAPI() {
        let headers = [
            "X-RapidAPI-Key" : "fb3d5dc375msh391b10a8247ad66p134d0cjsnb55935f470a3",
            "X-RapidAPI-Host": "bodybuilding-quotes1.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://bodybuilding-quotes1.p.rapidapi.com/random-quote")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session  = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            let decoder = JSONDecoder()
            if (error != nil) {
                print(error!)
            } else {
                let httpResponse = response as? HTTPURLResponse
                do {
                    let quote = try decoder.decode(QuoteModel.self, from: data!)
                    self.delegate?.getQuote(quote)
                    print(httpResponse!)
                } catch {
                }
            }
        })
        dataTask.resume()
    }
}
