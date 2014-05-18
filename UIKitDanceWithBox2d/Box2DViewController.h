//
//  Box2DViewController.h
//  UIKitDanceWithBox2d
//
//  Created by ChildhoodAndy on 14-5-17.
//  Copyright (c) 2014年 ChildhoodAndy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Box2D/Box2D.h>

@interface Box2DViewController : UIViewController
{
    b2World* _physicsWorld;
    b2Vec2 _gravity;
}

@property(nonatomic, strong)NSTimer* tickTimer;
@end
