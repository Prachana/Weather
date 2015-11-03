//
//  ViewController.swift
//  weather
//
//  Created by Rachana Pandey on 11/3/15.
//  Copyright © 2015 anarach. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var cityEntered: UITextField!
    
    @IBOutlet var weatherShown: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func goButton(sender: AnyObject) {
        
        var wasSuccessful = false
        
        
        let attemptedUrl = NSURL(string: "http://www.weather-forecast.com/locations/" + cityEntered.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        
        
        
        if let url = attemptedUrl {
        
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            
            
            if let urlContent = data{
                
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                
                let webArray = webContent!.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                
                
                
                if webArray.count > 1{
                    
                    let weatherArray = webArray[1].componentsSeparatedByString("</span>")
        
                    if weatherArray.count > 1{
                        
                        wasSuccessful = true

                        
                        
                        
                        let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            
                            self.weatherShown.text = weatherSummary
                        })
                        
                        
                        
                    }
                    
                    
                    
                }
                
                
                
                
            }
            
            
            
            if wasSuccessful == false
            {
                
                
            self.weatherShown.text = "Couldn't find the weather for city please try again."
                
                
            }
            
            
            
        }
        task.resume()
        

        
        }
        
        else {
            
            self.weatherShown.text = "Couldn't find the weather for" + cityEntered.text! + " city please try again."

            
            
        }
        
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
    }

}

