//
//  WJFCollection.m
//  AFN再次封装
//
//  Created by iOS吴 加锋 on 16/5/5.
//  Copyright © 2016年 iOS吴 加锋. All rights reserved.
//

#import "WJFCollection.h"
#import "ZGCollectionReachability.h"
#import "UploadParam.h"
#import "ZGCollectionReachability.h"

@implementation WJFCollection

#pragma mark ----GET请求-----
+(void)getWithURLString:(NSString *)UrlString parameters:(id)parameters success:(WJFSuccessBlock)success failure:(WJFFailBlock)failure{
    
    //
    //    if ([ZGCollectionReachability sharedReachability].reachable ) {
    //        NSLog(@"222请检查网络连接设置！");
    //        return;
    //
    //    }
    NSString *urlstring = [UrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/javascript",@"text/html" ,nil];
    //可以接受的类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //请求的最大并发数
    //    manager.operationQueue.maxConcurrentOperationCount = 5;
    
    //请求超时的时间
    //    manager.requestSerializer.timeoutInterval = 10;
    [manager GET:urlstring parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];//转换数据格式
        success(content);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
    
}



#pragma mark -----POST请求-----
+(void)postWithUrlString:(NSString *)UrlString Parameter:(id)parameters success:(WJFSuccessBlock)success failure:(WJFFailBlock)failure{
    
    
    //    if ([ZGCollectionReachability sharedReachability].reachable ) {
    //        NSLog(@"222请检查网络连接设置！");
    //        return;
    //
    //    }
    
    NSString *urlstring = [UrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPSessionManager *maneger = [AFHTTPSessionManager manager];
    maneger.responseSerializer = [AFHTTPResponseSerializer serializer];
    maneger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/javascript",@"text/html" ,nil];
    
    [maneger POST:urlstring parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"%@",responseObject);
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];//转换数据格式
        success(content);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        NSLog(@"%@",error);
    }];
    
    
}


#pragma mark ----上传图片------
+(void)uploadWithUrlString:(NSString *)UrlString parameters:(id)parameters uploadParam:(UploadParam *)uploadParam success:(WJFSuccessBlock)success failue:(WJFFailBlock)failure{
    
    //
    //    if ([ZGCollectionReachability sharedReachability].reachable ) {
    //        NSLog(@"222请检查网络连接设置！");
    //        return;
    //
    //    }
    NSString *urlstring = [UrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/javascript", nil];
    
    [manager POST:urlstring parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.fileName mimeType:uploadParam.mimeType];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
    
    
}

#pragma mark ----多张图片上传
+(void)uploadWithUrlString:(NSString *)UrlString  withImage:(NSMutableArray *)imageArr   parameters:(id)parameters  success:(WJFSuccessBlock)success failue:(WJFFailBlock)failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [manager POST:UrlString
       parameters:parameters
constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    for (int i = 0; i < imageArr.count; i++) {
        UIImage *image = imageArr[i];
        NSData *eachImgData= UIImageJPEGRepresentation(image, 0.5);
        [formData appendPartWithFileData:eachImgData name:[NSString stringWithFormat:@"%d",i] fileName:[NSString stringWithFormat:@"image.jpg"] mimeType:
         [NSString stringWithFormat:@"image/jpeg"]];
        
        
    }
}progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];//转换数据格式
    success(content);
    
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    failure(error);
}];
    
}


#pragma mark ----上传图片和视频------
+(void)uploadWithUrlString:(NSString *)UrlString  withImage:(UIImage *)image  withVideo:(NSURL *)videourl parameters:(id)parameters uploadParam:(UploadParam *)uploadParam success:(WJFSuccessBlock)success failue:(WJFFailBlock)failure{
    
    NSMutableArray *a = [NSMutableArray array];
    
    NSMutableArray *b = [NSMutableArray array];
    
    NSMutableArray *c  = [NSMutableArray array];
    
    
    a = (NSMutableArray *)@[@"image",@"jpeg",@"jpg"];
    
    b = (NSMutableArray *)@[@"video",@"mp4",@"mp4"];
    
    [c addObject:a];
    [c addObject:b];
    NSLog(@"%@",videourl);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [manager POST:UrlString
       parameters:parameters
constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    for (int i = 0; i < 2; i++) {
        NSData *eachImgData;
        if ([c[i][0] isEqualToString:@"image"]) {
            eachImgData = UIImageJPEGRepresentation(image, 0.5);
            
        }else{
            
            eachImgData = [NSData dataWithContentsOfURL:videourl];
            
            //NSLog(@"%@=== %@",eachImgData,videourl);
            
        }
        
        [formData appendPartWithFileData:eachImgData name:[NSString stringWithFormat:@"%d",i] fileName:[NSString stringWithFormat:@"%@.%@",c[i][0],c[i][2]] mimeType:
         [NSString stringWithFormat:@"%@/%@",c[i][0],c[i][1]]];
        
    }
}progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];//转换数据格式
    success(content);
    
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    failure(error);
}];
    
}



#pragma MARK -----POST/GE网络请求-----
+(void)requestWithUrlString:(NSString *)UrlString parameters:(id)parameters type:(HttpRequestType)type success:(WJFSuccessBlock)success failure:(WJFFailBlock)failure{
    
    // manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/javascript", nil];
    switch (type) {
        case HttpRequestTypeGet:{
            [self getWithURLString:UrlString parameters:parameters success:^(id responseObject) {
                
                success(responseObject);
                
            } failure:^(NSError *error) {
                
                failure(error);
            }];
        }
            break;
        case HttpRequestTypePost:{
            [self postWithUrlString:UrlString Parameter:parameters success:^(id responseObject) {
                success(responseObject);
            } failure:^(NSError *error) {
                failure(error);
            }];
        }
            break;
    }
    
}
@end
