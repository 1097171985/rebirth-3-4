//
//  FourView.h
//  DPLaunchIntro
//
//  Created by WJF on 16/10/24.
//  Copyright © 2016年 yxw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JoinDuopaiBlock)(void);

@interface FourView : UIView
@property (nonatomic, readonly, assign) BOOL animating;

@property (nonatomic, strong) UIButton  *enterBtu;

@property (nonatomic, strong) JoinDuopaiBlock joinDuopaiBlock;

/**
 *  view开始显示，开始动画效果
 */
- (void)viewDidShow;

/**
 *  view已经消失，子视图复原
 */
- (void)viewDidDismiss;



@end
