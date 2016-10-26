//
//  XingChengGuanLiCell.m
//  rebirth
//
//  Created by 侯帅 on 16/10/20.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "XingChengGuanLiCell.h"

@implementation XingChengGuanLiCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatView];
    }
    return self;
}
-(void)creatView{
   _timelabel = [[UILabel alloc] init];
    _timelabel.frame =CGRectMake(0, 20, kScreenWidth, 14);
    _timelabel.text = @"出行 10/17 14:00";
    _timelabel.textAlignment = NSTextAlignmentCenter;
    _timelabel.textColor = [NSString colorWithHexString:@"6d7278"];
    _timelabel.font = [UIFont systemFontOfSize:14 weight:bold];
    [self addSubview:_timelabel];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.frame =CGRectMake(8, 20+_timelabel.frame.size.height+12, kScreenWidth-16, 256/2);
    contentView.layer.cornerRadius =12;
    contentView.layer.masksToBounds = YES;
    contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentView];
    
    _leftIMG = [[UIImageView alloc] init];
    _leftIMG.frame =CGRectMake(0, 0, 256/2, contentView.frame.size.height);
    _leftIMG.image = [UIImage imageNamed:@"headImg"];
    [contentView addSubview:_leftIMG];
    
    _namelabel = [[UILabel alloc] init];
    _namelabel.frame =CGRectMake(_leftIMG.frame.size.width+12, 72/2, kScreenWidth-_leftIMG.frame.size.width-12, 18);
    _namelabel.font = [UIFont systemFontOfSize:18];
    _namelabel.textColor = [NSString colorWithHexString:heitizi];
    _namelabel.textAlignment = NSTextAlignmentLeft;
    _namelabel.text = @"奔驰SLS AMG";
    [contentView addSubview:_namelabel];
    
    _weizhiLabel = [[UILabel alloc] init];
    _weizhiLabel.frame =CGRectMake(_leftIMG.frame.size.width+12, 72/2+_namelabel.frame.size.height+32/2, kScreenWidth-_leftIMG.frame.size.width-12, 14);
    _weizhiLabel.numberOfLines = 0;
    _weizhiLabel.font = [UIFont systemFontOfSize:14];
    _weizhiLabel.text = @"杭州市延安路179号解百新元华";
    _weizhiLabel.textAlignment = NSTextAlignmentLeft;
    _weizhiLabel.textColor = [NSString colorWithHexString:@"6d7278"];
    [contentView addSubview:_weizhiLabel];
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteBtn.frame =CGRectMake(contentView.frame.size.width-12-14, 12, 14, 14);
    [_deleteBtn setImage:[UIImage imageNamed:@"cancel_icon@2x"] forState:UIControlStateNormal];
    [contentView addSubview:_deleteBtn];

    UIView *line = [[UIView alloc] init];
    line.frame =CGRectMake(0, contentView.frame.size.height-0.5, contentView.frame.size.width, 0.5);
    line.backgroundColor = [NSString colorWithHexString:@"e5e5e5"];
    [contentView addSubview:line];
    
    
}
 
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
