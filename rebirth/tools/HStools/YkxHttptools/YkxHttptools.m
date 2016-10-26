//
//  YkxHttptools.m
//  程序截图
//
//  Created by zy on 15/3/20.
//  Copyright (c) 2015年 yukexin. All rights reserved.
//

#import "YkxHttptools.h"
#import "AFNetworking.h"
#import <CommonCrypto/CommonCryptor.h>//用于加密算法
#import <CommonCrypto/CommonDigest.h>//用于加密算法
@implementation YkxHttptools
+(void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
         //1.获得请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//        manager.requestSerializer.timeoutInterval = 10.f;
//        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 请求成功，解析数据
        // 开启线程
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if (success)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(responseObject);
                });
            }
        });
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        
    }];
//         [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObj) {
//                 if (success) {
//                         success(responseObj);
//                     }
//             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                     if (failure) {
//                             failure(error);
//                         }
//                 }];
    }

 +(void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
 {
     
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
     manager.requestSerializer.timeoutInterval = 10.f;
     //2.发送post请求
     [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         if (success) {
                success(responseObject);
                    }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         if (failure) {
                failure(error);
            }
     }];

         //1.获得请求管理者
//         AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
//     manager.requestSerializer.timeoutInterval = 10.f;
//         //2.发送Post请求
//         [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObj) {
//                if (success) {
//                         success(responseObj);
//                     }
//             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                     if (failure) {
//                             failure(error);
//                         }
//                 }];
    
     }
+(void)postnew:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    //1.获得请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10.f;
    //2.发送Post请求
    
    //2.发送post请求
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
//    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObj) {
//        if (success) {
//            
//            
//            
//            
//            success(responseObj);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
    
}
+(void)upload:(NSString *)url parmas:(NSDictionary *)params imageDataArray:(NSMutableArray *)imageDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure{
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager POST:url
       parameters:params
constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    for (int i = 0; i < imageDataArray.count; i++) {
        UIImage *image = imageDataArray[i];
        NSData *eachImgData = UIImageJPEGRepresentation(image, 0.5);
            
       
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
+ (void)upload:(NSString *)url params:(NSDictionary *)params imageData:(NSData*)imageData success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    //可选参数添加
    //    NSDictionary *params =@{@"参数1":@"value1",@"参数2":@"value2"};
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //显示在服务器上面的名字
        [formData appendPartWithFileData :imageData name:@"ChongIcon" fileName:@"ChongIcon.png" mimeType:@"image/jpeg"];

    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
            
         }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
//    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        //显示在服务器上面的名字
//        [formData appendPartWithFileData :imageData name:@"ChongIcon" fileName:@"ChongIcon.png" mimeType:@"image/jpeg"];
//        
//    } success:^(AFHTTPRequestOperation *operation,id responseObj) {
//        
//        if (success) {
//            success(responseObj);
//
//        }
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation,NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//        
//        NSLog(@"Error: %@", error);
//        
//    }];
    
    
    
    
}
//md5加密
+(NSString *)createMD5:(NSString *)signString
{
    const char*cStr =[signString UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    return[NSString stringWithFormat:
           @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
           result[0], result[1], result[2], result[3],
           result[4], result[5], result[6], result[7],
           result[8], result[9], result[10], result[11],
           result[12], result[13], result[14], result[15]
           ];
}
//获得系统当前时间

+(NSString *)getCurrentDate
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init] ;
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//        [dateFormatter setDateFormat:@"yyyy-MM-dd"];

        [dateFormatter setDateFormat:@"MM-dd"];

    return [dateFormatter stringFromDate:[NSDate date]];
}





//利用正则表达式验证
+(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
//检测是否包含特殊字符
+(BOOL)isValidateString:(NSString *)myString
{
    NSCharacterSet *nameCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"] invertedSet];
    NSRange userNameRange = [myString rangeOfCharacterFromSet:nameCharacters];
    if (userNameRange.location != NSNotFound) {
        //NSLog(@"包含特殊字符");
        return FALSE;
    }else{
        return TRUE;
    }
    
}
+(UILabel *)initwithLabel:(UIFont *)font Color:(UIColor *)color text:(NSString *)text Frame:(CGRect)frame NSTextAlignment:(NSTextAlignment)alignment BaseView:(UIView *)baseview{
    UILabel *lab = [[UILabel alloc]initWithFrame:frame];
    lab.font = font;
    lab.text = text;
    lab.backgroundColor = [UIColor clearColor];
    lab.textAlignment = alignment;
    lab.textColor = color;
    [baseview addSubview:lab];
    return lab;
}
+(UILabel *)initwithLabel:(UIFont *)font Color:(UIColor *)color text:(NSString *)text NSTextAlignment:(NSTextAlignment)alignment BaseView:(UIView *)baseview{
    UILabel *lb = [[UILabel alloc] init];
    lb.font = font;
    lb.text = text;
    lb.backgroundColor = [UIColor clearColor];
    lb.textAlignment = alignment;
    lb.textColor = color;
    [baseview addSubview:lb];
    return lb;
}
+(UIView *)initwithView:(UIColor *)color Frame:(CGRect)frame  BaseView:(UIView *)baseview{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = color;
    [baseview addSubview:view];
    return view;
}
+(UITableView *)initwithTable:(UIColor *)color Frame:(CGRect)frame DelegateAndDatasouce:(id)object BaseView:(UIView *)baseview{
    UITableView *tableview = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
    tableview.delegate = object;
    tableview.backgroundColor = color;
    tableview.dataSource = object;
    [baseview addSubview:tableview];
    return tableview;
}
+(UIImageView *)initwithImageView:(UIColor *)color Image:(UIImage *)image Frame:(CGRect)frame Tap:(UITapGestureRecognizer *)tap BaseView:(UIView *)baseview{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.backgroundColor = color;
    imageView.frame = frame;
//    [imageView addGestureRecognizer:tap];
    [baseview addSubview:imageView];
    return imageView;
    
    
    
}
+(UIButton *)initwithButton:(UIColor *)backcolor Frame:(CGRect)frame Image:(UIImage *)image Title:(NSString *)title Titlecolor:(UIColor *)titlecolor Titlefont:(UIFont *)font BaseView:(UIView *)baseview{
    UIButton *bnt = [UIButton buttonWithType:UIButtonTypeCustom];
    [bnt setFrame:frame];
    bnt.layer.cornerRadius = 2;
    bnt.titleLabel.font = font;
    bnt.backgroundColor = backcolor;
    [bnt setTitle:title forState:UIControlStateNormal];
    [bnt setTitleColor:titlecolor forState:UIControlStateNormal];
    [bnt setImage:image forState:UIControlStateNormal];
    [baseview addSubview:bnt];
    return bnt;
}
+(UIButton *)initwithButton:(UIColor *)backcolor Image:(UIImage *)image Title:(NSString *)title Titlecolor:(UIColor *)titlecolor Titlefont:(UIFont *)font BaseView:(UIView *)baseview{
    UIButton *bnt = [UIButton buttonWithType:UIButtonTypeCustom];
    bnt.layer.cornerRadius = 2;
    bnt.titleLabel.font = font;
    bnt.backgroundColor = backcolor;
    [bnt setTitle:title forState:UIControlStateNormal];
    [bnt setTitleColor:titlecolor forState:UIControlStateNormal];
    [bnt setImage:image forState:UIControlStateNormal];
    [baseview addSubview:bnt];
    return bnt;
}
+(UITextField *)initwithTefield:(UIColor *)backcolor Frame:(CGRect)frame Text:(NSString *)text NSTextAlignment:(NSTextAlignment)alignment Placeholder:(NSString *)placeholder BaseView:(UIView *)baseview{
    UITextField *textfield = [[UITextField alloc]initWithFrame:frame];
    textfield.backgroundColor = backcolor;
    textfield.text = text;
    textfield.textAlignment = alignment;
    textfield.placeholder = placeholder;
    [baseview addSubview:textfield];
    return textfield;
}
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,183,184,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0125-9])\\d{8}$";
    NSString *MOBILE1 = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,147,150,151,157,158,159,182,187,188,178,1705
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|4[7]|5[017-9]|8[23478]|78)\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186,176,1709
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56]|76)\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,181,177,1700
     22         */
    NSString * CT = @"^1((33|53|8[019]|77)[0-9]|349|70[059])\\d{7}$";
    //178 1705 1709 176  177 1700
    NSString *newMobile = @"^17(8[0-9]|0[059]|6[0-9]|7[0-9])\\d{7}$";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextesnewMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", newMobile];
    NSPredicate *regextesnewMobile1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE1];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)
        || ([regextesnewMobile evaluateWithObject:mobileNum] == YES)
        ||([regextesnewMobile1 evaluateWithObject:mobileNum]==YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//过滤掉输入时产生的系统制表符
+(NSString *)replaceWithsysTabStr:(NSString *)requestStr{
    requestStr = [requestStr stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    requestStr = [requestStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    requestStr = [requestStr stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    return requestStr;
}
+(int)trueOrfalse:(NSDictionary *)dic{
    if ([[dic objectForKey:@"code"] isEqualToString:@"0001"]) {
        return 1;
    }else{
        return 0;
    }
}


//一个时间距现在的时间

+(NSString *)intervalSinceNow: (NSString *) theDate
{
    NSArray *timeArray=[theDate componentsSeparatedByString:@"."];
    theDate=[timeArray objectAtIndex:0];
    //    以下是时区转换的相关内容
    NSDateFormatter *date = [[NSDateFormatter alloc] init];
    date.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [date setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    date.dateFormat = @"yyyy-MM-dd HH:mm:ss";

//    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    
//    [date setTimeZone:timeZone];

    NSDate *d=[date dateFromString:theDate];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    NSDate *dat = [NSDate date];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: dat];
    
    NSDate *localeDate = [dat  dateByAddingTimeInterval: interval];
    
    NSTimeInterval now=[localeDate timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha=now-late;
    
    if (cha/3600<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@分", timeString];
        
    }
    if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时", timeString];
    }
    if (cha/86400>1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天", timeString];
        
    }
    return timeString;
}
+(UIViewController *)goFor:(UITableViewCell *)cell{
    id object = [cell nextResponder];
    while (![object isKindOfClass:[UIViewController class]] &&object != nil) {
        
        object = [object nextResponder];
        
    }
    UIViewController *uc=(UIViewController*)object;
    
    return uc;
    
}
+(NSString *)repTabStr:(NSString *)requestStr{
    requestStr = [requestStr stringByReplacingOccurrencesOfString:@"\r\n" withString:@"<br>"];
    requestStr = [requestStr stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
    requestStr = [requestStr stringByReplacingOccurrencesOfString:@"\t" withString:@"<br>"];
    requestStr = [requestStr stringByReplacingOccurrencesOfString:@"\r" withString:@"<br>"];
    
    return requestStr;
}
+(NSString *)StrTabrep:(NSString *)requestStr{
    requestStr = [requestStr stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    return requestStr;
    
    
}
//根据日期来计算年龄


+ (NSString*)fromDateToAge:(NSDate*)date{
    
    
    NSDate *myDate = date;
    
    
    NSDate *nowDate = [NSDate date];
    
    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    
    unsigned int unitFlags = NSYearCalendarUnit;
    
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:myDate toDate:nowDate options:0];
    
    
    NSInteger year = [comps year];
    
    
    return [NSString stringWithFormat:@"%ld",(long)year];
    
    
}
+(NSData *)imageData:(UIImage *)myimage
{
    NSData *data=UIImageJPEGRepresentation(myimage, 1.0);
    if (data.length>100*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(myimage, 0.1);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(myimage, 0.5);
        }else if (data.length>200*1024) {//0.25M-0.5M
            data=UIImageJPEGRepresentation(myimage, 0.9);
        }
    }
    return data;
}

+ (NSString *)randomUUID {
    if(NSClassFromString(@"NSUUID")) { // only available in iOS >= 6.0
        return [[NSUUID UUID] UUIDString];
    }
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef cfuuid = CFUUIDCreateString(kCFAllocatorDefault, uuidRef);
    CFRelease(uuidRef);
    NSString *uuid = [((__bridge NSString *) cfuuid) copy];
    CFRelease(cfuuid);
    return uuid;
}

@end
