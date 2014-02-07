//
//  HAWViewController.m
//  TiledImageViewExample
//
//  Created by James on 2/7/14.
//  Copyright (c) 2014 How About We. All rights reserved.
//

#import "HAWViewController.h"
#import "HAWTiltedImageView.h"
#import <NSLayoutConstraint+HAWHelpers/NSLayoutConstraint+HAWHelpers.h>

@interface HAWViewController ()
@property (strong, nonatomic) HAWTiltedImageView *imageView;
@end

@implementation HAWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.imageView = [[HAWTiltedImageView alloc] initWithMotionManager:<#(CMMotionManager *)#>];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.imageView];
    
    [NSLayoutConstraint extentOfChild:self.imageView toExtentOfParent:self.view];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.imageView.image = [UIImage imageNamed:@"NJ"];
}

@end
