//
//  GameData.m
//  HurdleRunner
//
//  Created by Mrigank on 24/01/16.
//  Copyright (c) 2016 Mrigank. All rights reserved.
//

#import "GameData.h"

@implementation GameData

+(id)data{
    
    GameData *data=[GameData new];
    NSString *path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *fileName=@"archive.data";
    data.filePath=[path stringByAppendingString:fileName];
    return data;
    
}
-(void)save{
    NSNumber *highScoreObject=[NSNumber numberWithInteger:self.highScore];
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:highScoreObject];
    [data writeToFile:self.filePath atomically:YES];
    
}
-(void)load{
    NSData *data=[NSData dataWithContentsOfFile:self.filePath];
    NSNumber *highScoreObject=[NSKeyedUnarchiver unarchiveObjectWithData:data];
    self.highScore=highScoreObject.intValue;
    
}


@end
