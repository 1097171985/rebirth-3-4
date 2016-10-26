//
//  CalendarVC.h
//  一些常用的知识点
//
//  Created by boom on 16/7/14.
//  Copyright © 2016年 boom. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "CalendarLogic.h"

//回掉代码块
typedef void (^CalendarBlock)(CalendarDayModel *model);

@interface CalendarVC : UIViewController

@property(nonatomic,strong)UILabel  *timeLable;

@property(nonatomic ,strong) UICollectionView* collectionView;//网格视图

@property(nonatomic ,strong) NSMutableArray *calendarMonth;//每个月份的中的daymodel容器数组

@property(nonatomic ,strong) CalendarLogic *Logic;

@property (nonatomic, copy) CalendarBlock calendarblock;//回调

@property(nonatomic,strong)NSString  *info_id;

@property(nonatomic,strong)NSString  *item_id;

@property(nonatomic,strong)NSMutableString  *totalstr;

@end
