//
//  NetworkWrongView.m
//  默认图
//
//  Created by boom on 16/8/8.
//  Copyright © 2016年 wjf. All rights reserved.
//

#import "NetworkWrongView.h"

@implementation NetworkWrongView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
       self.tupImage = [[UIImageView alloc]init];
        
      [self addSubview:self.tupImage];
        
        
      //NSLog(@"===%f",self.frame.size.height*(368/1334.0));
      [self.tupImage  mas_makeConstraints:^(MASConstraintMaker *make) {
          
          
          
          make.top.equalTo(self.mas_top).with.offset(self.frame.size.height*(368/1334.0));
          
          make.height.mas_equalTo(100);
          
          make.width.mas_equalTo(100);
          
          make.centerX.equalTo(self.mas_centerX);
          
          
      }];
        
      
        self.zhuTitle = [[UILabel alloc]init];
        
        [self addSubview:self.zhuTitle];
        
        [self.zhuTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.tupImage.mas_bottom).with.offset(16);
            
            make.height.mas_equalTo(14);
            
            //make.width.mas_equalTo(100);
            
            make.centerX.equalTo(self.mas_centerX);

            
            
        }];
        
        self.subTitle = [[UILabel alloc]init];
        
        [self addSubview:self.subTitle];
        
        [self.subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.zhuTitle.mas_bottom).with.offset(12);
            
            make.height.mas_equalTo(12);
            
            //make.width.mas_equalTo(100);
            
            make.centerX.equalTo(self.mas_centerX);
            
            
            
        }];
        
        
        self.sureBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self addSubview:self.sureBtu];
        
        [self.sureBtu mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.subTitle.mas_bottom).with.offset(24);
            
            make.height.mas_equalTo(56/2);
            
            make.width.mas_equalTo(144/2);
            
            make.centerX.equalTo(self.mas_centerX);
            
            
        }];
        
    }
    return self;
}

@end
