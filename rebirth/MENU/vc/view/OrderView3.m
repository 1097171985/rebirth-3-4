//
//  OrderView3.m
//  rebirth
//
//  Created by boom on 16/7/20.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "OrderView3.h"

@implementation OrderView3

-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        self.timeLable = [[UILabel alloc]init];
        
        self.timeLable.font = [UIFont systemFontOfSize:14];
        
        self.timeLable.textColor = [NSString colorWithHexString:@"#777777"];
        
       // self.timeLable.text = @"取车时间";
        
        self.timeLable.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:self.timeLable];
        
        [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_top).with.offset(12);
            
            make.centerX.equalTo(self.mas_centerX);
            
            make.height.mas_equalTo(14);
            
            
            
        }];
        
        
        self.orderTimeLable = [[UILabel alloc]init];
        
     //   self.orderTimeLable.text = @"2016/07/20 12:34";
        
        self.orderTimeLable.font = [UIFont systemFontOfSize:12];
        
        self.orderTimeLable.textColor = [NSString colorWithHexString:@"#e6ca81"];
        
        [self addSubview:self.orderTimeLable];
        
        
        [self.orderTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.timeLable.mas_bottom).with.offset(8);
            
            make.centerX.equalTo(self.mas_centerX);
            
            make.bottom.equalTo(self.mas_bottom).with.offset(-14);
            
            
            
        }];
    }
    return self;
    
}
@end
