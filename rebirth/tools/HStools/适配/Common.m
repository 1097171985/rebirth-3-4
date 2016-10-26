//
//  Common.m
//  YGBSocialProj
//
//  Created by 张朵 on 14-4-28.
//  Copyright (c) 2014年 张朵. All rights reserved.
//

#import "Common.h"

//int iOSPlatform	= 7;
CGFloat kScreenWidth	= 0.0;
CGFloat kScreenHeight = 0.0;
CGFloat kStatusBarHeight = 0.0f;
CGFloat kTabBarHeight = 49.0f;
CGFloat NAV_BAR_HEIGHT = 44.0;
//NSString *NAV_BG_IMAGE = @"nav_ios7";

@implementation Common

+(void)initGlobalValue
{
    if(iPhone6plus)
    {
        //equal or higher than iOS7
        //        iOSPlatform	= 8;
        kScreenWidth = [[UIScreen mainScreen] bounds].size.width;
        kScreenHeight = [[UIScreen mainScreen] bounds].size.height;
        kStatusBarHeight = 27.0f;
        NAV_BAR_HEIGHT = 66.0;
//        NAV_BG_IMAGE = @"nav";
        kTabBarHeight = 53.0f;
    }
    else
    {
        //        iOSPlatform	= 7;
        kScreenWidth = [[UIScreen mainScreen] bounds].size.width;
        kScreenHeight = [[UIScreen mainScreen] bounds].size.height;
        kStatusBarHeight = 20.0f;
        NAV_BAR_HEIGHT = 64.0;
//        NAV_BG_IMAGE = @"nav";
        kTabBarHeight = 49.0f;
    }
}
+(NSString*)checkStrValue:(NSString*)strValue
{
    if (strValue == nil || (id) strValue == [NSNull null])
    {
        strValue = @"";
    }
    return strValue;
}

+ (void) warningAlert:(NSString *)str
{
    UIAlertView *endAlert =[[UIAlertView alloc] initWithTitle:@"警告"  message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [endAlert show];
    
}

+ (void) tipAlert:(NSString *)str
{
    UIAlertView *endAlert =[[UIAlertView alloc] initWithTitle:@"提示"  message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [endAlert show];
}



@end
