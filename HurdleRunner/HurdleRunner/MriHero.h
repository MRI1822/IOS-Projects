//
//  MriHero.h
//  HurdleRunner
//
//  Created by Mrigank on 20/01/16.
//  Copyright (c) 2016 Mrigank. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MriHero : SKSpriteNode

@property BOOL isJumping;

+(id)hero;
-(void)jump;
-(void)start;
-(void)stop;
-(void)land;

@end
