//
//  LXPopAnimation.m
//  LXPopGesture
//
//  Created by Smile on 16/7/18.
//  Copyright © 2016年 Smile. All rights reserved.
//

#import "LXPopAnimation.h"
#import "UIView+Extension.h"

@interface LXPopAnimation ()

@property (nonatomic, strong) id <UIViewControllerContextTransitioning> transitionContext;

@end

@implementation LXPopAnimation

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    /**
     *  这个方法返回动画执行的时间
     */
    return 0.25;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
        
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    /**
     *  iOS9之后需要手动去转换横竖屏
     */
    if (fromViewController.view.width != toViewController.view.width) {
        
        [toViewController.view setSize:CGSizeMake(toViewController.view.height, toViewController.view.width)];
    }
    
    /**
     *  转场动画是两个控制器视图时间的动画，需要一个containerView来作为一个“舞台”，让动画执行。
     */
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    /**
     *  执行动画，我们让fromVC的视图移动到屏幕最右侧
     */
    [UIView animateWithDuration:duration animations:^{
        
        fromViewController.view.transform = CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width, 0);
    }completion:^(BOOL finished) {
        /**
         *  防止fromViewController为单例
         */
        fromViewController.view.transform = CGAffineTransformIdentity;
        /**
         *  当你的动画执行完成，这个方法必须要调用，否则系统会认为你的其余任何操作都在动画执行过程中。
         */
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (void)animationDidStop:(CATransition *)anim finished:(BOOL)flag {
    
    [_transitionContext completeTransition:!_transitionContext.transitionWasCancelled];
}

@end

