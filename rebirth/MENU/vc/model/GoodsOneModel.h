//
//  GoodsOneModel.h
//  rebirth
//
//  Created by boom on 16/7/22.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsOneModel : NSObject

//list名称
//类型 实例值
//参数描述 item_id  string 3  商品ID
//        info_id  string 3  详情ID （只有车类商品才有此返回值）
//        title   string 大酒店 商品名称
//        img_url  string http://www.rempeach.com/rebirth/Public/image/itemImage/item_hotel.png  图片链接
//        info     string 可大了  商品描述
//        price   string  100000 价格 以分为单位
//        defined  string 五星酒店  自定义描述，（根据情况添加）
//        busy_created  string 2016-07-22 08:12:12 开始占用时间 （如果没有为null）
//        busy_end   string    2016-07-23 08:12:12  结束占用时间 （如果没有为null）
@property(nonatomic,strong)NSString *item_id;

@property(nonatomic,strong)NSString *info_id;

@property(nonatomic,strong)NSString *title;

@property(nonatomic,strong)NSString *img_url;

@property(nonatomic,strong)NSString *info;

@property(nonatomic,strong)NSString *price;

@property(nonatomic,strong)NSString *defined;

@property(nonatomic,strong)NSString *busy_created;

@property(nonatomic,strong)NSString *busy_end;


-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)tgWithDict:(NSDictionary *)dict;

@end
