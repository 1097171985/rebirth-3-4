//
//  HSHomeModel.m
//  rebirth
//
//  Created by 侯帅 on 16/7/21.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSHomeModel.h"

@implementation HSHomeModel
+(HSHomeModel *)HSHomeModel:(NSDictionary *)dic
{
    HSHomeModel *home = [[HSHomeModel alloc] init];
    [home setValuesForKeysWithDictionary:dic];
    return home;
}

@end
