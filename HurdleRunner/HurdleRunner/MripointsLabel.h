//
//  MripointsLabel.h
//  HurdleRunner
//
//  Created by Mrigank on 21/01/16.
//  Copyright (c) 2016 Mrigank. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MripointsLabel : SKLabelNode

@property int number;
+(id)pointsLabelWithFormat:(NSString *)fontName;
-(void)incrementPoints;
-(void)setPoints:(int)points;
-(void)reset;




@end
