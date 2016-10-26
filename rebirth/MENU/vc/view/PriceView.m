//
//  PriceView.m
//  rebirth
//
//  Created by WJF on 16/9/20.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "PriceView.h"

@implementation PriceView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self creatView];
        
    }
    
    return self;
}

-(void)creatView{
    
    UILabel  *henxian = [[UILabel alloc]initWithFrame:CGRectMake(62*WIDTHRATIO,(54/2+15)*HEIGHTRATIO,470/2*WIDTHRATIO, 2)];
    
    henxian.backgroundColor = [NSString colorWithHexString:@"#f2f2f2"];
    
    [self addSubview:henxian];
    
    //
    self.fiveImage = [[UIImageView alloc]initWithFrame:CGRectMake(60*WIDTHRATIO, 56/2*HEIGHTRATIO, 30*HEIGHTRATIO, 30*HEIGHTRATIO)];
    
    self.fiveImage.image = [UIImage imageNamed:@"price_range_1"];
    
    [self addSubview:self.fiveImage];
    
    //
    self.tenImage = [[UIImageView alloc]initWithFrame:CGRectMake(henxian.frame.origin.x+henxian.frame.size.width/2, 56/2*HEIGHTRATIO, 30*HEIGHTRATIO, 30*HEIGHTRATIO)];
    
    self.tenImage.image = [UIImage imageNamed:@"price_range_0"];
   
    [self addSubview:self.tenImage];

    //
    self.fifteenImage = [[UIImageView alloc]initWithFrame:CGRectMake(henxian.frame.origin.x+henxian.frame.size.width-2,  56/2*HEIGHTRATIO, 30*HEIGHTRATIO, 30*HEIGHTRATIO)];
    
    self.fifteenImage.image = [UIImage imageNamed:@"price_range_0"];
    [self addSubview:self.fifteenImage];

    self.fiveLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.fiveLabel.text = @"¥5000";
    self.fiveLabel.font = [UIFont systemFontOfSize:14];
    [self.fiveLabel sizeToFit];
    [self addSubview:self.fiveLabel];
    [self.fiveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.fiveImage.mas_bottom).with.offset(4);
        
        make.centerX.equalTo(self.fiveImage.mas_centerX);
        
        
    }];
    
    
    self.tenLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.tenLabel.text = @"¥10000";
    self.tenLabel.font = [UIFont systemFontOfSize:14];
    [self.tenLabel sizeToFit];
    [self addSubview:self.tenLabel];
    [self.tenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.fiveImage.mas_bottom).with.offset(4);
        
        make.centerX.equalTo(self.tenImage.mas_centerX);
        
        
    }];

    
    self.fifteenLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.fifteenLabel.text = @"¥15000";
    [self.fifteenLabel sizeToFit];
    self.fifteenLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.fifteenLabel];
    [self.fifteenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.fiveImage.mas_bottom).with.offset(4);
        
        make.centerX.equalTo(self.fifteenImage.mas_centerX);
        
        
    }];
    
     
    
    

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
