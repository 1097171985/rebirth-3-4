//
//  WJFCollection.h
//  AFN再次封装
//
//  Created by iOS吴 加锋 on 16/5/5.
//  Copyright © 2016年 iOS吴 加锋. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFNetworking.h>

@class UploadParam;//引用


typedef void(^WJFSuccessBlock)(id responseObject);
typedef void(^WJFFailBlock)(NSError *error);
//网络请求的类型
typedef NS_ENUM(NSUInteger,HttpRequestType){
    
    //get请求方式
    HttpRequestTypeGet = 0,
    
    //post 请求方式
    HttpRequestTypePost
};


@interface WJFCollection : NSObject


//发送get请求方式
+ (void)getWithURLString:(NSString *)UrlString
              parameters:(id)parameters
                 success:(WJFSuccessBlock)success
                 failure:(WJFFailBlock)failure;


//发送post请求方式
+(void)postWithUrlString:(NSString *)UrlString Parameter:(id)parameters success:(WJFSuccessBlock)success  failure:(WJFFailBlock)failure;



//发送网络请求
+(void)requestWithUrlString:(NSString *)UrlString parameters:(id)parameters type:(HttpRequestType)type success:(WJFSuccessBlock)success failure:(WJFFailBlock)failure;


//上传图片
+(void)uploadWithUrlString:(NSString *)UrlString parameters:(id )parameters uploadParam:(UploadParam *)uploadParam success:(WJFSuccessBlock)success failue:(WJFFailBlock)failure;
+(void)uploadWithUrlString:(NSString *)UrlString  withImage:(NSMutableArray *)imageArr   parameters:(id)parameters  success:(WJFSuccessBlock)success failue:(WJFFailBlock)failure;
+(void)uploadWithUrlString:(NSString *)UrlString  withImage:(UIImage *)image  withVideo:(NSURL *)videourl parameters:(id)parameters uploadParam:(UploadParam *)uploadParam success:(WJFSuccessBlock)success failue:(WJFFailBlock)failure;
@end
