//
//  STOverlapWindowView.m
//  STOverlapWindowView
//
//  Created by EIMEI on 2014/02/12.
//  Copyright (c) 2014年 stack3. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
    UIApplication *app = [UIApplication sharedApplication];
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        return app.statusBarFrame.size.width;
    } else {
        return app.statusBarFrame.size.height;
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

- (void)showWithAnimated:(BOOL)animated
{
    _parentWindow = [[UIApplication sharedApplication] keyWindow];
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

- (void)dismissWithAnimated:(BOOL)animated
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
