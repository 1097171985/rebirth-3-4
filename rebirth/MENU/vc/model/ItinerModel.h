//
//  ItinerModel.h
//  rebirth
//
//  Created by boom on 16/7/30.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItinerModel : NSObject

@property(nonatomic,strong)NSString *oid;//意向金订单号

@property(nonatomic,strong)NSString *date;

@property(nonatomic,strong)NSString *status;

@property(nonatomic,strong)NSString *dingjin;

@property(nonatomic,strong)NSString *real_price;

@property(nonatomic,strong)NSArray *list;

@property(nonatomic,strong)NSString *repay_id;//仅全款订单号

+(instancetype)tgWithDict:(NSDictionary *)dict;
@end
