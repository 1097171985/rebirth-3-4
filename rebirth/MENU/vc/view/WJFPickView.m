//
//  WJFPickView.m
//  rebirth
//
//  Created by boom on 16/7/19.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "WJFPickView.h"

@implementation WJFPickView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        UIColor *color = [NSString colorWithHexString:@"#000000"];;
        self.backgroundColor = [color colorWithAlphaComponent:0.4];
        
        UIView  *totalPickView  = [[UIView alloc]init];
        
        totalPickView.backgroundColor = [UIColor whiteColor];
        
        
        [self addSubview:totalPickView];
        
        
     
        
        
        UILabel *selectLable = [[UILabel alloc]init];
        
        [totalPickView addSubview:selectLable];
        
        selectLable.text = @"请选择具体时间";
        
        selectLable.textAlignment = NSTextAlignmentCenter;
        
        [selectLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.height.mas_equalTo(40);
            
            make.left.equalTo(totalPickView.mas_left).with.offset(8);
            
            
            make.top.equalTo(totalPickView.mas_top).with.offset(0);
            
            
        }];
        
        
        self.selectTimeLable = [[UILabel alloc]init];
        
        [totalPickView addSubview:self.selectTimeLable];
        
        self.selectTimeLable.text = @"2016/07/15 14:14";
        
        self.selectTimeLable.textAlignment = NSTextAlignmentCenter;
        
        
        [self.selectTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(40);
            
            make.right.equalTo(totalPickView.mas_right).with.offset(-12);
            
    
            make.top.equalTo(totalPickView.mas_top).with.offset(0);
        
            
            
        }];
        
        
        
        
        
        self.timePickView = [[UIPickerView alloc]init];
        
        
        
        [totalPickView addSubview:self.timePickView];
        
        
        [self.timePickView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.height.mas_equalTo(140);
            
            make.right.equalTo(totalPickView.mas_right).with.offset(0);
            
            make.left.equalTo(totalPickView.mas_left).with.offset(0);

            make.top.equalTo(self.selectTimeLable.mas_bottom).with.offset(0);
            

            
            
        }];
        
        
        self.cancalBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        
       
        [self.cancalBtu setTitle:@"取消" forState:UIControlStateNormal];
        
        [self.cancalBtu setTitleColor:[NSString colorWithHexString:@"#a2aab3"] forState:UIControlStateNormal];
        
        [totalPickView addSubview:self.cancalBtu];
        
        [self.cancalBtu mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.height.mas_equalTo(96/2);
            
            make.left.equalTo(totalPickView.mas_left).with.offset(0);
            
            make.top.equalTo(self.timePickView.mas_bottom).with.offset(0);
            
            make.width.mas_equalTo(358/2);
            
            
        }];

        
        
        
        
        
        self.sureBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [totalPickView addSubview:self.sureBtu];
        
        [self.sureBtu setTitle:@"确定" forState:UIControlStateNormal];
        
        [self.sureBtu  setTitleColor:[NSString colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        
        self.sureBtu.backgroundColor = [NSString colorWithHexString:@"#27292b"];
        
        [self.sureBtu mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.height.mas_equalTo(self.cancalBtu.mas_height);
            
            make.left.equalTo(self.cancalBtu.mas_right).with.offset(0);
            
            make.top.equalTo(self.timePickView.mas_bottom).with.offset(0);
            
            
            make.right.equalTo(totalPickView.mas_right).with.offset(0);
            
            make.width.mas_equalTo(358/2);
            
        }];
        
        
        
        [totalPickView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.height.mas_equalTo(456/2);
            
            make.left.equalTo(self.mas_left).with.offset(8);
            
            
            make.right.equalTo(self.mas_right).with.offset(-8);
            
            make.centerY.equalTo(self.mas_centerY);
            
        }];
        
    }
    return self;
}


@end
