//
//  UIViewController+LXFullscreenPopGesture.m
//  LXPopGesture
//
//  Created by Smile on 16/7/23.
//  Copyright © 2016年 Smile. All rights reserved.
//

#import "UIViewController+LXFullscreenPopGesture.h"
#import <objc/runtime.h>

@implementation UIViewController (PJFullscreenPopGesture)

- (BOOL)lx_interactivePopDisabled {
    
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setLx_interactivePopDisabled:(BOOL)disabled {
    
    objc_setAssociatedObject(self,
                             @selector(lx_interactivePopDisabled),
                             @(disabled),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (LXTransitionFinishedBlock)lx_transitionFinishedBlock{
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setLx_transitionFinishedBlock:(LXTransitionFinishedBlock)transitionFinishedBlock {
    
    objc_setAssociatedObject(self,
                             @selector(lx_transitionFinishedBlock),
                             transitionFinishedBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
