//
//  ImageScrollView.h
//  CheFangTimes
//
//  Created by iOS吴 加锋 on 16/5/10.
//  Copyright © 2016年 ios侯帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageScrollView : UIView<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *myScrollView;

@property(nonatomic,strong)UIPageControl *mypageConView;

@property(nonatomic,assign)int  numberImage;

@property(nonatomic,strong)NSMutableArray *array;

//定时器
@property (weak,nonatomic)NSTimer *timer;


-(void)creatscrollViewImage:(int)numberImage  imageARR:(NSMutableArray *)imageARR;

@end
