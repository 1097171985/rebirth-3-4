//
//  DisProView.h
//  简单朋友圈
//
//  Created by WJF on 16/10/10.
//  Copyright © 2016年 WJF. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DisProBlock)(UILabel *label);


@interface DisProView : UIView

@property (nonatomic,strong)DisProBlock  block;

@property(nonatomic, strong)UILabel  *name1Label;

@property(nonatomic, strong)NSMutableArray  *disProArray;

@property(nonatomic, assign)CGFloat  lastLabelheight;

-(instancetype)initWithFrame:(CGRect)frame  withDisPro:(NSMutableArray *)disProArr;

@end
