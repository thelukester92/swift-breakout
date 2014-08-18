//
//  Ball.swift
//  swift-breakout
//
//  Created by Luke Godfrey on 8/18/14.
//  Copyright (c) 2014 Luke Godfrey. All rights reserved.
//

import LGSwiftEngine

class Ball: LGComponent
{
	class func type() -> String
	{
		return "Ball"
	}
	
	func type() -> String
	{
		return Ball.type()
	}
}
