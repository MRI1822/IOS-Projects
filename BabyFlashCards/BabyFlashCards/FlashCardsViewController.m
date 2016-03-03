//
//  FlashCardsViewController.m
//  BabyFlashCards
//
//  Created by Mrigank.
//

#import "FlashCardsViewController.h"
#import "FlashCardCell.h"
#import "ObjectAL.h"

@interface UIImage (Smart)
+(UIImage *) imageNamedSmart:(NSString *)name;
@end

@implementation UIImage (Smart)

+(UIImage *) imageNamedSmart:(NSString *)name {
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
        return [UIImage imageNamed:[NSString stringWithFormat:@"%@@2x.jpg", name]];
    return [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", name]];
}

@end

#define NUM_CARDS 9

@interface FlashCardsViewController ()

@property (nonatomic,strong) IBOutlet UICollectionView* collectionView;

@end

@implementation FlashCardsViewController

BOOL hasPlayedName = NO;

static char* cards[] = {"bear","dolphin","duck","giraffe","gorilla","goose","hippo","horse","koala"};

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*
- (void)loadView {
    self.view = [[UIView alloc]
                 initWithFrame:[[UIScreen mainScreen] bounds]
                 ];
    self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.jpg"]];
    UIImageView* bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamedSmart:@"bg5"]];
    bgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:bgView];
    
    // Create a flow layout for the collection view that scrolls
    // horizontally and has no space between items
    UICollectionViewFlowLayout *flowLayout = [
                                              [UICollectionViewFlowLayout alloc] init
                                              ];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    // Set up the collection view with no scrollbars, paging enabled
    // and the delegate and data source set to this view controller
    self.collectionView = [[UICollectionView alloc]
                           initWithFrame:self.view.frame
                           collectionViewLayout:flowLayout
                           ];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.collectionView];
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.collectionView registerClass:[FlashCardCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"FlashCardCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    hasPlayedName = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return NUM_CARDS;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // Dequeue a prototype cell and set the label to indicate the page
    FlashCardCell *cell = [collectionView
                           dequeueReusableCellWithReuseIdentifier:@"cell"
                           forIndexPath:indexPath
                           ];
    UIImage* card = [UIImage imageNamedSmart:[NSString stringWithCString:cards[indexPath.row] encoding:NSUTF8StringEncoding]];
    cell.flashCardView.image = [self image:card maskedWith:[UIImage imageNamedSmart:@"mask"] andPivot:CGPointMake(0, 0)];
    cell.label.text = [NSString stringWithCString:cards[indexPath.row] encoding:NSUTF8StringEncoding];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.bounds.size;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    static NSInteger previousPage = 0;
    CGFloat pageWidth = scrollView.frame.size.width;
    float fractionalPage = scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    if (previousPage != page) {
        // Page has changed
        // Do your thing!
        previousPage = page;
        NSLog(@"Scrolled To Page %d",page);
        NSString* effectFile = [[NSString stringWithCString:cards[page] encoding:NSUTF8StringEncoding] stringByAppendingString:@".mp3"];
        hasPlayedName = YES;
        [[OALSimpleAudio sharedInstance] playEffect:effectFile volume:1.0f pitch:1.0f pan:0.0f loop:NO];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString* effectFile = nil;
    if (hasPlayedName) {
        effectFile = [[NSString stringWithCString:cards[indexPath.row] encoding:NSUTF8StringEncoding] stringByAppendingString:@"_sound.mp3"];
        hasPlayedName = NO;
    } else {
        effectFile = [[NSString stringWithCString:cards[indexPath.row] encoding:NSUTF8StringEncoding] stringByAppendingString:@".mp3"];
        hasPlayedName = YES;
    }
    
    [[OALSimpleAudio sharedInstance] playEffect:effectFile volume:1.0f pitch:1.0f pan:0.0f loop:NO];
}

- (UIImage *)image:(UIImage *)actual maskedWith:(UIImage *)maskImage andPivot:(CGPoint )pivot {
    
    UIGraphicsBeginImageContext(maskImage.size);
    
    CGImageRef maskRef = maskImage.CGImage;
    
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0.0, maskImage.size.height);
    
    CGContextScaleCTM(UIGraphicsGetCurrentContext(), 1.0, -1.0);
    
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        
                                        CGImageGetHeight(maskRef),
                                        
                                        CGImageGetBitsPerComponent(maskRef),
                                        
                                        CGImageGetBitsPerPixel(maskRef),
                                        
                                        CGImageGetBytesPerRow(maskRef),
                                        
                                        CGImageGetDataProvider(maskRef), NULL, false);
    
    
    
    CGContextClipToMask(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, maskImage.size.width, maskImage.size.height), mask);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, maskImage.size.width, maskImage.size.height), actual.CGImage);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    CGImageRelease(mask);
    
    UIGraphicsEndImageContext();
    
    return img;    
}

@end
