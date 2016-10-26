//
//  HSLunBoViewCell.m
//  rebirth
//
//  Created by 侯帅 on 16/7/18.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSLunBoViewCell.h"
#import "HSPlayer.h"
@implementation HSLunBoViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       // self.backgroundColor = [NSString colorWithHexString:@"f6f6f6"];

        self.imageScrollView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,WIDTH,510/2-20)];
       // self.imageScrollView.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.imageScrollView];
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
