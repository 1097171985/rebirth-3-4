//
//  HSNetworkHelper.h
//  rebirth
//
//  Created by 侯帅 on 16/7/21.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSNetworkHelper : NSObject
+ (NSDictionary * _Nonnull)lf_requestParamsWithNameList:(NSArray * _Nonnull)nameList param:(NSString * _Nonnull)param, ...;
@end
