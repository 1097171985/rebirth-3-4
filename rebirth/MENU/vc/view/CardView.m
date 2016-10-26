//
//  CardView.m
//  YSLDraggingCardContainerDemo
//
//  Created by yamaguchi on 2015/11/09.
//  Copyright © 2015年 h.yamaguchi. All rights reserved.
//

#import "CardView.h"

@implementation CardView

- (instancetype)init {
    self = [super init];
    if (self) {
  
        [self loadComponent];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
       
        [self loadComponent];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self loadComponent];
    }
    return self;
}

- (void)loadComponent {
    
    self.totalText = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-100,self.frame.size.width , 100)];
    self.totalText.backgroundColor = [UIColor clearColor];
    [self addSubview:self.totalText];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height-100)];
    self.titleLabel = [[UILabel alloc] init];
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.imageView.layer setMasksToBounds:YES];
    
    self.titleLabel.textColor = [NSString colorWithHexString:@"27292b"];
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.imageView];
    
    
    [self.titleLabel sizeToFit];
    [self.totalText addSubview:self.titleLabel];
    
    
    self.henlabel = [[UILabel alloc]init];
    self.henlabel.backgroundColor = [NSString colorWithHexString:@"e4c675"];
    [self.totalText addSubview:self.henlabel];
    

    self.subtitleLabel = [[UILabel alloc]init];
    self.subtitleLabel.textColor = [NSString colorWithHexString:@"6d7278"];
    [self.subtitleLabel sizeToFit];
    self.subtitleLabel.numberOfLines = 2;
    self.subtitleLabel.font = [UIFont systemFontOfSize:12];
    self.subtitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.totalText addSubview:self.subtitleLabel];
    
//    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.bottom.equalTo(self.totalText.mas_top).with.offset(0);
//        make.top.equalTo(self.mas_top).with.offset(0);
//        make.left.equalTo(self.mas_left).with.offset(0);
//        make.right.equalTo(self.mas_right).with.offset(0);
//        
//    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.totalText.mas_top).with.offset(20);
        make.centerX.equalTo(self.totalText.mas_centerX);
        
    }];
    [self.henlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(4);
        make.centerX.equalTo(self.totalText.mas_centerX);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(100);
    }];
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.henlabel.mas_bottom).with.offset(12);
        make.centerX.equalTo(self.totalText.mas_centerX);
        make.width.mas_equalTo(530/2);
    }];
    
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.totalText.mas_top).with.offset(15);
            make.centerX.equalTo(self.totalText.mas_centerX);
            
        }];
        [self.henlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.titleLabel.mas_bottom).with.offset(8);
            make.centerX.equalTo(self.totalText.mas_centerX);
            make.height.mas_equalTo(1);
            make.width.mas_equalTo(100);
        }];
        [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.henlabel.mas_bottom).with.offset(14);
            make.centerX.equalTo(self.totalText.mas_centerX);
            
        }];

    
    
    NSLog(@"%f == %f",self.frame.size.height ,self.imageView.frame.size.height);
    
    self.backgroundColor = [UIColor clearColor];
   }


@end
