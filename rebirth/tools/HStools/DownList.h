//
//  DownList.h
//  DownList
//
//  Created by zy on 15/1/27.
//  Copyright (c) 2015年 yukexin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DownlistDelegate <NSObject>

-(void)downlistTap:(NSString *)selectlabel Andidenty:(NSString *)identy;

@end



@interface DownList : UIView
-(id)initWithFrame:(CGRect)frame Nsarry:(NSArray *)modearr Delegate:(id)delegate AndIdenty:(NSString *)identy;
@property(nonatomic,strong)id<DownlistDelegate>delegate;
@property(nonatomic,strong)NSArray *arr;
@property(nonatomic,strong)UIView *baseView;
@property(nonatomic,strong)    UILabel *toplabel;
@property(nonatomic,strong)UIView *baseview1;

@end


