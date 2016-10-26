//
//  android.h
//  TetsuyaStudentsApp
//
//  Created by apple on 16/4/8.
//  Copyright © 2016年 张利坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
//首先创建一个实现了JSExport协议的协议
@protocol TestJSObjectProtocol <JSExport>

//此处我们测试几种参数的情况
-(void)pickSource;
-(void)pickSource:(NSString *)message;
-(void)pickSource:(NSString *)message1 SecondParameter:(NSString *)message2;
-(void)share:(NSString *)message;
@end

@interface android : NSObject<TestJSObjectProtocol>
@property(nonatomic,copy)void(^htmlBack)(NSString *str);


@end
