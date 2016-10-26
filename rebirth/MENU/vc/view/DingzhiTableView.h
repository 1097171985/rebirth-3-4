//
//  DingzhiTableView.h
//  rebirth
//
//  Created by boom on 16/7/19.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FoodView.h"

@interface DingzhiTableView : UIView

@property(nonatomic,strong)UIView *selectedView1;

@property(nonatomic,strong)UITableView  *dingzhiView;

-(void)creatDingZhiView;
@end
