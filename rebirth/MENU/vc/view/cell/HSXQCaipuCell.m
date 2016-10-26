//
//  HSXQCaipuCell.m
//  rebirth
//
//  Created by 侯帅 on 16/7/19.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSXQCaipuCell.h"

@implementation HSXQCaipuCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithArray :(NSMutableArray *)array withCaipu:(NSString *)caipu withArrayCount:(int)count{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        float xx;
        float yy;
        NSInteger index = 0;
        for (NSDictionary *dict in array) {
        
            xx = 0;
            yy = index *40;
            UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(xx, yy+35, 100, 40)];
            lbl.backgroundColor = [UIColor clearColor];
            if ([caipu isEqualToString:@"caipu"]) {
                lbl.text = [NSString stringWithFormat:@"   %@",dict[@"name"]];
            }
            lbl.textColor = [NSString colorWithHexString:heitizi];
            lbl.font = [UIFont systemFontOfSize:12];
            [self addSubview:lbl];
            
            
            UILabel *lbl1 = [[UILabel alloc]initWithFrame:CGRectMake(220, yy+35, 90, 40)];
            lbl1.textAlignment = NSTextAlignmentCenter;
            lbl1.backgroundColor = [UIColor clearColor];
            if ([caipu isEqualToString:@"caipu"]) {
                
                lbl1.text = [NSString stringWithFormat:@"x%@",dict[@"num"]];
            }
            lbl1.textColor = [NSString colorWithHexString:heitizi];
            lbl1.font = [UIFont systemFontOfSize:12];
            [self addSubview:lbl1];
            
            
            UILabel *lbl2 = [[UILabel alloc]initWithFrame:CGRectMake(220+90, yy+35, 65, 40)];
            lbl2.textAlignment = NSTextAlignmentCenter;
            lbl2.backgroundColor = [UIColor clearColor];
            if ([caipu isEqualToString:@"caipu"]) {
                
                lbl2.text = [NSString stringWithFormat:@"¥ %@",dict[@"price"]];
            }
            lbl2.textColor = [NSString colorWithHexString:heitizi];
            lbl2.font = [UIFont systemFontOfSize:12];
            [self addSubview:lbl2];
            index++;
            
            
            
        }
        UILabel *biaotiLbl = [[UILabel alloc] init];
        if ([caipu isEqualToString:@"caipu"]) {
            
            biaotiLbl.text = @"菜谱";
        }
        
        biaotiLbl.textColor = [NSString colorWithHexString:heitizi];
        biaotiLbl.font = [UIFont systemFontOfSize:14];
        [self addSubview:biaotiLbl];
        [biaotiLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(8);
            make.right.equalTo(self);
            make.top.equalTo(self).offset(12);
            make.height.equalTo(@14);
        }];
        
        if (count >0) {
            UILabel *henxian = [[UILabel alloc]initWithFrame:CGRectMake(0,biaotiLbl.frame.size.height-0.5,biaotiLbl.frame.size.width,0.5)];
            henxian.backgroundColor = [NSString colorWithHexString:@"e5e5e5"];
            
            [self addSubview:henxian];
            [henxian mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self.mas_left).offset(0);
                make.right.equalTo(biaotiLbl.mas_right).offset(0);
                make.top.equalTo(biaotiLbl.mas_bottom).offset(3);
                make.height.equalTo(@0.5);
                make.width.mas_equalTo(WIDTH);
                
                
            }];

        }
      
        
        
        
        
        if (count > 5) {
            
         _myBt = [UIButton buttonWithType:UIButtonTypeCustom];
         _myBt.frame = CGRectMake(kScreenWidth/3, (index *40)+35, kScreenWidth/3,20);
       
         _myBt.titleLabel.font = [UIFont systemFontOfSize:12];
         [_myBt setTitleColor:[NSString colorWithHexString:@"6d7278"] forState:UIControlStateNormal];
         [_myBt addTarget:self action:@selector(myBtClick) forControlEvents:UIControlEventTouchUpInside];
         [self addSubview:_myBt];
        }
    }
    return self;
}

- (void)myBtClick
{
    if ([_delegate respondsToSelector:@selector(moreBtDelegate)]) {
        [_delegate moreBtDelegate];
    }
}


- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
