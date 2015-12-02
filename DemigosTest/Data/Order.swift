//
//  Order.swift
//  DemigosTest
//
//  Created by Roman Slysh on 12/1/15.
//  Copyright © 2015 Roman Slysh. All rights reserved.
//

import Foundation

public struct Order {
  var departureAddress: Address
  var destinationAddress: Address
  
  init(departureAddress: Address, destinationAddress: Address) {
    self.departureAddress = departureAddress
    self.destinationAddress = destinationAddress
  }
  
//  init(dict: NSDictionary) {
//    self.departureAddress = Address()
//    self.destinationAddress = Address()
//  }
}
