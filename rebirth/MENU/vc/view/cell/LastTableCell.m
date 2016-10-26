//
//  LastTableCell.m
//  rebirth
//
//  Created by WJF on 16/9/29.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "LastTableCell.h"

@implementation LastTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
       
        self.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
        
        self.coupBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.coupBtu  setTitle:@"查看历史优惠劵" forState:UIControlStateNormal] ;
        self.coupBtu.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.coupBtu setTitleColor:[NSString colorWithHexString:@"6d7278"] forState:UIControlStateNormal];
        [self.coupBtu sizeToFit];
        
        [self addSubview:self.coupBtu];
        
        [self.coupBtu mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.mas_centerX);
            
            make.centerY.equalTo(self.mas_centerY);
            
        }];
       
        
        
    }
    
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
