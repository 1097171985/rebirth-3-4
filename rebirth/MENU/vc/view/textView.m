//
//  textView.m
//  DiscountCoupon
//
//  Created by WJF on 16/9/27.
//  Copyright © 2016年 WJF. All rights reserved.
//

#import "textView.h"

@implementation textView

-(void)drawRect:(CGRect)rect{
    
        //2.a.3把路径添加到上下文中
    //1.获取图形上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    for (int i = 0; i < self.frame.size.height/12; i++) {
        
        //2.绘图
        //2.a 画一条直线
        //2.a.1创建一条绘图的路径
        //注意：但凡通过Quartz2D中带有creat/copy/retain方法创建出来的值都必须要释放
//        CGMutablePathRef path=CGPathCreateMutable();
//        
//        //2.a.2把绘图信息添加到路径里
//        CGPathMoveToPoint(path, NULL,0, 0+35*i);
//        CGPathAddLineToPoint(path, NULL, 0, 10+35*i);
//        //把绘制直线的绘图信息保存到图形上下文中
//        CGContextAddPath(ctx, path);
        
        //2.b画一个圆
        //2.b.1创建一条画圆的绘图路径(注意这里是可变的，不是CGPathRef)
        CGMutablePathRef path1=CGPathCreateMutable();
    
        CGPathAddArc(path1, NULL,0,8+12*i, 4, -M_PI,M_PI, NO);
        CGContextAddPath(ctx, path1);
   
        CGMutablePathRef path2=CGPathCreateMutable();
    
       //2.a.2把绘图信息添加到路径里
//       CGPathMoveToPoint(path2, NULL, 0,30+35*i);
//       CGPathAddLineToPoint(path2, NULL,0,35+35*i);
//    
//       //2.a.3把路径添加到上下文中
//      //把绘制直线的绘图信息保存到图形上下文中
//       CGContextAddPath(ctx, path2);
        
    }
    
     CGMutablePathRef path=CGPathCreateMutable();
    //2.a.2把绘图信息添加到路径里
      CGPathMoveToPoint(path, NULL, 0, 0);
//    CGPathAddLineToPoint(path, NULL,20,0);
//    CGPathAddLineToPoint(path, NULL,20, self.frame.size.height);
      CGPathAddLineToPoint(path, NULL,0, self.frame.size.height);
    
      //把绘制直线的绘图信息保存到图形上下文中
      CGContextAddPath(ctx, path);
    
       //3.渲染
       //CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    
       // CGContextSetFillColorWithColor(ctx, [UIColor yellowColor].CGColor);
       [[NSString colorWithHexString:@"f2f2f2"] setFill];
       // [[UIColor redColor] set];
       // CGContextFillPath(ctx);
      // CGContextStrokePath(ctx);
    
       CGContextDrawPath(ctx, kCGPathFill);
        //4.释放前面创建的两条路径
        //第一种方法
//        CGPathRelease(path);
//        CGPathRelease(path1);
    
 
        //第二种方法
        CFRelease(path);
    }



@end
