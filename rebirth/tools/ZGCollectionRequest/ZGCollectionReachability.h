//
//  ZGCollectionReachability.h
//  ZGCollection
//
//  Created by WZG on 16/1/23.
//  Copyright © 2016年 WZG. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface ZGCollectionReachability : AFNetworkReachabilityManager

+ (instancetype)sharedReachability;

@end
