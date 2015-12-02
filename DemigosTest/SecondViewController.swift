//
//  SecondViewController.swift
//  DemigosTest
//
//  Created by Roman Slysh on 11/30/15.
//  Copyright © 2015 Roman Slysh. All rights reserved.
//

import UIKit

class SecondViewController: ParentViewController {
  @IBOutlet weak var mapView: GMSMapView!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    getOrders( { orders in
      for order in orders {
        let departureParams = self.getParams(order.departureAddress)
        let destinationParams = self.getParams(order.destinationAddress)
        
        "json".get(departureParams, completion: { response in
          
          if response.responseJSON != nil && (response.responseJSON!["results"] as! NSArray).count != 0 {
            let results = (response.responseJSON!["results"] as! NSArray)[0] as! NSDictionary
            let position = self.getPosition(results)
            let title = results["formatted_address"] as! String
            self.addMarker(position, title: title, color: UIColor.greenColor())
            //print("departure - \(title)")
          } else {
            //print("departure - \(response.responseJSON)")
          }
        })
        
        "json".get(destinationParams, completion: { response in
          
          if response.responseJSON != nil && (response.responseJSON!["results"] as? NSArray)?.count != 0 {
            let results = (response.responseJSON!["results"] as! NSArray)[0] as! NSDictionary
            let position = self.getPosition(results)
            let title = results["formatted_address"] as! String
            self.addMarker(position, title: title, color: UIColor.redColor())
            //print("destination - \(title)")
          } else {
            //print("destination - \(response.responseJSON)")
          }
        })
 
      }
      
    })
  }
  
  func getParams(address: Address) -> [String : String] {
    var params = ["region":"\(address.countryCode)",
      "components": "postal_code=\(address.zipCode)",
      "key":requestKey]
    let street = address.street != "" ? address.street : ""
    let houseNumber = address.houseNumber != "" ? address.houseNumber : ""
    if street != "" {
      params.updateValue("\(address.city) \(street!) \(houseNumber != "" ? houseNumber! : "")", forKey: "address")
    } else {
      params.updateValue(address.city, forKey: "address")
    }
    return params
  }
  
  func getPosition(results: NSDictionary) -> CLLocationCoordinate2D {
    let location = results["geometry"]!["location"] as! NSDictionary
    let lat = location["lat"] as! Double
    let lng = location["lng"] as! Double
    return CLLocationCoordinate2DMake(lat,lng)
  }
  
  func addMarker(position: CLLocationCoordinate2D, title: String, color: UIColor) {
    let marker = GMSMarker(position: position)
    marker.title = title
    marker.icon = GMSMarker.markerImageWithColor(color)
    marker.appearAnimation = kGMSMarkerAnimationPop
    marker.map = self.mapView
  }
  
  func getOrders(callback: (Array<Order>) -> Void) {
    var orders: Array<Order> = []
    let URL = NSURL(string: "http://mobapply.com/tests/orders/")!
    let task = NSURLSession.sharedSession().dataTaskWithURL(URL) { (let data, let response, let error) in
    do {
      let jsonArray = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSArray
      for item in jsonArray {
        let depatureAddress = Address(dict: (item as! NSDictionary)["departureAddress"] as! NSDictionary)
        let destinationAddress = Address(dict: (item as! NSDictionary)["destinationAddress"] as! NSDictionary)
        let order = Order(departureAddress: depatureAddress, destinationAddress: destinationAddress)
        orders.append(order)
      }
    } catch _ {
        let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
        print("Error could not parse JSON: '\(jsonStr)'")
      }
      callback(orders)
    }
    task.resume()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

