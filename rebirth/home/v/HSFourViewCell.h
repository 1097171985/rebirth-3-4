//
//  HSFourViewCell.h
//  rebirth
//
//  Created by 侯帅 on 16/7/18.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSHomeModel.h"
@interface HSFourViewCell : UITableViewCell
@property (nonatomic,strong) HSHomeModel *homeModel;
@property (nonatomic,strong) UIButton *firstBtn;
@property (nonatomic,strong) UIButton * secondBtn;
-(void)setmodel:(HSHomeModel *)model;
-(void)setmodell:(HSHomeModel *)model;
@end
