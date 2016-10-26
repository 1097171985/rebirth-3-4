//
//  InsetLabel.m
//  rebirth
//
//  Created by boom on 16/8/23.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "InsetLabel.h"

@implementation InsetLabel

//初始化方法一
-(id) initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets)neiinsets {
    self = [super initWithFrame:frame];
    if(self){
        self.neiinsets = neiinsets;
    }
    return self;
}
//初始化方法二
-(id) initWithInsets:(UIEdgeInsets)neiinsets {
    self = [super init];
    if(self){
        self.neiinsets = neiinsets;
    }
    return self;
}
//重载drawTextInRect方法
-(void) drawTextInRect:(CGRect)rect {
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.neiinsets)];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    UIEdgeInsets insets = self.neiinsets;
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, insets)
                    limitedToNumberOfLines:numberOfLines];
    
    rect.origin.x    -= insets.left;
    rect.origin.y    -= insets.top;
    rect.size.width  += (insets.left + insets.right);
    rect.size.height += (insets.top + insets.bottom);
    
    return rect;
}

@end
