//
//  FoodTotalView.m
//  rebirth
//
//  Created by boom on 16/7/19.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "FoodTotalView.h"

@implementation FoodTotalView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.foodView = [[FoodView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 61)];
        
        [self addSubview:self.foodView];
        
        [self.foodView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
//          make.left.equalTo(self.mas_left).with.offset(0);
//            
//          make.right.equalTo(self.mas_right).with.offset(0);
//
            make.top.equalTo(self.mas_top).with.offset(0);
            
            make.bottom.equalTo(self.mas_bottom).with.offset(0);
            
         
            make.centerX.equalTo(self.mas_centerX);
            
            make.width.mas_equalTo(WIDTH/3);
            
        }];
        
        
        self.deleteBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.deleteBtu setImage:[UIImage imageNamed:@"x@2x"] forState:UIControlStateNormal];
        
        [self addSubview:self.deleteBtu];
        
        [self.deleteBtu mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.right.equalTo(self.mas_right).with.offset(0);
            
            make.top.equalTo(self.mas_top).with.offset(0);
            
            
            make.width.mas_equalTo(24);
            
            make.height.mas_equalTo(18);
            
            
            
        }];

    }
    
    return self;
}
@end
