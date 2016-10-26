//
//  ServiceSubView.m
//  rebirth
//
//  Created by boom on 16/7/26.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "ServiceSubView.h"

@implementation ServiceSubView


-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        
       // self.layer.borderWidth = 1;
//        
//        UIColor *boreder = [UIColor grayColor];
//        
//        self.layer.borderColor =boreder.CGColor;
//  
        self.tubiaoImage = [[UIImageView alloc]init];
        
        [self addSubview:self.tubiaoImage];
        
        
        [self.tubiaoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.left.equalTo(self.mas_left).with.offset(12);
            
            make.top.equalTo(self.mas_top).with.offset(13);
            
            make.width.mas_equalTo(20);
            
            make.height.mas_equalTo(20);
            
            
            
        }];
        
        
        self.tubiaoLabel  = [[UILabel alloc]init];
        
        self.tubiaoLabel.font = [UIFont systemFontOfSize:14];
        
        self.tubiaoLabel.textColor = [NSString colorWithHexString:@"#27292b"];
        [self addSubview:self.tubiaoLabel];
        
        [self.tubiaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.left.equalTo(self.tubiaoImage.mas_right).with.offset(12);
            
            make.top.equalTo(self.mas_top).with.offset(16);
            
            make.height.mas_equalTo(14);
            
            
            
        }];
        

        
        self.tubiaoSubLabel = [[UILabel alloc]init];
        
        self.tubiaoSubLabel.font = [UIFont systemFontOfSize:12];
        
        self.tubiaoSubLabel.numberOfLines = 0;
        
        self.tubiaoSubLabel.textColor = [NSString colorWithHexString:@"#6d7278"];
        
        [self addSubview:self.tubiaoSubLabel];
        
        
        [self.tubiaoSubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.left.equalTo(self.tubiaoImage.mas_right).with.offset(12);
            
            make.top.equalTo(self.tubiaoLabel.mas_bottom).with.offset(12);
            
            make.bottom.equalTo(self.mas_bottom).with.offset(-16);
            
            make.right.equalTo(self.mas_right).with.offset(-12);
            
        }];

        
        UILabel *henxian = [[UILabel alloc]init];
         henxian.backgroundColor = [NSString colorWithHexString:@"#e5e5e5"];        [self addSubview:henxian];
        [henxian mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.left.equalTo(self.mas_left).with.offset(12);
            
            make.height.mas_equalTo(1);
            
            make.bottom.equalTo(self.mas_top).with.offset(0);
            
            make.right.equalTo(self.mas_right).with.offset(-12);
            
        }];

        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
