//
//  HSHomexiaModel.h
//  rebirth
//
//  Created by 侯帅 on 16/7/25.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "YBasemodel.h"

@interface HSHomexiaModel : YBasemodel
@property (nonatomic,strong) NSString *author;
@property (nonatomic,strong) NSString *category;
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *img;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *url;

+(HSHomexiaModel *)HSHomeXiaModel:(NSDictionary *)dic;
@end
