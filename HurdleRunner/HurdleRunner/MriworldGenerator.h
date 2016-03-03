//
//  MriworldGenerator.h
//  HurdleRunner
//
//  Created by Mrigank on 20/01/16.
//  Copyright (c) 2016 Mrigank. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MriworldGenerator : SKNode

@property SKNode *world;
@property double obstacleX;
@property double groundX;

+(id)generatorWithWorld:(SKNode *)world;
-(void)populate;
-(void)generate;

@end
