//
//  photographBtu.m
//  smallVideo
//
//  Created by WJF on 16/9/22.
//  Copyright © 2016年 WJF. All rights reserved.
//

#import "PhotographBtu.h"

#define  photoBtuWiDTH 100
@implementation PhotographBtu

-(instancetype)init{
    
    self = [super init];
    if (self) {
        
        [self createPhotoBtu];
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self createPhotoBtu];
    }
    
    return self;
}

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
}

-(void)createPhotoBtu{
    
    self.photoBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    NSLog(@"%f====%f",self.center.x ,self.center.y);
    self.photoBtu.center = self.center;
    [self.photoBtu setTitle:@"按住拍" forState:UIControlStateNormal];
    [self.photoBtu setTitleColor:[NSString colorWithHexString:@"29272b"] forState:UIControlStateNormal];
    self.photoBtu.titleLabel.font = [UIFont systemFontOfSize:14];
    self.photoBtu.frame = CGRectMake(self.frame.size.width/2-photoBtuWiDTH/2,self.frame.size.height/2-photoBtuWiDTH/2, photoBtuWiDTH, photoBtuWiDTH);
    self.photoBtu.backgroundColor = [UIColor whiteColor];
    self.photoBtu.layer.masksToBounds = YES;
    self.photoBtu.layer.cornerRadius = 50;
    
    [self addSubview:self.photoBtu];
    
    self.photoTimeProgressView = [[AnnularProgress alloc] initWithFrame:CGRectMake(0, 0,150, 150)];
    self.photoTimeProgressView.persentage = 0;
   // self.photoTimeProgressView.backgroundColor = [UIColor blueColor];
    [self addSubview:self.photoTimeProgressView];

    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
