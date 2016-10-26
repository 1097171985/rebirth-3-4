//
//  FoodModel.h
//  rebirth
//
//  Created by boom on 16/7/22.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodModel : NSObject

@property(nonatomic,strong)NSString *info_id;

@property(nonatomic,strong)NSString *head_img;

@property(nonatomic,strong)NSString *title;

@property(nonatomic,strong)NSString *defined;

@property(nonatomic,strong)NSString *item_id;

@property(nonatomic,strong)NSString *price;

@property(nonatomic,strong)NSString *adv;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)tgWithDict:(NSDictionary *)dict;
@end
