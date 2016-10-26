//
//  OrderView2.m
//  rebirth
//
//  Created by boom on 16/7/20.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "OrderView2.h"

@implementation OrderView2

-(instancetype)init{
    
    
    self = [super init];
    
    if (self) {
        
        self.backgroundColor = [NSString colorWithHexString:@"#f2f2f2"];
        
        self.orderImageView = [[UIImageView alloc]init];
        
       // self.orderImageView.image = [UIImage imageNamed:@"huanglong_img"];
        
        [self addSubview:self.orderImageView];
        
        [self.orderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.left.equalTo(self.mas_left).with.offset(0);
            
            make.top.equalTo(self.mas_top).with.offset(0);
            
            make.bottom.equalTo(self.mas_bottom).with.offset(0);
            
            make.width.equalTo(self.orderImageView.mas_height);
            
            
        }];
        
        
        self.orderTextLable = [[UILabel alloc]init];
        
     //   self.orderTextLable.text = @"宝马飒飒飒飒";
        self.orderTextLable.font =[UIFont systemFontOfSize:16];
        self.orderTextLable.textColor = [NSString colorWithHexString:@"#27292b"];
        
        [self addSubview:self.orderTextLable];
        
        [self.orderTextLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.orderImageView.mas_right).with.offset(12);
            
            make.top.equalTo(self.mas_top).with.offset(20);
            
            make.height.mas_equalTo(16);
            
            
        }];
        
        
        self.orderSubTextLable = [[UILabel alloc]init];
      //  self.orderSubTextLable.text = @"是大大大的卡爱卡大的;啊";
        self.orderSubTextLable.numberOfLines = 2;
        
        self.orderSubTextLable.font = [UIFont systemFontOfSize:12];
        self.orderSubTextLable.textColor = [NSString colorWithHexString:@"#6d7278"];
        [self addSubview:self.orderSubTextLable];
        
        [self.orderSubTextLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.orderImageView.mas_right).with.offset(12);
            
            make.top.equalTo(self.orderTextLable.mas_top).with.offset(12);
            
           make.right.equalTo(self.mas_right).with.offset(-12);
            
            
            make.bottom.equalTo(self.mas_bottom).with.offset(-12);
        }];
        
        
        
        self.chepaiLable = [[UILabel alloc]init];
        
        self.chepaiLable.text = @"¥10000";
        self.chepaiLable.font =[UIFont systemFontOfSize:16];
        self.chepaiLable.textColor = [NSString colorWithHexString:@"#27292b"];
        

        [self addSubview:self.chepaiLable];
        
        [self.chepaiLable  mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.mas_bottom).with.offset(-4);
            
            make.left.equalTo(self.orderImageView.mas_right).with.offset(12);
            
            make.height.mas_equalTo(18);
            
            
        }];

        
        
    }
    
    return self;
}

@end
