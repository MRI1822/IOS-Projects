//
//  MriworldGenerator.m
//  HurdleRunner
//
//  Created by Mrigank on 20/01/16.
//  Copyright (c) 2016 Mrigank. All rights reserved.
//

#import "MriworldGenerator.h"

@implementation MriworldGenerator

static const uint32_t obstacleCategory = 0x1 << 1;
static const uint32_t groundCategory = 0x1 << 2;

+(id)generatorWithWorld:(SKNode *)world{
    
    MriworldGenerator *generator=[MriworldGenerator node];
    generator.groundX=0;
    generator.obstacleX=220;
    generator.world=world;
    return generator;
    
}
-(void)populate{
    for (int i=0; i<3; i++) {
        [self generate];
    }
}

-(void)generate{
    SKSpriteNode *ground=[SKSpriteNode spriteNodeWithImageNamed:@"boxImage.png"];
    //ground.position=CGPointMake(0,-50);
    ground.position=CGPointMake(self.groundX-self.scene.frame.size.width, - self.scene.frame.size.height + ground.frame.size.height);
    ground.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:ground.size];
    ground.physicsBody.dynamic=NO;
    ground.name=@"ground";
    ground.physicsBody.categoryBitMask=groundCategory;
    [self.world addChild:ground];
    
    self.groundX += ground.frame.size.width;
    
    SKSpriteNode *obstacle=[SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(15,20)];
    obstacle.position=CGPointMake(self.obstacleX,ground.position.y + ground.frame.size.height/2 + obstacle.frame.size.height/2);
    obstacle.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:obstacle.size];
    obstacle.physicsBody.dynamic=NO;
    obstacle.name=@"obstacle";
    obstacle.physicsBody.categoryBitMask=obstacleCategory;
    
    self.obstacleX += 250;
    [self.world addChild:obstacle];
    
    
    
}

@end
