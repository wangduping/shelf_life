//
//  Goods.swift
//  shelf_life
//
//  Created by dupi on 2017/12/8.
//  Copyright © 2017年 dupi. All rights reserved.
//

import UIKit

class Goods: NSObject {
    var name :String!
    var number:int_fast8_t
    var type : int_fast8_t
    var create_time : String!
    var update_time : String!
    var expiration_time : String!
    override init()
    {
        name = ""
        number = 1
        type = 1
        create_time = ""
        update_time = ""
        expiration_time = ""
        
    }
}
