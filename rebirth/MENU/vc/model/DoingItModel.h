//
//  DoingItModel.h
//  rebirth
//
//  Created by boom on 16/8/2.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoingItModel : NSObject

@property(nonatomic,strong)NSString *info_id;

@property(nonatomic,strong)NSString *head_img;

@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *adv;

@property(nonatomic,strong)NSString *begin;

@property(nonatomic,strong)NSString *title;

@property(nonatomic,strong)NSString *coordinate;

@property(nonatomic,strong)NSString *address;

+(instancetype)tgWithDict:(NSDictionary *)dict;
@end
