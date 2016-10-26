//
//  WJFCalendarHomeVC.h
//  一些常用的知识点
//
//  Created by boom on 16/7/14.
//  Copyright © 2016年 boom. All rights reserved.
//

#import "CalendarVC.h"


typedef void (^TimeBlock)(NSString *str);


@interface WJFCalendarHomeVC : CalendarVC

@property(nonatomic,strong)TimeBlock block;

@property (nonatomic, strong) NSString *calendartitle;//设置导航栏标题

- (void)setPlaneToDay:(int)day ToDateforString:(NSString *)todate;
@end
