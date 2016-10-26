//
//  LXNavigationController.m
//  LXPopGesture
//
//  Created by Smile on 16/7/18.
//  Copyright © 2016年 Smile. All rights reserved.
//

#import "LXNavigationController.h"
#import "LXNavigationInteractiveTransition.h"
#import "UIViewController+LXFullscreenPopGesture.h"

static const CGFloat maxAllowedInitialDistance = 0.0;

@interface LXNavigationController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *popRecognizer;
@property (nonatomic, strong) LXNavigationInteractiveTransition *navTransition;

@end

@implementation LXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    gesture.enabled = NO;
    
    UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] init];
    popRecognizer.delegate = self;
    popRecognizer.maximumNumberOfTouches = 1;
    [gesture.view addGestureRecognizer:popRecognizer];
    
    self.navTransition = [[LXNavigationInteractiveTransition alloc] initWithViewController:self];
    [popRecognizer addTarget:self.navTransition action:@selector(handleControllerPop:)];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    
    // Ignore when no view controller is pushed into the navigation stack.
    if (self.viewControllers.count <= 1) {
        return NO;
    }
    
    // Ignore when the beginning location is beyond max allowed initial distance to left edge.
    CGPoint beginningLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
    if (maxAllowedInitialDistance > 0 && beginningLocation.x > maxAllowedInitialDistance) {
        return NO;
    }
    
    // Ignore pan gesture when the navigation controller is currently in transition.
    if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    
    // Prevent calling the handler when the gesture begins in an opposite direction.
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    
    // When the active view controller not allow interactive pop.
    UIViewController *topViewController = self.viewControllers.lastObject;
    if (topViewController.lx_interactivePopDisabled) {
        return NO;
    }
    
    return YES;
}

@end

