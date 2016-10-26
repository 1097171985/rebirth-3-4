//
//  CalendarLogic.h
//  一些常用的知识点
//
//  Created by boom on 16/7/14.
//  Copyright © 2016年 boom. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CalendarDayModel.h"
#import "NSDate+WJFCalendarLogic.h"

@interface CalendarLogic : NSObject

- (NSMutableArray *)reloadCalendarView:(NSDate *)date  selectDate:(NSDate *)date1 needDays:(int)days_number;
- (void)selectLogic:(CalendarDayModel *)day;
@end

