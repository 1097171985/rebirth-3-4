//
//  android.m
//  TetsuyaStudentsApp
//
//  Created by apple on 16/4/8.
//  Copyright © 2016年 张利坤. All rights reserved.
//

#import "android.h"

@implementation android
//一下方法都是只是打了个log 等会看log 以及参数能对上就说明js调用了此处的iOS 原生方法
-(void)pickSource
{
    NSLog(@"this is ios TestNOParameter");
    self.htmlBack(@"pickSource");
    
}
-(void)share:(NSString *)message{
    self.htmlBack(message);

}

-(void)pickSource:(NSString *)message
{
    NSLog(@"this is ios TestOneParameter=%@",message);
}
-(void)pickSource:(NSString *)message1 SecondParameter:(NSString *)message2
{
    NSLog(@"this is ios TestTowParameter=%@  Second=%@",message1,message2);
}
@end
