//
//  LXSegmentScrollView.m
//  LiuXSegment
//
//  Created by liuxin on 16/5/17.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#define MainScreen_W [UIScreen mainScreen].bounds.size.width

#import "LXSegmentScrollView.h"


@interface LXSegmentScrollView()<UIScrollViewDelegate>



@end

@implementation LXSegmentScrollView


-(instancetype)initWithFrame:(CGRect)frame
                  titleArray:(NSArray *)titleArray
            contentViewArray:(NSArray *)contentViewArray{
    if (self = [super initWithFrame:frame]) {
        
        
        [self createBgScrollView:(int)contentViewArray.count];
       // [self addSubview:self.bgScrollView];
        

        _segmentToolView=[[LiuXSegmentView alloc] initWithFrame:CGRectMake(0, 0, MainScreen_W, 44) titles:titleArray clickBlick:^void(NSInteger index) {
            NSLog(@"-----%ld",index);
            [_bgScrollView setContentOffset:CGPointMake(MainScreen_W*(index-1), 0)];
        }];
        [self addSubview:_segmentToolView];
        
        
        for (int i=0;i<contentViewArray.count; i++ ) {
            
            UIView *contentView = (UIView *)contentViewArray[i];
            contentView.frame=CGRectMake(MainScreen_W * i, _segmentToolView.bounds.size.height, MainScreen_W, _bgScrollView.frame.size.height-_segmentToolView.bounds.size.height);
            [_bgScrollView addSubview:contentView];
        }
        
        
    }
    
    return self;
}


-(void)createBgScrollView:(int)count{
    
    if (!_bgScrollView) {
        _bgScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, _segmentToolView.frame.size.height, MainScreen_W, self.bounds.size.height-_segmentToolView.bounds.size.height)];
        _bgScrollView.contentSize=CGSizeMake(MainScreen_W*count, self.bounds.size.height-_segmentToolView.bounds.size.height);
        _bgScrollView.backgroundColor=[UIColor brownColor];
        _bgScrollView.showsVerticalScrollIndicator=NO;
        _bgScrollView.showsHorizontalScrollIndicator=NO;
        _bgScrollView.delegate=self;
        _bgScrollView.bounces=NO;
        _bgScrollView.pagingEnabled=YES;
    }
    
    [self addSubview:self.bgScrollView];
}



//-(UIScrollView *)bgScrollView{
//    if (!_bgScrollView) {
//        _bgScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, _segmentToolView.frame.size.height, MainScreen_W, self.bounds.size.height-_segmentToolView.bounds.size.height)];
//        _bgScrollView.contentSize=CGSizeMake(MainScreen_W*3, self.bounds.size.height-_segmentToolView.bounds.size.height);
//        _bgScrollView.backgroundColor=[UIColor brownColor];
//        _bgScrollView.showsVerticalScrollIndicator=NO;
//        _bgScrollView.showsHorizontalScrollIndicator=NO;
//        _bgScrollView.delegate=self;
//        _bgScrollView.bounces=NO;
//        _bgScrollView.pagingEnabled=YES;
//    }
//    return _bgScrollView;
//}



-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView==_bgScrollView)
    {
        NSInteger p=_bgScrollView.contentOffset.x/MainScreen_W;
        _segmentToolView.defaultIndex=p+1;
        
    }
    
}

@end
