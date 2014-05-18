//
//  PhysicsHelper.m
//  UIKitDanceWithBox2d
//
//  Created by ChildhoodAndy on 14-5-17.
//  Copyright (c) 2014年 ChildhoodAndy. All rights reserved.
//

#import "PhysicsHelper.h"

@implementation PhysicsHelper

+ (float)points2meters:(CGFloat)points
{
    return points / PTM_RATIO;
}
+ (CGFloat)meters2points:(float)meters
{
    return meters * PTM_RATIO;
}
+ (b2Vec2)CGPoint2b2Vec:(CGPoint)point
{
    return b2Vec2(point.x / PTM_RATIO, point.y / PTM_RATIO);
}

+ (CGPoint)b2Vec2CGPoint:(b2Vec2)vec
{
    return CGPointMake(vec.x * PTM_RATIO, vec.y * PTM_RATIO);
}

@end
