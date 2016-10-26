//
//  OrderSubView1.m
//  rebirth
//
//  Created by boom on 16/7/20.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "OrderSubView1.h"

@implementation OrderSubView1

-(instancetype)init{
    
    self = [super init];
    if (self) {
        
        
//        self.backgroundColor = [UIColor redColor];
        self.newsLeftLable = [[UILabel alloc]init];
        
        self.newsLeftLable.font = [UIFont systemFontOfSize:14];
        
       // self.newsLeftLable.text = @"车辆";
        
        self.newsLeftLable.textColor = [NSString colorWithHexString:@"#333333"];
        
        [self addSubview:self.newsLeftLable];
        
        [self.newsLeftLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_left).with.offset(12);
            
            make.top.equalTo(self.mas_top).with.offset(0);
            
            make.height.equalTo(self.mas_height).with.offset(0);
            
            
            
        }];
        
        self.newsBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self addSubview:self.newsBtu];
        
        
        [self.newsBtu mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.mas_right).with.offset(-12);
            
            make.top.equalTo(self.mas_top).with.offset(12);

            make.width.mas_equalTo(6);
            
            make.height.mas_equalTo(12);
            
            make.centerY.equalTo(self.mas_centerY);
            
            
        }];
        
        
        
        self.newsRightLable  = [[UILabel alloc]init];
        
      //  self.newsRightLable.text = @"杭州市余杭区福鼎家园";
        
        [self addSubview:self.newsRightLable];
        
        [self.newsRightLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.newsBtu.mas_left).with.offset(-12);
            
            make.top.equalTo(self.mas_top).with.offset(0);
            
            make.height.equalTo(self.mas_height).with.offset(0);
            

            
            
        }];
        
        
        
        
        
    }
    return self;
}

@end
