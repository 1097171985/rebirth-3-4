//
//  HSGRZXModel.h
//  rebirth
//
//  Created by 侯帅 on 16/10/13.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "YBasemodel.h"

@interface HSGRZXModel : YBasemodel
@property (nonatomic,strong)NSString *category;
@property (nonatomic,strong)NSString *created_date;
@property (nonatomic,strong)NSString *file_category;
@property (nonatomic,strong)NSString *file_path;
@property (nonatomic,strong)NSString *news_id;
@property (nonatomic,strong)NSString *textContent;
@property (nonatomic,strong) NSMutableArray *file_list;
+(HSGRZXModel *)HSGRZXModel:(NSDictionary *)dic;
@end
