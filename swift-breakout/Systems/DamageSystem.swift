//
//  DamageSystem.swift
//  swift-breakout
//
//  Created by Luke Godfrey on 8/13/14.
//  Copyright (c) 2014 Luke Godfrey. See LICENSE.
//

import LGSwiftEngine

class DamageSystem: LGSystem
{
	var damageables = [Damageable]()
	
	override func accepts(entity: LGEntity) -> Bool
	{
		return entity.has(Damageable)
	}
	
	override func add(entity: LGEntity)
	{
		super.add(entity)
		damageables.append(entity.get(Damageable)!)
	}
	
	override func remove(index: Int)
	{
		super.remove(index)
		damageables.removeAtIndex(index)
	}
	
	override func update()
	{
		for i in 0 ..< entities.count
		{
			if damageables[i].health <= 0
			{
				scene.removeEntity(entities[i])
			}
		}
	}
}
