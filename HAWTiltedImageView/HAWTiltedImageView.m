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

- (id)init {
    return [self initWithMotionManager:nil];
}

- (id)initWithMotionManager:(CMMotionManager *)manager {
    self = [super init];
    if (!self)
        return self;
    
    self.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.25];
    
    _scrollView = ({
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        scrollView.bounces = NO;
        scrollView.userInteractionEnabled = NO;
        [self addSubview:scrollView];
        [NSLayoutConstraint extentOfChild:scrollView toExtentOfParent:self];
        
        scrollView;
    });
    
    _imageView = ({
        UIImageView *imageView = [[UIImageView alloc] init];
        
        [self.scrollView addSubview:imageView];
        imageView;
    });
    
    _motionManager = manager;
    if (_motionManager == nil) {
        _motionManager = ({
            CMMotionManager *manager = [[CMMotionManager alloc] init];
            [manager setGyroUpdateInterval:1.0/60.0];
            
            manager;
        });
    }
    
    return self;
}

- (void)dealloc {
    [_motionManager stopGyroUpdates];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.imageView sizeToFit];
    CGRect r = self.imageView.frame;
    
    CGFloat aspectRatio = CGRectGetHeight(r) / CGRectGetWidth(r);
    
    r.size.height = CGRectGetHeight(self.scrollView.bounds);
    r.size.width = r.size.height / aspectRatio;
    
    self.imageView.frame = r;
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(r), CGRectGetHeight(r));
    [self startGyroUpdates];
}

- (void)startGyroUpdates {
    CGFloat motionMovingRate = 4;
    
    int maxXOffset = self.scrollView.contentSize.width - self.scrollView.frame.size.width;
    int minXOffset = 0;
    
    self.scrollView.contentOffset = CGPointMake((self.scrollView.contentSize.width - self.frame.size.width) / 2, 0);
    
    __weak typeof(self) weakSelf = self;
    [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue]
                                    withHandler:^(CMGyroData *gyroData, NSError *error) {
                                        if (fabs(gyroData.rotationRate.y) < 0.1)
                                            return;
                                        
                                        CGFloat targetX = weakSelf.scrollView.contentOffset.x - gyroData.rotationRate.y * motionMovingRate;
                                        if (targetX > maxXOffset)
                                            targetX = maxXOffset;
                                        else if (targetX < minXOffset)
                                            targetX = minXOffset;
                                        
                                        weakSelf.scrollView.contentOffset = CGPointMake(targetX, 0);
                                    }];
}

#pragma mark - Setters

- (void)setImage:(UIImage *)image {
    _image = image;
    
    self.imageView.image = image;
}

- (void)setMotionManager:(CMMotionManager *)motionManager {
    if (_motionManager)
        [_motionManager stopGyroUpdates];
    
    _motionManager = motionManager;
    
    [self startGyroUpdates];
}

@end
