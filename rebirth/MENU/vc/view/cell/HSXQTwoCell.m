//
//  HSXQTwoCell.m
//  rebirth
//
//  Created by 侯帅 on 16/7/19.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSXQTwoCell.h"

@implementation HSXQTwoCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         [self createView];
    }
    return self;
}

- (void)awakeFromNib {
    
      // Initialization code
}


-(void)createView{
    
    self.mealName = [[UILabel alloc]init];
    
    self.mealName.textColor = [NSString colorWithHexString:@"#27292b"];
    
    self.mealName.font = [UIFont systemFontOfSize:16];
    
    
    [self addSubview:self.mealName];
    
    [self.mealName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).with.offset(12);
        
        make.top.equalTo(self.mas_top).with.offset(12);
        
        make.height.mas_equalTo(16);
        
        make.width.mas_equalTo(WIDTH);
        
    }];
    
    
    self.detailName = [[UILabel alloc]init];
    
    self.detailName.font = [UIFont systemFontOfSize:12];
    
    self.detailName.userInteractionEnabled = YES;
    self.detailName.numberOfLines = 2;
    
    self.detailName.textColor = [NSString colorWithHexString:@"#6d7278"];
    [self.detailName sizeToFit];
    [self addSubview:self.detailName];
    
    [self.detailName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.mas_left).with.offset(12);
        
        make.top.equalTo(self.mealName.mas_bottom).with.offset(8);
        
       
        
        make.width.mas_equalTo(WIDTH/3.0*2+25);
        
    }];
    
//    self.money = [[UILabel alloc]init];
//    
//    self.money.textColor = [NSString colorWithHexString:@"#e4c675"];
//    
//    self.money.font = [UIFont systemFontOfSize:18];
//    
//    [self addSubview:self.money];
//    [self.money mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.equalTo(self.mas_left).with.offset(12);
//        
//        make.top.equalTo(self.detailName.mas_bottom).with.offset(12);
//        
//        make.height.mas_equalTo(18);
//        
//        make.width.mas_equalTo(WIDTH);
//        
//    }];
    
    
    self.styleName = [[InsetLabel alloc]init];
    
    self.styleName.textColor = [NSString colorWithHexString:@"#ffffff"];
    
    self.styleName.backgroundColor = [UIColor blackColor];
    
    self.styleName.font = [UIFont systemFontOfSize:16];
    
    [self addSubview:self.styleName];
    
    
    [self.styleName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).with.offset(-12);
        
        make.top.equalTo(self.mas_top).with.offset(16);
        
        make.height.mas_equalTo(52/2);
        
    }];

    self.styleName.neiinsets = UIEdgeInsetsMake(0, 8, 0, 8);//通过设置insets属性直接设置Label的内边距。
    
    [self.styleName sizeToFit];
    
    self.serviceBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    self.serviceBtu.backgroundColor = [NSString colorWithHexString:@"#f7f7f7"];
    self.serviceBtu.frame = CGRectMake(0, self.detailName.frame.origin.y+self.detailName.frame.size.height, WIDTH, 30);
    
    [self addSubview:self.serviceBtu];
    
    [self.serviceBtu mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.mas_left).with.offset(0);
        
        make.top.equalTo(self.detailName.mas_bottom).with.offset(12);
        
        make.height.mas_equalTo(30);
        
        make.width.mas_equalTo(WIDTH);
        
        
    }];
    
    UILabel  *wenzi = [[UILabel alloc]init];
    
    wenzi.text = @"服务与限制";
    
    wenzi.textColor = [NSString colorWithHexString:@"#6d7278"];
    
    wenzi.textAlignment = NSTextAlignmentCenter;
    
    wenzi.font = [UIFont systemFontOfSize:12];
    
    [self.serviceBtu addSubview:wenzi];
    
    [wenzi mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).with.offset(12);
        
        make.top.equalTo(self.serviceBtu.mas_top).with.offset(8);
    
        make.height.mas_equalTo(12);
        
        
       // make.centerX.equalTo(self.serviceBtu.mas_centerX);
        
    }];
    
    
    UIImageView *wenziImage = [[UIImageView alloc]init];
    
    wenziImage.image = [UIImage imageNamed:@"order_arrow@2x"];
    
    [self.serviceBtu addSubview:wenziImage];
    
    
    [wenziImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.serviceBtu.mas_right).with.offset(-12);
        
        make.top.equalTo(self.serviceBtu.mas_top).with.offset(8);
        
        make.height.mas_equalTo(15);
        
        make.centerY.equalTo(self.serviceBtu.mas_centerY);
        
        
    }];
    
    UILabel *henxian = [[UILabel alloc]init];
    henxian.backgroundColor = [NSString colorWithHexString:@"#d1d1d1"];
    
    [self.serviceBtu addSubview:henxian];
    
    [henxian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(WIDTH);
        
        make.height.mas_equalTo(0.5);
        
        make.bottom.equalTo(self.serviceBtu.mas_bottom).with.offset(0);
        
        
    }];
    
    self.frame = CGRectMake(0,0, WIDTH,100);
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
