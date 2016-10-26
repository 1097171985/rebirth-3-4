//
//  LXNavigationInteractiveTransition.h
//  LXPopGesture
//
//  Created by Smile on 16/7/18.
//  Copyright © 2016年 Smile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LXNavigationInteractiveTransition : NSObject

- (instancetype)initWithViewController:(UIViewController *)vc;
- (void)handleControllerPop:(UIPanGestureRecognizer *)recognizer;
- (UIPercentDrivenInteractiveTransition *)interactivePopTransition;

@end
