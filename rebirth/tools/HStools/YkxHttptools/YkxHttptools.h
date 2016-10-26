//
//  YkxHttptools.h
//  程序截图
//
//  Created by zy on 15/3/20.
//  Copyright (c) 2015年 yukexin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YkxHttptools : NSObject
/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
 + (void)get:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;

 /**
  *  发送一个POST请求
  *
  *  @param url     请求路径
  *  @param params  请求参数
  *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
  *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
  */




 + (void)post:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;
/**
 *  发送一个POST图片请求
 *
 *  @param url     请求路径
 *  @param imageData     图片或者音频文件
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */

+ (void)upload:(NSString *)url params:(NSDictionary *)params imageData:(NSData*)imageData success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;
//多长图片上传
+(void)upload:(NSString *)url parmas:(NSDictionary *)params imageDataArray:(NSMutableArray *)imageDataArray success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;


+ (void)postnew:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;
+(UIButton *)initwithButton:(UIColor *)backcolor Frame:(CGRect)frame Image:(UIImage *)image Title:(NSString *)title Titlecolor:(UIColor *)titlecolor Titlefont:(UIFont *)font BaseView:(UIView *)baseview;
+(UIButton *)initwithButton:(UIColor *)backcolor Image:(UIImage *)image Title:(NSString *)title Titlecolor:(UIColor *)titlecolor Titlefont:(UIFont *)font BaseView:(UIView *)baseview;
+(UIImageView *)initwithImageView:(UIColor *)color Image:(UIImage *)image Frame:(CGRect)frame Tap:(UITapGestureRecognizer *)tap BaseView:(UIView *)baseview;
+(UITableView *)initwithTable:(UIColor *)color Frame:(CGRect)frame DelegateAndDatasouce:(id)object BaseView:(UIView *)baseview;
+(UIView *)initwithView:(UIColor *)color Frame:(CGRect)frame  BaseView:(UIView *)baseview;

+(UILabel *)initwithLabel:(UIFont *)font Color:(UIColor *)color text:(NSString *)text Frame:(CGRect)frame NSTextAlignment:(NSTextAlignment)alignment BaseView:(UIView *)baseview;
+(UILabel *)initwithLabel:(UIFont *)font Color:(UIColor *)color text:(NSString *)text NSTextAlignment:(NSTextAlignment)alignment BaseView:(UIView *)baseview;

+(BOOL)isValidateString:(NSString *)myString;

+(BOOL)isValidateEmail:(NSString *)email;
+(NSString *)getCurrentDate;
+(NSString *)createMD5:(NSString *)signString;
+(UITextField *)initwithTefield:(UIColor *)backcolor Frame:(CGRect)frame Text:(NSString *)text NSTextAlignment:(NSTextAlignment)alignment Placeholder:(NSString *)placeholder BaseView:(UIView *)baseview;
+(UIAlertView *)initwithAlertview:(NSString *)noticeStr Amount:(NSInteger)amount Delegate:(id)object;

+ (BOOL)isMobileNumber:(NSString *)mobileNum;

/*
 //    NSString *urlstr = [NSString stringWithFormat:@"%@/Get_Card_Type_List",menu];
 //    NSURL *url = [NSURL URLWithString:urlstr];
 //    NSMutableURLRequest *urlrequest = [[NSMutableURLRequest alloc]initWithURL:url];
 //    urlrequest.HTTPMethod = @"POST";
 //    NSString *bodyStr = @"MaxRowNums=0&PageSize=12";
 //    NSLog(@"%@",bodyStr);
 //    NSData *body = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
 //    urlrequest.HTTPBody = body;
 //    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlrequest];
 //    requestOperation.responseSerializer = [AFHTTPResponseSerializer serializer];
 //    [requestOperation start];
 //    [requestOperation waitUntilFinished];
 //    NSLog(@"%@",requestOperation.responseString);

 
 */
+(NSString *)replaceWithsysTabStr:(NSString *)string;
+(int)trueOrfalse:(NSDictionary *)dic;
+(NSString *)intervalSinceNow: (NSString *) theDate;
+(UIViewController *)goFor:(UITableViewCell *)cell;
+(NSString *)repTabStr:(NSString *)requestStr;

+(NSString *)StrTabrep:(NSString *)requestStr;
+ (NSString*)fromDateToAge:(NSDate*)date;
//压缩图片至100k
+(NSData *)imageData:(UIImage *)myimage;
+ (NSString *)randomUUID;

@end
