//
//  FoodView.m
//  rebirth
//
//  Created by boom on 16/7/19.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "FoodView.h"

@implementation FoodView

-(instancetype)initWithFrame:(CGRect)frame{
    
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.foodStyle = [[UILabel alloc]init];
        
        self.foodStyle.text = @"下午茶";
        
        self.foodStyle.font = [UIFont systemFontOfSize:12];
        
        self.foodStyle.textAlignment = NSTextAlignmentCenter;
        
        
        [self addSubview:self.foodStyle];
        
        [self.foodStyle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_left).with.offset(12);
            
            make.top.equalTo(self.mas_top).with.offset(14);
            
        }];
        
        
        
        self.foodTime = [[UILabel alloc]init];
        
        self.foodTime.font = [UIFont systemFontOfSize:12];
        
        self.foodTime.text = @"10:00";
        
        [self addSubview:self.foodTime];
        
        [self.foodTime mas_makeConstraints:^(MASConstraintMaker *make) {
            
          
            make.left.equalTo(self.mas_left).with.offset(12);
            
            make.top.equalTo(self.foodStyle.mas_top).with.offset(9);
            
            
            make.bottom.equalTo(self.mas_bottom).with.offset(-14);
            
            
        }];
        
        
        self.restaurantName = [[UIImageView alloc]init];
        
        self.restaurantName.image = [UIImage imageNamed:@"dibai_img"];
        
        [self addSubview:self.restaurantName];
        
        [self.restaurantName mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_top).with.offset(0);
            
            make.bottom.equalTo(self.mas_bottom).with.offset(0);
            
            make.width.equalTo(self.restaurantName.mas_height);
            
            make.right.equalTo(self.mas_right).with.offset(-12);
            

            
        }];
        
               
    }
    return self;
    
}
@end
