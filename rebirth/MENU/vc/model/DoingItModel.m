//
//  DoingItModel.m
//  rebirth
//
//  Created by boom on 16/8/2.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "DoingItModel.h"

@implementation DoingItModel

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
