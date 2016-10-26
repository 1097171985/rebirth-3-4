//
//  HSCDXQMapCell.m
//  rebirth
//
//  Created by 侯帅 on 16/7/20.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSCDXQMapCell.h"


@implementation HSCDXQMapCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.biaotiLbl = [[UILabel alloc] init];
        self.biaotiLbl.text = @"用餐地点";
        self.biaotiLbl.textColor = [NSString colorWithHexString:heitizi];
        self.biaotiLbl.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.biaotiLbl];
        [self.biaotiLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(8);
            make.right.equalTo(self);
            make.top.equalTo(self).offset(12);
            make.height.equalTo(@14);
        }];
        
        self.mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, 375, 200)];
        
        
        [self addSubview:self.mapView];
        
        [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).with.offset(0);
            make.right.equalTo(self).with.offset(0);
            make.top.equalTo(self.biaotiLbl.mas_bottom).offset(12);
           // make.height.equalTo(@150);
            make.bottom.equalTo(self.mas_bottom).offset(-12);
        }];
        
        
        
        self.addressLable = [[UILabel alloc]init];
        
        self.addressLable.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
        self.addressLable.textColor = [NSString colorWithHexString:@"#27292b"];
        self.addressLable.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:self.addressLable];
        
        [self.addressLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).with.offset(0);
            make.right.equalTo(self).with.offset(0);
            make.height.equalTo(@32);
            make.bottom.equalTo(self.mas_bottom).offset(-12);
            
            
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
