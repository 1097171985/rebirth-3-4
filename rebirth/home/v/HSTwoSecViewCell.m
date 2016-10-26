//
//  HSTwoSecViewCell.m
//  rebirth
//
//  Created by 侯帅 on 16/7/18.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSTwoSecViewCell.h"

@implementation HSTwoSecViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creat];
    }
    return self;
}
-(void)creat{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _wanzhuanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _wanzhuanBtn.frame =CGRectMake(0, 0, kScreenWidth/2-1, 65);
    [_wanzhuanBtn setImage:[UIImage imageNamed:@"easy@2x"] forState:UIControlStateNormal];
    [self addSubview:_wanzhuanBtn];
    _zucheBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _zucheBtn.frame =CGRectMake(_wanzhuanBtn.frame.size.width, 0, kScreenWidth/2-1, 65);
    [_zucheBtn setImage:[UIImage imageNamed:@"guide@2x"] forState:UIControlStateNormal];
    [self addSubview:_zucheBtn];
    UIView *shuline = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2, 0, 0.5, 65)];
    shuline.backgroundColor = [NSString colorWithHexString:@"a2aab2"];
    [self addSubview:shuline];
    
    UIView *content = [[UIView alloc] initWithFrame:CGRectMake(0, 65, kScreenWidth, 5)];
    content.backgroundColor = [NSString colorWithHexString:Grayline];
    [self addSubview:content];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
