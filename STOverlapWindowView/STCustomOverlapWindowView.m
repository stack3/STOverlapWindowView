//
//  STCustomOverlapWindowView.m
//  STOverlapWindowView
//
//  Created by EIMEI on 2014/02/12.
//  Copyright (c) 2014年 stack3. All rights reserved.
//

#import "STCustomOverlapWindowView.h"

@interface STCustomOverlapWindowView ()

@property (weak, nonatomic) IBOutlet UIButton *dismissButton;

@end

@implementation STCustomOverlapWindowView

- (id)init
{
    self = [super init];
    if (self) {
        [self customOverlapWindowViewCommonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customOverlapWindowViewCommonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self customOverlapWindowViewCommonInit];
    }
    return self;
}

- (void)customOverlapWindowViewCommonInit
{
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(self.class) bundle:nil];
    NSArray *objects = [nib instantiateWithOwner:self options:nil];
    UIView *view = objects.firstObject;
    view.frame = self.bounds;
    [self addSubview:view];
    
    [_dismissButton addTarget:self action:@selector(didTapDismissButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didTapDismissButton
{
    [self dismissWithAnimated:YES];
}

- (void)showWithAnimated:(BOOL)animated
{
    [super showWithAnimated:animated];
}

@end
