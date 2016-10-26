//
//  WJFTimerCell.h
//  一些常用的知识点
//
//  Created by boom on 16/7/18.
//  Copyright © 2016年 boom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJFTimerCell : UITableViewCell

@property(nonatomic,strong)UILabel   *shuxian;

@property(nonatomic,strong)UIView *timerView;

@property(nonatomic,strong)UIView  *neirongView;

@property(nonatomic,strong)UIImageView *tubiao;

@property(nonatomic,strong)UILabel  *mudi;

@property(nonatomic,strong)UILabel  *timeLabel;


@property(nonatomic,strong)UIImageView *neirongImage;

@property(nonatomic,strong)UILabel  *title;

@property(nonatomic,strong)UILabel  *subTitle;

@property(nonatomic,strong)UIButton  *goButton;

@property(nonatomic,strong)UIView *myview;

-(float)getCellHeight;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withBeginTime:(NSString *)beignTime;

@end
