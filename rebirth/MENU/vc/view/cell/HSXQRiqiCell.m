//
//  HSXQRiqiCell.m
//  rebirth
//
//  Created by 侯帅 on 16/7/19.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSXQRiqiCell.h"

@implementation HSXQRiqiCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creat];
    }
    return self;
}
-(void)creat{
    self.riqilbl = [[UILabel alloc] init];
    self.riqilbl.text = @"用餐时间";
    self.riqilbl.textColor = [NSString colorWithHexString:heitizi];
    self.riqilbl.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.riqilbl];
    [self.riqilbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(15);
        make.left.mas_equalTo(self).offset(8);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(14);
    }];
    
    _xuanzeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _xuanzeBtn.frame =CGRectMake(250, 15, 90, 12);
    [_xuanzeBtn setTitle:@"请选择用餐时间" forState:UIControlStateNormal];
    [_xuanzeBtn setTitleColor:[NSString colorWithHexString:@"#e4c675"] forState:UIControlStateNormal];
    _xuanzeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_xuanzeBtn];
    
    
    UIImageView *seletImage = [[UIImageView alloc]init];
    
    seletImage.image = [UIImage imageNamed:@"order_arrow@2x"];
    [self addSubview:seletImage];
    [seletImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).with.offset(-12);
        
        
        make.height.mas_equalTo(12);
        
        make.centerY.equalTo(self.mas_centerY);
        

        
    }];
    
    [_xuanzeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.right.equalTo(seletImage.mas_right).with.offset(-12);
        
        make.height.mas_equalTo(12);
        
        make.centerY.equalTo(self.mas_centerY);
        
    }];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
