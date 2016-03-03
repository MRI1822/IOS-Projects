//
//  FlashCardCell.h
//  BabyFlashCards
//
//  Created by Mrigank.
//

#import <UIKit/UIKit.h>

@interface FlashCardCell : UICollectionViewCell {
}

@property (nonatomic,strong) IBOutlet UIImageView* flashCardView;
@property (nonatomic,strong) IBOutlet UILabel* label;

@end
