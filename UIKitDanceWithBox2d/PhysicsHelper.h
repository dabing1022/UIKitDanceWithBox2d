//
//  PhysicsHelper.h
//  UIKitDanceWithBox2d
//
//  Created by ChildhoodAndy on 14-5-17.
//  Copyright (c) 2014年 ChildhoodAndy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Box2D/Box2D.h"

#define PTM_RATIO (40)
@interface PhysicsHelper : NSObject

+ (float)points2meters:(CGFloat)points;
+ (CGFloat)meters2points:(float)meters;
+ (b2Vec2)CGPoint2b2Vec:(CGPoint)point;
+ (CGPoint)b2Vec2CGPoint:(b2Vec2)vec;

@end
