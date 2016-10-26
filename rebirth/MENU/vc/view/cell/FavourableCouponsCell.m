//
//  FavourableCouponsCell.m
//  rebirth
//
//  Created by WJF on 16/10/11.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "FavourableCouponsCell.h"

@implementation FavourableCouponsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"优惠劵";
        [self addSubview:label];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [NSString colorWithHexString:@"27292b"];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_left).with.offset(12);
            
            make.centerY.equalTo(self.mas_centerY);
            
        }];
        
        
        self.favoCouLabel = [[UILabel alloc]init];
        [self addSubview:self.favoCouLabel];
        self.favoCouLabel.text = @"-¥5666";
        self.favoCouLabel.font = [UIFont systemFontOfSize:12];
        self.favoCouLabel.textColor = [NSString colorWithHexString:@"e6ca81"];
        [self.favoCouLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.mas_right).with.offset(-12);
            
            make.centerY.equalTo(self.mas_centerY);
            
        }];

        
    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
