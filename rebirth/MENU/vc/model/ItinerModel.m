//
//  ItinerModel.m
//  rebirth
//
//  Created by boom on 16/7/30.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "ItinerModel.h"

@implementation ItinerModel

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
