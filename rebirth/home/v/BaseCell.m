//
//  BaseCell.m
//  Cell渲染优化
//
//  Created by youme on 16/8/17.
//  Copyright © 2016年 youme. All rights reserved.
//

#import "BaseCell.h"

@interface HRCellView : UIView

@end

@implementation HRCellView

- (void)drawRect:(CGRect)rect
{
    [(BaseCell *)[self superview] drawContentView:rect];
}

@end


@implementation BaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // 调用 HRCellView
        contentView = [[HRCellView alloc] init];
        contentView.opaque = YES;//不透明，提升渲染性能
        [self addSubview:contentView];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    CGRect b = [self bounds];
    b.size.height -= 1;
    contentView.frame = b;
}

- (void)setNeedsDisplay
{
    [super setNeedsDisplay];
    [contentView setNeedsDisplay];
}

- (void)drawContentView:(CGRect)rect
{
    //子类实现
}


@end
