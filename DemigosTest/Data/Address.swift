//
//  Address.swift
//  DemigosTest
//
//  Created by Roman Slysh on 12/1/15.
//  Copyright © 2015 Roman Slysh. All rights reserved.
//
import Foundation

public struct Address {
  var countryCode: String!
  var country: String?
  var zipCode: Int!
  var city: String!
  var street: String?
  var houseNumber: String?
  
  init(dict: NSDictionary) {
    countryCode = dict["countryCode"] as! String
    country = dict["country"] as? String
    zipCode = (dict.objectForKey("zipCode")?.integerValue)!
    city = dict["city"] as! String
    street = dict["street"] as? String
    houseNumber = dict["houseNumber"] as? String
  }
}