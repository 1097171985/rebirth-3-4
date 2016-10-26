//
//  WJFOutlineLabel.h
//  rebirth
//
//  Created by boom on 16/8/5.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJFOutlineLabel : UILabel

/** 描多粗的边*/

@property (nonatomic, assign) NSInteger outLineWidth;

/** 外轮颜色*/

@property (nonatomic, strong) UIColor *outLinetextColor;

/** 里面字体默认颜色*/

@property (nonatomic, strong) UIColor *labelTextColor;


@end
