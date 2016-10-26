//
//  NSString+JieXi.m
//  TuCaoApp
//
//  Created by 张利坤 on 15/1/8.
//  Copyright (c) 2015年 张利坤. All rights reserved.
//

#import "NSString+JieXi.h"

@implementation NSString (JieXi)
+(NSString *)requestJieXiRequestStr:(NSString *)requestStr
{
 
    requestStr = [requestStr stringByReplacingOccurrencesOfString:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<string xmlns=\"http://tempuri.org/\">" withString:@""];
    requestStr = [requestStr stringByReplacingOccurrencesOfString:@"</string>" withString:@""];
    requestStr = [requestStr stringByReplacingOccurrencesOfString:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<int xmlns=\"http://tempuri.org/\">" withString:@""];
    requestStr = [requestStr stringByReplacingOccurrencesOfString:@"</int>" withString:@""];
    requestStr = [requestStr stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    requestStr = [requestStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    requestStr = [requestStr stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    return requestStr;

    
    return requestStr;
}

+(UIColor *)colorWithHexString:(NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}
+(CGSize )titleHeightFont:(CGFloat )font kuandu:(NSInteger )kuandu text:(NSString *)text{
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:font]};
    CGSize   requiredSize = [text boundingRectWithSize:CGSizeMake(kuandu, 1000.0f)
                                               options:\
                             NSStringDrawingTruncatesLastVisibleLine |
                             NSStringDrawingUsesLineFragmentOrigin |
                             NSStringDrawingUsesFontLeading
                                            attributes:attribute context:nil].size;
    return requiredSize;
}


@end
