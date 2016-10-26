//
//  LXNavigationInteractiveTransition.m
//  LXPopGesture
//
//  Created by Smile on 16/7/18.
//  Copyright © 2016年 Smile. All rights reserved.
//

#import "LXNavigationInteractiveTransition.h"
#import "LXPopAnimation.h"
#import "UIViewController+LXFullscreenPopGesture.h"

@interface LXNavigationInteractiveTransition () <UINavigationControllerDelegate> {
    __weak UIViewController *_fromViewController;
}

@property (nonatomic, weak) UINavigationController *vc;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@end

@implementation LXNavigationInteractiveTransition

- (instancetype)initWithViewController:(UIViewController *)vc {
    
    self = [super init];
    if (self) {
        self.vc = (UINavigationController *)vc;
        self.vc.delegate = self;
    }
    return self;
}

- (void)handleControllerPop:(UIPanGestureRecognizer *)recognizer {
    /**
     * 稳定进度区间，让它在0.0（未完成）～1.0（已完成）之间
     */
    CGFloat progress = [recognizer translationInView:recognizer.view].x / recognizer.view.bounds.size.width;
    
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.vc popViewControllerAnimated:YES];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self.interactivePopTransition updateInteractiveTransition:progress];
    } else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        if (progress > 0.5) {
            [self.interactivePopTransition finishInteractiveTransition];
            if (_fromViewController && _fromViewController.lx_transitionFinishedBlock) {
                _fromViewController.lx_transitionFinishedBlock();
            }
            
        } else {
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        self.interactivePopTransition = nil;
    }
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPop) {
        _fromViewController = fromVC;
        return [[LXPopAnimation alloc] init];
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    
    if ([animationController isKindOfClass:[LXPopAnimation class]]) {
        return self.interactivePopTransition;
    }
    return nil;
}

@end

