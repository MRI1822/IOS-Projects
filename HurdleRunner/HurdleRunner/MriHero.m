//
//  MriHero.m
//  HurdleRunner
//
//  Created by Mrigank on 20/01/16.
//  Copyright (c) 2016 Mrigank. All rights reserved.
//

#import "MriHero.h"

@implementation MriHero

static const uint32_t heroCategory = 0x1 << 0;
static const uint32_t obstacleCategory = 0x1 << 1;
static const uint32_t groundCategory = 0x1 << 2;

+(id)hero{
    MriHero *hero = [MriHero spriteNodeWithColor:[UIColor grayColor] size:CGSizeMake(25, 25)];
    hero.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:hero.size];
    
    hero.physicsBody.categoryBitMask=heroCategory;
    hero.physicsBody.contactTestBitMask=obstacleCategory | groundCategory;
    
    return hero;
}

-(void)jump{
    if (!self.isJumping) {
        [self.physicsBody applyImpulse:CGVectorMake(0, 13)];
        [self runAction:[SKAction playSoundFileNamed:@"OnJump.mp4" waitForCompletion:NO]];
        self.isJumping=YES;
        
    }
    
    
}
-(void)land{
    self.isJumping=NO;
}
-(void)start{
    SKAction *incrementRight=[SKAction moveByX:1 y:0 duration:0.007];
    SKAction *moveRight=[SKAction repeatActionForever:incrementRight];
    [self runAction:moveRight];
}
-(void)stop{
    [self removeAllActions];
}

@end
