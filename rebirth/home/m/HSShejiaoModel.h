//
//  HSShejiaoModel.h
//  rebirth
//
//  Created by 侯帅 on 16/9/27.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "YBasemodel.h"

@interface HSShejiaoModel : YBasemodel
@property (nonatomic,strong) NSString *category;
@property (nonatomic,strong) NSString *date;
@property (nonatomic,strong) NSString *news_id;
@property (nonatomic,strong) NSString *nick;
@property (nonatomic,strong) NSString *review_num;
@property (nonatomic,strong) NSString *text;
@property (nonatomic,strong) NSString *user_id;
@property (nonatomic,strong) NSString *head_img;
@property (nonatomic,strong) NSString *file_path;
@property (nonatomic,strong) NSMutableArray *file_list;
+(HSShejiaoModel *)HSShejiaoModel:(NSDictionary *)dic;
@end
