//
//  HSGRZXModel.m
//  rebirth
//
//  Created by 侯帅 on 16/10/13.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSGRZXModel.h"

@implementation HSGRZXModel
+(HSGRZXModel *)HSGRZXModel:(NSDictionary *)dic{
    HSGRZXModel *hsgr = [[HSGRZXModel alloc] init];
    [hsgr setValuesForKeysWithDictionary:dic];
    return hsgr;
 }
@end
