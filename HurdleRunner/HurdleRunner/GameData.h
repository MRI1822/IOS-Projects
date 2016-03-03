//
//  GameData.h
//  HurdleRunner
//
//  Created by Mrigank on 24/01/16.
//  Copyright (c) 2016 Mrigank. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameData : NSObject

@property int highScore;
@property NSString *filePath;

+(id)data;
-(void)save;
-(void)load;
@end
