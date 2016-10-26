//
//  LoginState.m
//  rebirth
//
//  Created by boom on 16/8/23.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "LoginState.h"

@implementation LoginState

static LoginState* _instance = nil;

+(instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _instance = [[super allocWithZone:NULL] init];
       
        [LCProgressHUD showStatus:LCProgressHUDStatusInfo text:@"您的账号异常,已经在其他设备登录,已退出你的登录状态"];
        
        [USER_DEFAULT removeObjectForKey:@"id"];
        [USER_DEFAULT removeObjectForKey:@"token"];
        
    });
    return _instance;
}

+(id)allocWithZone:(struct _NSZone *)zone
{
    return [LoginState shareInstance];
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [LoginState shareInstance];
}


@end
