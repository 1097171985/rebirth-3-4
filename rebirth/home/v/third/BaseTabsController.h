//
//  BaseTabsController.h
//  Shuangdaojia_Customer
//
//  Created by Yeonluu on 15/9/18.
//  Copyright (c) 2015年 DaoChan. All rights reserved.
//

//#import "BaseViewController.h"
//高度
#define SEGMENT_HEIGHT 40

@class HMSegmentedControl;
@interface BaseTabsController : UIViewController

/**
 *  必须实现
 *
 *  @param controllers 控制器数组
 *  @param titles      标题数组
 *  @param height      视图高度
 */
- (void)setViewControllers:(NSArray *)controllers sectionTitles:(NSArray *)titles height:(CGFloat)height;

- (void)segmentedValueChangedAction:(HMSegmentedControl *)segCtrl;


@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) UIView *navView;


@end
