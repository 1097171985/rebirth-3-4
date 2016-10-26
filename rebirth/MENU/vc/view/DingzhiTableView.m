//
//  DingzhiTableView.m
//  rebirth
//
//  Created by boom on 16/7/19.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "DingzhiTableView.h"

@implementation DingzhiTableView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.selectedView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 61)];
        
        self.selectedView1.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.selectedView1];
        
        
        [self.selectedView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(WIDTH);
            make.top.equalTo(self.mas_top).with.offset(0);
            
            make.left.equalTo(self.mas_left).with.offset(0);
            
            make.height.mas_equalTo(44);
            
            
        }];
        
        [self  creatDingZhiView];
        
    }
    return self;
}

-(void)creatDingZhiView{
    
    
 
    
    
    self.dingzhiView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.selectedView1.frame.origin.y+self.selectedView1.frame.size.height,WIDTH,self.frame.size.height-self.selectedView1.frame.size.height)];
    
    
   
    [self addSubview:self.dingzhiView];
    
    [self.dingzhiView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.width.mas_equalTo(WIDTH);
        
        make.top.equalTo(self.selectedView1.mas_bottom).with.offset(8);
        
        make.left.equalTo(self.mas_left).with.offset(0);
        
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
        
        
    }];
}
@end
