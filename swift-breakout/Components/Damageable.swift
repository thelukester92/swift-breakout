//
//  Damageable.swift
//  swift-breakout
//
//  Created by Luke Godfrey on 8/13/14.
//  Copyright (c) 2014 Luke Godfrey. See LICENSE.
//

import LGSwiftEngine

class Damageable: LGComponent
{
	class func type() -> String
	{
		return "Damageable"
	}
	
	func type() -> String
	{
		return Damageable.type()
	}
	
	var health: Int
	
	init(health: Int)
	{
		self.health = health
	}
	
	convenience init()
	{
		self.init(health: 1)
	}
}
