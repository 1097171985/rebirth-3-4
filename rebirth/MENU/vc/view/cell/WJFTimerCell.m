//
//  WJFTimerCell.m
//  一些常用的知识点
//
//  Created by boom on 16/7/18.
//  Copyright © 2016年 boom. All rights reserved.
//

#import "WJFTimerCell.h"



@implementation WJFTimerCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withBeginTime:(NSString *)beignTime{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        
         self.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
        
        [self createView];
        
        NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
        //  [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        [inputFormatter setDateFormat:@"yyyy/MM/dd hh:mm:ss"];
        
        
        NSDate *beginDate = [inputFormatter dateFromString:beignTime];
        
        int  bijiao =    [self compareOneDay:[NSDate date] withAnotherDay:beginDate];
        
        if (bijiao == 1) {
            
            if (self.myview) {
                
                [self.myview removeFromSuperview];
                
                self.myview = nil;
                
            }
            //cell.backgroundColor = [UIColor redColor];
            self.myview =[[UIView alloc]init];
            self.myview.backgroundColor = [[NSString colorWithHexString:@"f2f2f2"]colorWithAlphaComponent:0.4];
            
            [self bringSubviewToFront: self.myview];
            
            [self addSubview: self.myview];
            
            [self.myview mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(self.mas_top).with.offset(0);
                make.bottom.equalTo(self.mas_bottom).with.offset(0);
                make.left.equalTo(self.mas_left).with.offset(0);
                make.right.equalTo(self.mas_right).with.offset(0);
            }];
            
            self.goButton.hidden = YES;
        }else{
            
            
        }

        
        
        
    }
    return self;
    
}


-(void)createView{
    
    _shuxian = [[UILabel alloc]initWithFrame:CGRectMake(20, 0,1,140)];
    
    _shuxian.backgroundColor = [UIColor grayColor];
    [self addSubview:_shuxian];
    
    
    [self creatTimeView];
    
    [self createNeirong];
    
    [self getCellHeight];
    
    
   
    
}


-(void)createNeirong{
    
    
   _neirongView = [[UIView alloc]initWithFrame:CGRectMake(15,90 ,200,100)];
    
    
    _neirongView.layer.borderWidth = 0.5;
    
    _neirongView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_neirongView];
    
    
    _neirongImage = [[UIImageView alloc]initWithFrame:CGRectMake(2, 2,100, 100)];
    
    _neirongImage.backgroundColor = [UIColor whiteColor];
    
    [_neirongView addSubview:_neirongImage];
    
    [_neirongImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_neirongView.mas_left).with.offset(4);
        
        make.top.equalTo(_neirongView.mas_top).with.offset(4);
        
        make.bottom.equalTo(_neirongView.mas_bottom).with.offset(-4);
        
        make.width.equalTo(_neirongImage.mas_height);
        
        
    }];
    
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    _title.numberOfLines = 1;
    
    _title.font = [UIFont systemFontOfSize:16];
    
    [_neirongView addSubview:_title];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_neirongImage.mas_right).with.offset(12);
        
        make.top.equalTo(_neirongView.mas_top).with.offset(16);
        
        make.height.mas_equalTo(16);
        
         make.right.equalTo(_neirongView.mas_right).with.offset(-4);
        
    }];
    _subTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    _subTitle.numberOfLines = 0;
    
    _subTitle.font = [UIFont systemFontOfSize:12];
    [_neirongView addSubview:_subTitle];
    
    [_neirongView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).with.offset(15);
        
        make.top.equalTo(self.timerView.mas_bottom).with.offset(8);
        
        //make.right.equalTo(subtitle.mas_right).with.offset(20);
        
        make.height.mas_equalTo(83);
        
        make.width.equalTo(self.mas_width).with.offset(-30);
        
        
        
    }];

    
    
    _goButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _goButton.backgroundColor = [UIColor redColor];
    
    [_neirongView addSubview:_goButton];
    
    [_goButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
//      make.left.equalTo(self.mas_left).with.offset(15);
        
//      make.top.equalTo(_neirongView.mas_top).with.offset(85);
        
        make.right.equalTo(_neirongView.mas_right).with.offset(-4);
        
        make.bottom.equalTo(_neirongView.mas_bottom).with.offset(-4);
        
        make.width.mas_equalTo(72);
        
    }];
    
    [_subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_neirongImage.mas_right).with.offset(12);
        
        make.top.equalTo(_title.mas_bottom).with.offset(8);
        
         make.right.equalTo(_goButton.mas_left).with.offset(-20);
        
    }];

    
    
}



-(void)creatTimeView{
    
    
    _timerView = [[UIView alloc]initWithFrame:CGRectMake(12,16,100,32)];
    
    
    _timerView.layer.borderWidth = 0.5;
    
    _timerView.layer.cornerRadius  = 3;
    
    _timerView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_timerView];
    
    
   _tubiao = [[UIImageView alloc]initWithFrame:CGRectMake(8,8, 15, 15)];
    
   // _tubiao.backgroundColor = [UIColor redColor];
    
    [_timerView addSubview:_tubiao];
    
    [_tubiao mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_timerView.mas_left).with.offset(8);
        
        make.width.mas_equalTo(15);
        
        make.centerY.equalTo(_timerView.mas_centerY);
        
    }];
    
    
    _mudi = [[UILabel alloc]initWithFrame:CGRectMake(30, 10,40, 40)];
    
   // _mudi.backgroundColor = [UIColor whiteColor];
    _mudi.textColor = [NSString colorWithHexString:@"#27292b"];
    _mudi.font = [UIFont systemFontOfSize:14];
    
     //_mudi.text = @"1111111111111111111111";
    [_timerView addSubview:_mudi];
    
    [_mudi mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_tubiao.mas_right).with.offset(8);
    
//        make.top.equalTo(_timerView.mas_top).with.offset(8);
//        
//        make.bottom.equalTo(_timerView.mas_bottom).with.offset(-8);
        
        make.centerY.equalTo(_timerView.mas_centerY);
    }];
    
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(75, 10, 100, 40)];
    
    //_timeLabel.backgroundColor = [UIColor  brownColor];
     _timeLabel.font = [UIFont systemFontOfSize:13];
     _timeLabel.textColor = [NSString colorWithHexString:@"#27292b"];
    [_timerView addSubview:_timeLabel];
    
    
    //_timeLabel.text = @"222222222";
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(_mudi.mas_right).with.offset(12);
        
        
//        make.top.equalTo(_timerView.mas_top).with.offset(8);
//        
//        make.bottom.equalTo(_timerView.mas_bottom).with.offset(-8);
        
        make.centerY.equalTo(_timerView.mas_centerY);
        
    }];
    
    
   // (15,20,100,60)
    
    _timerView.frame  = CGRectMake(15,20,_timeLabel.frame.origin.x+_timeLabel.frame.size.width+10 ,60);
    [_timerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).with.offset(12);
        
        make.top.equalTo(self.mas_top).with.offset(16);
        
       make.right.equalTo(_timeLabel.mas_right).with.offset(10);
        
        make.height.mas_equalTo(32);
    }];
    
}


-(float)getCellHeight{
    
    
    _shuxian.frame = CGRectMake(56/2, 0,2,140);
    
    return _neirongImage.frame.origin.y + _neirongImage.frame.size.height+4;
    
    
}

#pragma mark 比较时间
-(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    
    NSComparisonResult result = [oneDay compare:anotherDay];
    
    if (result == NSOrderedDescending) {
        //NSLog(@"oneDay比 anotherDay时间晚");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"oneDay比 anotherDay时间早");
        return -1;
    }
    //NSLog(@"两者时间是同一个时间");
    return 0;
    
}

@end
