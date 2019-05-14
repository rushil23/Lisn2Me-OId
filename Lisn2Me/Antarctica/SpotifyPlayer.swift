//
//  SpotifyPlayer.swift
//  Antarctica
//
//  Created by Ayushi shah on 2019-04-22.
//  Copyright © 2019 Ayushi Shah. All rights reserved.
//

import Foundation

class SpotifyPlayerViewController: UITableViewController {
    
    var data: NSArray = []
    
    override func viewDidLoad() {
        
    }
    
    
    func getMusic(){
        let api = URL(string: "https://api.spotify.com/v1/me/player/currently-playing?market=ES")
//        let request: NSMutableURLRequest = NSMutableURLRequest()
//        request.url = NSURL(string: api) as! URL
//        request.httpMethod = "GET"
            let configuration = URLSessionConfiguration .default
            let session = URLSession(configuration: configuration)
            
            
            let urlString = NSString(format: "https://api.spotify.com/v1/me/player/currently-playing?market=ES")
            
            //let url = NSURL(string: urlString as String)
            let request : NSMutableURLRequest = NSMutableURLRequest()
            request.url = NSURL(string: NSString(format: "%@", urlString) as String)! as URL
            request.httpMethod = "GET"
            request.timeoutInterval = 30
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            //get access token
            let userDefaults = UserDefaults.standard
            let sessionAccessToken = userDefaults.string(forKey: "userDefaults")
            
            request.addValue(sessionAccessToken!, forHTTPHeaderField: "Authorization")
            
   
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
                
                // 1: Check HTTP Response for successful GET request
                guard let httpResponse = response as? HTTPURLResponse, let receivedData = data
                    else {
                        print("error: not a valid http response")
                        return
                }
                
                switch (httpResponse.statusCode)
                {
                case 200:
                    
                    let response = NSString (data: receivedData, encoding: String.Encoding.utf8.rawValue)
                    print("response is \(response)")
                    
                    
                    do {
                        let getResponse = try JSONSerialization.jsonObject(with: receivedData, options: .allowFragments)
                        
                        //EZLoadingActivity.hide()
                        
                        // }
                    } catch {
                        print("error serializing JSON: \(error)")
                    }
                    
                    break
                case 400:
                    
                    break
                default:
                    print("wallet GET request got response \(httpResponse.statusCode)")
                }
            })
            
            dataTask.resume()
            
        }

}

