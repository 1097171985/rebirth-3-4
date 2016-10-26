//
//  BaseCell.h
//  Cell渲染优化
//
//  Created by youme on 16/8/17.
//  Copyright © 2016年 youme. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCell : UITableViewCell

{
    UIView *contentView;
}

- (void)drawContentView:(CGRect)rect;


@end
