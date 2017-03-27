//
//  Network.swift
//  RxSwiftAlamofire
//
//  Created by Arash on 3/27/17.
//  Copyright © 2017 Arash Z. Jahangiri. All rights reserved.
//

import ObjectMapper
import RxCocoa
import RxSwift

final class Network {
    
    func fetchDate() -> Observable<String> {
        return Observable<String>.create({ (observer) -> Disposable in
            
            let session = URLSession.shared
            let task = session.dataTask(with: URL(string:self.baseURL())!) { (data, response, error) in
                
                // We want to update the observer on the UI thread
                DispatchQueue.main.async {
                    if let err = error {
                        // If there's an error, send an Error event and finish the sequence
                        observer.onError(err)
                    } else {
                        let json = self.convertToDictionary(text: String(data: data!, encoding: .ascii)!)!
                        let model = Mapper<Model>().map(JSON: json["data"] as! [String : Any])
                        let str:String? = model?.dateStr
                        observer.onNext(str!)
                        
                    }
                    //Complete the sequence
                    observer.onCompleted()
                }
            }
            
            task.resume()
            
            return Disposables.create(with: {
                //Cancel the connection if disposed
                task.cancel()
            })
        })
    }
    
    func baseURL() -> String {
        return "http://localhost:3000/getCurrentDate"
    }
    
    func convertToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
