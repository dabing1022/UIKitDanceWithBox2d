//
//  Box2DViewController.m
//  UIKitDanceWithBox2d
//
//  Created by ChildhoodAndy on 14-5-17.
//  Copyright (c) 2014年 ChildhoodAndy. All rights reserved.
//

#import "Box2DViewController.h"
#import "PhysicsHelper.h"


#define VELOCITY_INTERATION 8
#define POSITION_INTERATION 1
#define AVATAR_SPEED 10.0f
#define AVATAR_RADIUS 40.0f
@interface Box2DViewController ()
- (void)initPhysicsWorld;
- (void)addPhysicsBodyForView:(UIView*)view;
- (void)physicsTick:(NSTimer*)timer;
@end

@implementation Box2DViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initPhysicsWorld];
    
    UIImage* avatar = NULL;
    for(int i = 0; i < 4; i++)
    {
        avatar = [UIImage imageNamed:@"avatar.png"];
        UIImageView* view = [[UIImageView alloc] initWithImage:avatar];
        view.center = CGPointMake(50 + i * 60, 400);
        [self.view addSubview:view];
        
        [self addPhysicsBodyForView:view];
    }
    
    self.tickTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f/60.0f target:self selector:@selector(physicsTick:) userInfo:nil repeats:YES];
}

- (void)initPhysicsWorld
{
    CGSize size = self.view.bounds.size;
    
    _gravity.Set(0.0f, 0.0f);
    _physicsWorld = new b2World(_gravity);
    _physicsWorld->SetContinuousPhysics(true);
    
    b2BodyDef wallBodyDef;
    wallBodyDef.position.Set(0.0f, 0.0f);
    
    b2Body* wallBody = _physicsWorld->CreateBody(&wallBodyDef);
    
    b2EdgeShape wallEdge;
    wallEdge.Set(b2Vec2(0, 0), b2Vec2(size.width / PTM_RATIO, 0));
    wallBody->CreateFixture(&wallEdge, 0);
    
    wallEdge.Set(b2Vec2(size.width / PTM_RATIO, 0), b2Vec2(size.width / PTM_RATIO, size.height / PTM_RATIO));
    wallBody->CreateFixture(&wallEdge, 0);
    
    wallEdge.Set(b2Vec2(size.width / PTM_RATIO, size.height / PTM_RATIO), b2Vec2(0, size.height / PTM_RATIO));
    wallBody->CreateFixture(&wallEdge, 0);
    
    wallEdge.Set(b2Vec2(0, size.height / PTM_RATIO), b2Vec2(0, 0));
    wallBody->CreateFixture(&wallEdge, 0);
}

- (void)addPhysicsBodyForView:(UIView *)view
{
    CGPoint center = view.center;
    b2CircleShape circle;
    circle.m_radius = [PhysicsHelper points2meters:AVATAR_RADIUS];
    
    b2FixtureDef fd;
    fd.shape = &circle;
    fd.density = 1.0f;
    fd.friction = 0.3f;
    fd.restitution = 0.5;
    
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.userData = (__bridge void*)view;
    bodyDef.position.Set(center.x / PTM_RATIO, center.y / PTM_RATIO);
    b2Body* body = _physicsWorld->CreateBody(&bodyDef);
    body->CreateFixture(&fd);
    body->SetType(b2_dynamicBody);
}

- (void)physicsTick:(NSTimer *)timer
{
    _physicsWorld->Step(1.0f / 60.0f, VELOCITY_INTERATION, POSITION_INTERATION);
    
    for (b2Body* b = _physicsWorld->GetBodyList(); b; b = b->GetNext())
    {
        if (b->GetUserData() != NULL)
        {
            UIView *view = (__bridge UIView*)b->GetUserData();
            CGPoint bodyCenter = CGPointMake(b->GetPosition().x * PTM_RATIO, self.view.bounds.size.height - b->GetPosition().y * PTM_RATIO);
            
            view.center = bodyCenter;
            
            CGAffineTransform tranformAngle = CGAffineTransformMakeRotation(- b->GetAngle());
            view.transform = tranformAngle;
            
            
            float angle = (float)((arc4random() % 100) / 100.0f) * M_PI * 2;
            b->ApplyForceToCenter(b2Vec2(AVATAR_SPEED * cosf(angle), AVATAR_SPEED * sinf(angle)), true);
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    delete _physicsWorld;
    [_tickTimer invalidate];
    _tickTimer = nil;
}

@end
