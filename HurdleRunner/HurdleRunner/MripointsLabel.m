//
//  MripointsLabel.m
//  HurdleRunner
//
//  Created by Mrigank on 21/01/16.
//  Copyright (c) 2016 Mrigank. All rights reserved.
//

#import "MripointsLabel.h"

@implementation MripointsLabel
+(id)pointsLabelWithFormat:(NSString *)fontName{
    MripointsLabel *pointsLabel=[MripointsLabel labelNodeWithFontNamed:fontName];
    pointsLabel.text=@"0";
    pointsLabel.number=0;
    return pointsLabel;
}

-(void)incrementPoints{
    self.number++;
    self.text=[NSString stringWithFormat:@"%i",self.number];
    
}
-(void)setPoints:(int)points{
    self.number=points;
    self.text=[NSString stringWithFormat:@"%i",self.number];
    }
-(void)reset{
    self.number=0;
    self.text=@"0";
}

@end

