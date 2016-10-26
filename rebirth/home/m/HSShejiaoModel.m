//
//  HSShejiaoModel.m
//  rebirth
//
//  Created by 侯帅 on 16/9/27.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSShejiaoModel.h"

@implementation HSShejiaoModel
+(HSShejiaoModel *)HSShejiaoModel:(NSDictionary *)dic{
    HSShejiaoModel *home = [[HSShejiaoModel alloc] init];
    [home setValuesForKeysWithDictionary:dic];
    return home;
}
@end
