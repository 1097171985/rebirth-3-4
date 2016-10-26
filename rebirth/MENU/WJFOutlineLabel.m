//
//  WJFOutlineLabel.m
//  rebirth
//
//  Created by boom on 16/8/5.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "WJFOutlineLabel.h"

@implementation WJFOutlineLabel

- (void)drawTextInRect:(CGRect)rect {
    
    CGSize shadowOffset = self.shadowOffset;
    UIColor *textColor = self.textColor;
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(c, self.outLineWidth);
    
    CGContextSetLineJoin(c, kCGLineJoinRound);
    
    CGContextSetTextDrawingMode(c, kCGTextStroke);
    
    self.textColor = self.outLinetextColor;
    
    [super drawTextInRect:rect];
    
    self.textColor = textColor;
    
    CGContextSetTextDrawingMode(c, kCGTextFill);
    
    [super drawTextInRect:rect];
    
    self.shadowOffset = shadowOffset;
}

@end
