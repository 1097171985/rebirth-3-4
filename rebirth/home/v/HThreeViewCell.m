//
//  HThreeViewCell.m
//  rebirth
//
//  Created by 侯帅 on 16/7/18.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HThreeViewCell.h"

@implementation HThreeViewCell
-(void)setModel:(HSHomeModel *)model{
    
     [self.img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.img_url]] placeholderImage:nil];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
