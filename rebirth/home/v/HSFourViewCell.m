//
//  HSFourViewCell.m
//  rebirth
//
//  Created by 侯帅 on 16/7/18.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSFourViewCell.h"

@implementation HSFourViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creat];
    }
    return self;
}
-(void)creat{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _firstBtn.frame =CGRectMake(8, 0, (kScreenWidth-25)/2, 232/2);
    
   // [_firstBtn setImage:[UIImage imageNamed:@"easy@2x"] forState:UIControlStateNormal];
    [self addSubview:_firstBtn];
    _secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _secondBtn.frame =CGRectMake(_firstBtn.frame.size.width+16, 0, (kScreenWidth-25)/2, 232/2);
   
   // [_secondBtn setImage:[UIImage imageNamed:@"guide@2x"] forState:UIControlStateNormal];
    [self addSubview:_secondBtn];
    UIView *content = [[UIView alloc] initWithFrame:CGRectMake(0, 124, kScreenWidth, 12)];
    content.backgroundColor = [NSString colorWithHexString:Grayline];
    [self addSubview:content];
}
-(void)setmodel:(HSHomeModel *)model{
    [_firstBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.img_url]] forState:UIControlStateNormal placeholderImage:nil];
    
}
-(void)setmodell:(HSHomeModel *)model{
    [_secondBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.img_url]] forState:UIControlStateNormal placeholderImage:nil];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
