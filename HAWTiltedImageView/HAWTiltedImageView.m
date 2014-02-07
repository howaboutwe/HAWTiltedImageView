//
//  HAWTiltedImageView.m
//  TiledImageViewExample
//
//  Created by James on 2/7/14.
//  Copyright (c) 2014 How About We. All rights reserved.
//

#import "HAWTiltedImageView.h"
#import <NSLayoutConstraint+HAWHelpers/NSLayoutConstraint+HAWHelpers.h>

@interface HAWTiltedImageView ()
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation HAWTiltedImageView

- (id)init
{
    self =  [super init];
    if (!self)
        return self;
    
    self.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.25];
    
    _scrollView = ({
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        scrollView.bounces = NO;
        scrollView.userInteractionEnabled = YES;//Make NO
        [self addSubview:scrollView];
        [NSLayoutConstraint extentOfChild:scrollView toExtentOfParent:self];
        
        scrollView;
    });
    
    _imageView = ({
        UIImageView *imageView = [[UIImageView alloc] init];
        
        [self.scrollView addSubview:imageView];
        imageView;
    });
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.imageView sizeToFit];
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.imageView.bounds), CGRectGetHeight(self.imageView.bounds));
}

- (void)setImage:(UIImage *)image {
    _image = image;
    
    self.imageView.image = image;
}

- (CMMotionManager *)motionManager {
    if (_motionManager)
        return _motionManager;
    
    _motionManager = ({
        CMMotionManager *manager = [[CMMotionManager alloc] init];
        
        manager;
    });
    
    return _motionManager;
}

@end
