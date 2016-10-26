//
//  HSHomexiaModel.m
//  rebirth
//
//  Created by 侯帅 on 16/7/25.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSHomexiaModel.h"

@implementation HSHomexiaModel
+(HSHomexiaModel *)HSHomeXiaModel:(NSDictionary *)dic
{
    HSHomexiaModel *home = [[HSHomexiaModel alloc] init];
    [home setValuesForKeysWithDictionary:dic];
    return home;
}

@end
