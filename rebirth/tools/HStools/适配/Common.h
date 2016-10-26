//
//  Common.h
//  YGBSocialProj
//
//  Created by 张朵 on 14-4-28.
//  Copyright (c) 2014年 张朵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//extern int iOSPlatform;
extern CGFloat kScreenWidth;
extern CGFloat kScreenHeight;
extern CGFloat kStatusBarHeight;
extern CGFloat kTabBarHeight;
extern CGFloat NAV_BAR_HEIGHT;
//extern NSString *NAV_BG_IMAGE;

@interface Common : NSObject

//判断版本
+(void)initGlobalValue;

//判读字符串
+(NSString*)checkStrValue:(NSString*)strValue;


//警告弹框
+ (void) warningAlert:(NSString *)str;

//提示弹框
+ (void) tipAlert:(NSString *)str;


@end
