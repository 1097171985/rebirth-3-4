//
//  FoodModel.m
//  rebirth
//
//  Created by boom on 16/7/22.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "FoodModel.h"

@implementation FoodModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+(instancetype)tgWithDict:(NSDictionary *)dict{
    
    return [[self alloc]initWithDict:dict];
}


@end
