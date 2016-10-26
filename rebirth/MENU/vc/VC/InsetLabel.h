//
//  InsetLabel.h
//  rebirth
//
//  Created by boom on 16/8/23.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InsetLabel : UILabel

//用于设置Label的内边距
@property(nonatomic) UIEdgeInsets neiinsets;
//初始化方法一
-(id) initWithFrame:(CGRect)frame andInsets: (UIEdgeInsets) neiinsets;
//初始化方法二
-(id) initWithInsets: (UIEdgeInsets) neiinsets;

@end
