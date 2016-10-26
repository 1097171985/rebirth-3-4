//
//  CardView.h
//  YSLDraggingCardContainerDemo
//
//  Created by yamaguchi on 2015/11/09.
//  Copyright © 2015年 h.yamaguchi. All rights reserved.
//


#import "YSLCardView.h"

@interface CardView : YSLCardView

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel     *titleLabel;
@property (strong, nonatomic) UILabel     *subtitleLabel;

@property(strong, nonatomic)UIView  *totalText;

@property(strong, nonatomic)UILabel *henlabel;


@end
