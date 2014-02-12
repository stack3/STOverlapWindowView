//
//  STOverlapWindowView.h
//  WindowSamples
//
//  Created by EIMEI on 2014/02/12.
//  Copyright (c) 2014年 stack3. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * @brief The view overlaps window.
 *
 * DO NOT use addSubview to add this view. Please use showAnimated method.
 */
@interface STOverlapWindowView : UIView

/**
 * Show the view.
 * The view will be added on window.
 */
- (void)showAnimated:(BOOL)animated;
/**
 * Dismiss the view.
 */
- (void)dismissAnimated:(BOOL)animated;

@end
