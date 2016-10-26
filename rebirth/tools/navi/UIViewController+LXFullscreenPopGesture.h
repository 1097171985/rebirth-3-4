//
//  UIViewController+LXFullscreenPopGesture.h
//  LXPopGesture
//
//  Created by Smile on 16/7/23.
//  Copyright © 2016年 Smile. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LXTransitionFinishedBlock)(void);

@interface UIViewController (LXFullscreenPopGesture)

@property (nonatomic, assign) BOOL lx_interactivePopDisabled;
@property (nonatomic, copy) LXTransitionFinishedBlock lx_transitionFinishedBlock;

@end
