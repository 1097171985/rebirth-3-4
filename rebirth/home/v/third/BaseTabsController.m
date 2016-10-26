//
//  BaseTabsController.m
//  Shuangdaojia_Customer
//
//  Created by Yeonluu on 15/9/18.
//  Copyright (c) 2015年 DaoChan. All rights reserved.
//

#import "BaseTabsController.h"
#import "HMSegmentedControl.h"
#import "UIView+Frame.h"

@interface BaseTabsController ()
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@property (nonatomic, strong) NSArray *viewControllers;
@end

@implementation BaseTabsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.clipsToBounds = YES;
    
    self.contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    
    
    self.contentView.y = SEGMENT_HEIGHT;

    
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, SEGMENT_HEIGHT, SCREEN_WIDTH, 1)];
    separator.backgroundColor = UIColorMake(204, 204, 204);
    
    [self.view addSubview:self.contentView];
//    加到导航
    [self.navView addSubview:self.segmentedControl];
    [self.view addSubview:separator];
}

- (void)setViewControllers:(NSArray *)controllers sectionTitles:(NSArray *)titles height:(CGFloat)height
{
    _viewControllers = controllers;
    self.contentView.height = height;
    self.contentView.width = SCREEN_WIDTH*controllers.count;
    if (_selectedIndex < controllers.count) {
        self.contentView.x = -SCREEN_WIDTH*_selectedIndex;
        self.segmentedControl.selectedSegmentIndex = _selectedIndex;
    }
    self.segmentedControl.sectionTitles = titles;
    [controllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL *stop) {
        viewController.view.x = idx * SCREEN_WIDTH;
        viewController.view.height = height;
        [self.contentView addSubview:viewController.view];
        [self addChildViewController:viewController];
    }];
}


- (void)segmentedValueChangedAction:(HMSegmentedControl *)segCtrl
{
    [self.view endEditing:YES];
    _selectedIndex = segCtrl.selectedSegmentIndex;
    [UIView animateWithDuration:0.2 animations:^{
        self.contentView.x = -segCtrl.selectedSegmentIndex * SCREEN_WIDTH;
    }];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    if (selectedIndex >= self.viewControllers.count) {
        return;
    }
    self.segmentedControl.selectedSegmentIndex = selectedIndex;
    [UIView animateWithDuration:0.2 animations:^{
        self.contentView.x = -selectedIndex * SCREEN_WIDTH;
    }];
}

- (HMSegmentedControl *)segmentedControl
{
    //分段选择框大小位置
    if (!_segmentedControl) {
        _segmentedControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH, SEGMENT_HEIGHT)];
        _segmentedControl.selectionIndicatorWidth = SCREEN_WIDTH/2-20;
        [_segmentedControl addTarget:self action:@selector(segmentedValueChangedAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}


@end
