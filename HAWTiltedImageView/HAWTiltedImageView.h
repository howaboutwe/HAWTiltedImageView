//
//  HAWTiltedImageView.h
//  TiledImageViewExample
//
//  Created by James on 2/7/14.
//  Copyright (c) 2014 How About We. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface HAWTiltedImageView : UIView
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) CMMotionManager *motionManager;
@end
