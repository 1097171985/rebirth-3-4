//
//  LeftMenuView.h
//  rebirth
//
//  Created by 侯帅 on 16/7/18.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeMenuViewDelegate <NSObject>


-(void)LeftMenuViewClick:(NSInteger)tag;

@end



@interface LeftMenuView : UIView
@property (nonatomic,weak)id<HomeMenuViewDelegate> customDelegate;
@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) UILabel *NameLabel;
@property (nonatomic,strong) UIButton *NameBtn;
@property (nonatomic,strong) UIImageView *arrow;
@end
