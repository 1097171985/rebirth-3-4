//
//  WJFCalendarCell.h
//  一些常用的知识点
//
//  Created by boom on 16/7/14.
//  Copyright © 2016年 boom. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "CalendarDayModel.h"


@interface WJFCalendarCell : UICollectionViewCell
{
    UILabel *day_lab;//今天的日期或者是节日
    UILabel *day_title;//显示标签
    UIImageView *imgview;//选中时的图片
}

@property(nonatomic , strong)CalendarDayModel *model;

@property(nonatomic,strong) NSMutableArray *userCellDateArray;

-(void)compentDataisHere:(CalendarDayModel *)model dateArray:(NSMutableArray *)userDateArray;

@end

