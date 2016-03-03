//
//  MriViewController.m
//  HurdleRunner
//
//  Created by Mrigank on 20/01/16.
//  Copyright (c) 2016 Mrigank. All rights reserved.
//

#import "MriViewController.h"
#import "MriMyScene.h"

@implementation MriViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [MriMyScene sceneWithSize:CGSizeMake(skView.frame.size.width, skView.frame.size.height)];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    NSError *error;
    NSURL * backgroundMusicURL = [[NSBundle mainBundle] URLForResource:@"OnBackground" withExtension:@"mp4"];
    self.bkMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    self.bkMusic.numberOfLoops = -1;
    [self.bkMusic prepareToPlay];
    [self.bkMusic play];
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
