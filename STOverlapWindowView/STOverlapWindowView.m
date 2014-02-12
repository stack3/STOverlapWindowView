//
//  STOverlapWindowView.m
//  WindowSamples
//
//  Created by EIMEI on 2014/02/12.
//  Copyright (c) 2014年 stack3. All rights reserved.
//

#import "STOverlapWindowView.h"

static const NSTimeInterval _STAnimationDuration = 0.3f;

@interface STOverlapWindowView ()

@property (weak, nonatomic) UIWindow *parentWindow;

@end

@implementation STOverlapWindowView

- (id)init
{
    CGRect frame = [[UIScreen mainScreen] bounds];
    self = [super initWithFrame:frame];
    if (self) {
        [self windowCommonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self windowCommonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self windowCommonInit];
    }
    return self;
}

- (void)windowCommonInit
{
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    NSNotificationCenter *ntfCenter = [NSNotificationCenter defaultCenter];
    [ntfCenter addObserver:self selector:@selector(handleStatusBarFrameOrOrientationChanged:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    [ntfCenter addObserver:self selector:@selector(handleStatusBarFrameOrOrientationChanged:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)handleStatusBarFrameOrOrientationChanged:(NSNotification *)notification
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGFloat angle = [self angleForOrientation:orientation];
    CGAffineTransform transform = CGAffineTransformMakeRotation(angle);

    if (!CGAffineTransformEqualToTransform(self.transform, transform)) {
        self.transform = transform;
    }
    
    if (!CGRectEqualToRect(self.frame, _parentWindow.bounds)) {
        self.frame = _parentWindow.bounds;
    }
}

- (CGFloat)currentStatusBarHeight
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        return [UIApplication sharedApplication].statusBarFrame.size.width;
    } else {
        return [UIApplication sharedApplication].statusBarFrame.size.height;
    }
}

- (CGFloat)angleForOrientation:(UIInterfaceOrientation)orientation
{
    CGFloat angle;
    
    switch (orientation) {
        case UIInterfaceOrientationPortraitUpsideDown:
            angle = M_PI;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            angle = -M_PI_2;
            break;
        case UIInterfaceOrientationLandscapeRight:
            angle = M_PI_2;
            break;
        default:
            angle = 0.0;
            break;
    }
    
    return angle;
}

- (void)showAnimated:(BOOL)animated
{
    _parentWindow = [[[UIApplication sharedApplication] delegate] window];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.frame = _parentWindow.bounds;
    [_parentWindow addSubview:self];
    
    if (animated) {
        self.alpha = 0;
        [UIView animateWithDuration:_STAnimationDuration animations:^{
            self.alpha = 1.0;
        }];
    }
}

- (void)dismissAnimated:(BOOL)animated
{
    if (animated) {
        self.alpha = 1.0;
        [UIView animateWithDuration:_STAnimationDuration animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    } else {
        [self removeFromSuperview];
    }
}

@end
