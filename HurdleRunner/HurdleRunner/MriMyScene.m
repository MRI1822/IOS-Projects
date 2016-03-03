//
//  MriMyScene.m
//  HurdleRunner
//
//  Created by Mrigank on 20/01/16.
//  Copyright (c) 2016 Mrigank. All rights reserved.
//

#import "MriMyScene.h"
#import "MriHero.h"
#import "MriworldGenerator.h"
#import "MripointsLabel.h"
#import "GameData.h"

@implementation MriMyScene{
    MriHero *hero;
    SKNode *world;
    MriworldGenerator *generator;
    }
static NSString *GAME_FONT=@"AmericanTypewriter-Bold";
-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        
        self.anchorPoint=CGPointMake(0.5,0.5);
        
        self.physicsWorld.contactDelegate=self;
        
        self.backgroundColor = [SKColor colorWithRed:0.54 green:0.7853 blue:1.0 alpha:1.0];
        [self createContent];
    }
    return self;
}
-(void)createContent{
    
    
    
        world=[SKNode node];
        [self addChild:world];
        
        generator=[MriworldGenerator generatorWithWorld:world];
        [self addChild:generator];
        [generator populate];
        
         hero=[MriHero hero];
        [world addChild:hero];
        
    
    
    SKLabelNode *tapToBeginLabel=[SKLabelNode labelNodeWithFontNamed:GAME_FONT];
    tapToBeginLabel.name=@"tapToBeginLabel";
    tapToBeginLabel.text=@"Tap to Begin";
    tapToBeginLabel.fontSize=20;
    tapToBeginLabel.fontColor=[UIColor blackColor];
    tapToBeginLabel.position=CGPointMake(0, 20);
    [self addChild:tapToBeginLabel];
    [self beginPulseAction:tapToBeginLabel];
    [self cloudShape];
    [self loadScoreLabel];
    
    }
-(void)updateHighScore{
    MripointsLabel *pointsLabel=(MripointsLabel *)[self childNodeWithName:@"pointsLabel"];
    MripointsLabel *highScoreLabel=(MripointsLabel *)[self childNodeWithName:@"highScoreLabel"];
    if (pointsLabel.number > highScoreLabel.number) {
        [highScoreLabel setPoints:pointsLabel.number];
        GameData *data=[GameData data];
        data.highScore=pointsLabel.number;
        [data save];
    }
}

-(void)loadScoreLabel{
    MripointsLabel *pointsLabel=[MripointsLabel pointsLabelWithFormat:GAME_FONT];
    pointsLabel.position=CGPointMake(-180,130);
    pointsLabel.name=@"pointsLabel";
    pointsLabel.fontSize=20;
    [self addChild:pointsLabel];
    
    GameData *data=[GameData data];
    [data load];
    
    MripointsLabel *highScoreLabel=[MripointsLabel pointsLabelWithFormat:GAME_FONT];
    highScoreLabel.position=CGPointMake(190, 130);
    highScoreLabel.name=@"highScoreLabel";
    [highScoreLabel setPoints:data.highScore];
    highScoreLabel.fontSize=20;
    [self addChild:highScoreLabel];
    
    SKLabelNode *bestLabel=[SKLabelNode labelNodeWithFontNamed:GAME_FONT];
    bestLabel.fontSize=20;
    bestLabel.position=CGPointMake(-32, 0);
    bestLabel.text=@"Best:";
    [highScoreLabel addChild:bestLabel];
    
    
    
}
-(void)cloudShape{
    SKShapeNode *cloudShape=[SKShapeNode node];
    cloudShape.path=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 60, 50, 15)].CGPath;
    cloudShape.fillColor=[UIColor whiteColor];
    cloudShape.strokeColor=[UIColor blackColor];
    [world addChild:cloudShape];
    
    SKShapeNode *cloud2=[SKShapeNode node];
    cloud2.path=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 90, 60, 20)].CGPath;
    cloud2.fillColor=[UIColor whiteColor];
    cloud2.strokeColor=[UIColor blackColor];
    [world addChild:cloud2];
    
    
}

-(void)start{
    self.isStart=YES;
    
    [[self childNodeWithName:@"tapToBeginLabel"]removeFromParent];
    
    [hero start];
}
-(void)clear{
    MriMyScene *myScene=[[MriMyScene alloc]initWithSize:self.frame.size];
    [self.view presentScene:myScene];
}
-(void)gameOver{
    self.isGameOver=YES;
    
    SKLabelNode *tapToRestart=[SKLabelNode labelNodeWithFontNamed:GAME_FONT];
    tapToRestart.name=@"tapToRestart";
    tapToRestart.position=CGPointMake(0, 20);
    tapToRestart.text=@"Tap to Restart";
    tapToRestart.fontSize=20;
    [self addChild:tapToRestart];
    [self beginPulseAction:tapToRestart];
    
    [hero stop];
    [self runAction:[SKAction playSoundFileNamed:@"OnOver.mp4" waitForCompletion:NO]];
    
    SKLabelNode *gameOverLabel=[SKLabelNode labelNodeWithFontNamed:GAME_FONT];
    gameOverLabel.text=@"GAME OVER";
    gameOverLabel.fontSize=20;
    gameOverLabel.fontColor=[UIColor purpleColor];
    gameOverLabel.position=CGPointMake(0, 75);
    [self addChild:gameOverLabel];
    
    [self updateHighScore];
    
}
-(void)didSimulatePhysics{
    [self centreOnNode:hero];
    [self handlePoints];
    [self handleGenerate];
    [self handleCleanUp];
    
}

-(void)handlePoints{
[world enumerateChildNodesWithName:@"obstacle" usingBlock:^(SKNode *node, BOOL *stop) {
    if (node.position.x<hero.position.x) {
        MripointsLabel *pointsLabel=(MripointsLabel *)[self childNodeWithName:@"pointsLabel"];
        [pointsLabel incrementPoints];
    }
}];
}

-(void)handleGenerate{
    [world enumerateChildNodesWithName:@"obstacle" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x<hero.position.x) {
            node.name=@"obstacle_cancelled";
            [generator generate];
            [self cloudShape];
        }
    }];
}

-(void)handleCleanUp{
    [world enumerateChildNodesWithName:@"ground" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x < hero.position.x - self.frame.size.width/2 - node.frame.size.width/2 ) {
            [node removeFromParent];
           }
    }];
    [world enumerateChildNodesWithName:@"obstacle_cancelled" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x < hero.position.x - self.frame.size.width/2 - node.frame.size.width/2) {
            [node removeFromParent];
        }
    }];
}
-(void)centreOnNode:(SKNode *)node{
    
    CGPoint positionInScene= [self convertPoint:node.position fromNode:node.parent];
    world.position=CGPointMake(world.position.x-positionInScene.x, world.position.y);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    if (!self.isStart) {
        [self start];
    }
    else if (self.isGameOver){
        [self clear];
    }
    else
    [hero jump];
    
}
-(void)beginPulseAction:(SKLabelNode *)node{
    SKAction *disappear=[SKAction fadeAlphaTo:0.0 duration:0.4];
    SKAction *appear=[SKAction fadeAlphaTo:1.0 duration:0.4];
    SKAction *pulse=[SKAction sequence:@[disappear,appear]];
    [node runAction:[SKAction repeatActionForever:pulse]];

    
}
-(void)didBeginContact:(SKPhysicsContact *)contact{
    if ([contact.bodyA.node.name isEqualToString:@"ground"] || [contact.bodyB.node.name isEqualToString:@"ground"] ) {
        [hero land];
    }
    else
    [self gameOver];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}


@end
