//
//  GradePrerogativeView.m
//  rebirth
//
//  Created by WJF on 16/10/8.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "GradePrerogativeView.h"

@implementation GradePrerogativeView


-(instancetype)initWithFrame:(CGRect)frame  withGradeprerogateData:(NSString *)gradeperoteStr{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.textStr = gradeperoteStr;
        
        [self loadTextView];
    }
    return self;
}

-(void)loadTextView{
    
    UIView  *labelView = [[UIView alloc]init];
    
    labelView.backgroundColor = [NSString colorWithHexString:@"#6d7278"];
    
    [self addSubview:labelView];
    
    [labelView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).with.offset(0);
        
        make.top.equalTo(self.mas_top).with.offset(5);
        
        make.width.mas_equalTo(4);
        
        make.height.mas_equalTo(4);
        
        
    }];
    
    labelView.layer.masksToBounds = YES;
    
    labelView.layer.cornerRadius = 2;
    
    
    self.textLabel = [[UILabel alloc]init];
    
    self.textLabel.text = self.textStr;
    
     self.textLabel.numberOfLines = 0;
    
    self.textLabel.font = [UIFont systemFontOfSize:12];
    
    self.textLabel.textColor = [NSString colorWithHexString:@"27292b"];
    
    [self addSubview: self.textLabel];
    
    [ self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(labelView.mas_right).with.offset(4);
        
        make.top.equalTo(self.mas_top).with.offset(0);
        
        make.width.mas_equalTo(490/2);
        
    }];
    
     [self.textLabel sizeToFit];
    
}

-(CGFloat)returnGradePrerogativeView{
    
    
    CGSize labelSize  = {0,0};
    labelSize = [self.textStr boundingRectWithSize:CGSizeMake(490/2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    //NSLog(@"labelSize===%f",labelSize.height);
    return  self.textLabel.frame.origin.y+labelSize.height;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
