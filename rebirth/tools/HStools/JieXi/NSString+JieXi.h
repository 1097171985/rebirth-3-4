//
//  NSString+JieXi.h
//  TuCaoApp
//
//  Created by 张利坤 on 15/1/8.
//  Copyright (c) 2015年 张利坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (JieXi)
+(NSString *)requestJieXiRequestStr:(NSString *)requestStr;
+(UIColor *)colorWithHexString:(NSString *)color;
+(CGSize )titleHeightFont:(CGFloat )font kuandu:(NSInteger )kuandu text:(NSString *)text;

@end
