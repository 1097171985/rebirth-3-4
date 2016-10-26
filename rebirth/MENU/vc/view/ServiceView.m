
//
//  ServiceView.m
//  rebirth
//
//  Created by boom on 16/7/26.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "ServiceView.h"

@implementation ServiceView

-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        UILabel *service = [[UILabel alloc]init];
        
        service.text = @"服务与限制";
        service.font = [UIFont systemFontOfSize:16];
        
        service.textAlignment = NSTextAlignmentCenter;
        
        service.textColor = [NSString colorWithHexString:@"#27292b"];
        
        [self addSubview:service];
        
        [service mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_top).with.offset(0);
            
            make.left.equalTo(self.mas_left).with.offset(0);
            
            make.right.equalTo(self.mas_right).with.offset(0);
            
            make.height.mas_equalTo(44);
            
        }];
        
        
        
        self.oneServiceView = [[ServiceSubView alloc]init];

        [self addSubview:self.oneServiceView];
        
        [self.oneServiceView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_left).with.offset(0);
            
            make.right.equalTo(self.mas_right).with.offset(0);
            
            make.top.equalTo(service.mas_bottom).with.offset(0);
            
        }];
        
        
        self.twoServiceView = [[ServiceSubView alloc]init];
        
        [self addSubview:self.twoServiceView];

        [self.twoServiceView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_left).with.offset(0);
            
            make.right.equalTo(self.mas_right).with.offset(0);
            
            make.top.equalTo(self.oneServiceView.mas_bottom).with.offset(-1);
            
            
        }];
        
        
        self.threeServiceView = [[ServiceSubView alloc]init];
        
        [self addSubview:self.threeServiceView];

        [self.threeServiceView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_left).with.offset(0);
            
            make.right.equalTo(self.mas_right).with.offset(0);
            
            make.top.equalTo(self.twoServiceView.mas_bottom).with.offset(-1);
            
            make.bottom.equalTo(self.mas_bottom).with.offset(0);
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
