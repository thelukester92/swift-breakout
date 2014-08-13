//
//  BallAimer.swift
//  swift-breakout
//
//  Created by Luke Godfrey on 8/13/14.
//  Copyright (c) 2014 Luke Godfrey. See LICENSE.
//

import LGSwiftEngine

class BallAimer: LGComponent
{
	class func type() -> String
	{
		return "BallAimer"
	}
	
	func type() -> String
	{
		return BallAimer.type()
	}
	
	var deltas: [Double]
	
	init(deltas: [Double])
	{
		self.deltas = deltas
	}
	
	convenience init()
	{
		self.init(deltas: [-1, 0, 1])
	}
}
