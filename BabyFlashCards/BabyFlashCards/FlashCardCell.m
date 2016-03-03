//
//  FlashCardCell.m
//  BabyFlashCards
//
//  Created by Mrigank.
//

#import "FlashCardCell.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation FlashCardCell

- (id)initWithFrame:(CGRect)frame
 {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void) awakeFromNib {
    [super awakeFromNib];
    [self.label setFont:[UIFont fontWithName:@"DKMamaBear" size:70.0f]];
    self.label.textColor = [UIColor whiteColor];
    self.label.shadowColor = [UIColor darkGrayColor];
    self.label.shadowOffset = CGSizeMake(1, 1);
    
}

@end
