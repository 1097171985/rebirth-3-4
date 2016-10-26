//
//  DownList.m
//  DownList
//
//  Created by zy on 15/1/27.
//  Copyright (c) 2015年 yukexin. All rights reserved.
//

#import "DownList.h"
#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface DownList()
{
    UIView *downView;
    UIButton *bnt;
    UILabel *titileLabel;
    CGRect frameDown;
    NSString *myidenty;
}
@end

@implementation DownList

-(id)initWithFrame:(CGRect)frame Nsarry:(NSArray *)modearr Delegate:(id)delegate AndIdenty:(NSString *)identy{

    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 2.0;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [NSString colorWithHexString:@"cccccc"].CGColor;
        myidenty = identy;
        frameDown = frame;
        self.arr = modearr;
        self.delegate = delegate;
       _toplabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, frame.size.width-10, frame.size.height)];
//        _toplabel.text = modearr[0];
        _toplabel.textColor = [NSString colorWithHexString:heitizi];
        _toplabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_toplabel];
       bnt = [UIButton buttonWithType:UIButtonTypeCustom];
        bnt.frame = CGRectMake(frame.size.width-15, 15, 10, 4);
        bnt.tag = 1000;
        [bnt setImage:[UIImage imageNamed:@"icon_arrow_02"] forState:UIControlStateNormal];
        [self addSubview:bnt];
        
        [bnt addTarget:self action:@selector(clicktop:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        imageview.alpha = 0.4;
        imageview.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapL = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicktop:)];
        [imageview addGestureRecognizer:tapL];
        [self addSubview:imageview];
        
        
        
    }
    return self;
}
-(void)clicktop:(UIButton *)sender{
    for (UIView *view in self.baseView.subviews) {
        UIView *view1 = [view viewWithTag:10000];
        [view1 removeFromSuperview];
    }
    for (UIView *view in self.baseview1.subviews) {
        UIView *view1 = [view viewWithTag:10000];
        [view1 removeFromSuperview];
    }

    
    if (bnt.tag == 1000) {
       
        
        if (downView == nil) {
            downView = [[UIView alloc]initWithFrame:CGRectMake(frameDown.origin.x, frameDown.origin.y+frameDown.size.height+2, frameDown.size.width, 35*self.arr.count)];
            downView.layer.borderWidth = 1;
            downView.layer.borderColor = [NSString colorWithHexString:@"cccccc"].CGColor;
            downView.backgroundColor = [NSString colorWithHexString:@"f5f5f5"];
            downView.tag = 10000;
            for (int i = 0; i<self.arr.count; i++) {
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(3, 3+(35*i), frameDown.size.width-10, frameDown.size.height/self.arr.count+10)];
                            label.text = self.arr[i];
                label.textColor = [NSString colorWithHexString:@"808080"];
                label.tag = i+1000;
                label.font = [UIFont systemFontOfSize:12];
                            label.userInteractionEnabled = YES;
                            [downView addSubview:label];
                            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
                            [label addGestureRecognizer:tap];
            }
            [self.baseView addSubview:downView];
            bnt.tag++;
        


        }
            }else{
                bnt.tag--;
                [downView removeFromSuperview];
                downView = nil;
        
    }
}
-(void)click:(UITapGestureRecognizer *)sender{

    _toplabel.text = self.arr[sender.view.tag-1000];
    if ([self.delegate respondsToSelector:@selector(downlistTap:Andidenty:)]) {
        [self.delegate downlistTap:_toplabel.text Andidenty:myidenty];
    }
    [downView removeFromSuperview];
    downView = nil;
    bnt.tag--;
    
   }

@end
