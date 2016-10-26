//
//  DingZhiCell.m
//  rebirth
//
//  Created by boom on 16/7/19.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "DingZhiCell.h"

@implementation DingZhiCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.dingzhiimageView = [[UIImageView alloc]init];
        
        self.dingzhiimageView.image = [UIImage imageNamed:@"huanglong_img"];
        
        [self.contentView addSubview:self.dingzhiimageView];
        
        [self.dingzhiimageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.left.equalTo(self.mas_left).with.offset(0);
            
            make.top.equalTo(self.mas_top).with.offset(1);
            
            make.bottom.equalTo(self.mas_bottom).with.offset(-3);
            
            make.width.equalTo(self.dingzhiimageView.mas_height);
            
            
        }];
        
        
        self.dingzhiLabel = [[UILabel alloc]init];
        self.dingzhiLabel.font =[UIFont systemFontOfSize:16];
        
        
        
        [self.contentView addSubview:self.dingzhiLabel];
        
        [self.dingzhiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.dingzhiimageView.mas_right).with.offset(12);
            
            make.top.equalTo(self.mas_top).with.offset(78/2);
            
            make.height.mas_equalTo(16);
            
            
        }];
        
        
        self.subDingZhiLable = [[UILabel alloc]init];
        
        self.subDingZhiLable.numberOfLines = 0;
        
        //self.subDingZhiLable.backgroundColor = [UIColor redColor];
        
        self.subDingZhiLable.font = [UIFont systemFontOfSize:12];
        
        [self.contentView addSubview:self.subDingZhiLable];
        
        [self.subDingZhiLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.dingzhiimageView.mas_right).with.offset(12);
            
            make.top.equalTo(self.dingzhiLabel.mas_bottom).with.offset(12);
            
            make.width.mas_equalTo(210);

            make.bottom.equalTo(self.mas_bottom).with.offset(-78/2);
        }];

        
        
        self.moneyLable = [[UILabel alloc]init];
        
        //self.moneyLable.text = @"¥10000";
        
        [self.contentView addSubview:self.moneyLable];
        
        [self.moneyLable  mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.mas_bottom).with.offset(-12);
            
            make.right.equalTo(self.mas_right).with.offset(-12);
            
            make.height.mas_equalTo(0);
            
            
        }];
        
        
        self.delectBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.contentView addSubview:self.delectBtu];
        
        [self.delectBtu mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_top).with.offset(0);
            
            make.right.equalTo(self.mas_right).with.offset(0);
            
            make.height.mas_equalTo(56/2);
            
            make.width.mas_equalTo(156/2);
            
        }];
        
        self.delectBtu.hidden = YES;
        
    }
    return self;
}


-(float)getHeight{
    
    
    return self.frame.origin.y+self.frame.size.height;
}
@end
