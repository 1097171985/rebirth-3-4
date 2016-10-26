//
//  HSHomeModel.h
//  rebirth
//
//  Created by 侯帅 on 16/7/21.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "YBasemodel.h"


@interface HSHomeModel : YBasemodel
@property (nonatomic,strong) NSString *adv;
@property (nonatomic,strong) NSString *img_url;
@property (nonatomic,strong) NSString *info_id;
@property (nonatomic,strong) NSString *position;
@property (nonatomic,strong) NSString *title;
+(HSHomeModel *)HSHomeModel:(NSDictionary *)dic;
@end
