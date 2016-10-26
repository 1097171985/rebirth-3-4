//
//  ZGCollectionReachability.m
//  ZGCollection
//
//  Created by WZG on 16/1/23.
//  Copyright © 2016年 WZG. All rights reserved.
//

#import "ZGCollectionReachability.h"

@implementation ZGCollectionReachability

+ (instancetype)sharedReachability{
    static ZGCollectionReachability *reachability = nil;
    static dispatch_once_t onceToken;
    dispatch_once( &onceToken, ^{
        
        reachability = [self sharedManager];
        [reachability setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
           
            switch (status) {
                case AFNetworkReachabilityStatusNotReachable:
                    NSLog(@"网络问题");
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    NSLog(@"已连接上WiFi");
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    NSLog(@"已连接上蜂窝移动网络");
                    break;
                case AFNetworkReachabilityStatusUnknown:
                    NSLog(@"网络状态未知");
                    break;
                default:
                    break;
            }
        }];
        [reachability startMonitoring];
    });
     NSLog(@"?????%@",reachability);
    return reachability;
   
}

@end
