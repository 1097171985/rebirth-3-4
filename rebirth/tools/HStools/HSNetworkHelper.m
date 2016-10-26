//
//  HSNetworkHelper.m
//  rebirth
//
//  Created by 侯帅 on 16/7/21.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSNetworkHelper.h"
#import "NSString+MD5.h"
@implementation HSNetworkHelper
+ (NSDictionary *)lf_requestParamsWithNameList:(NSArray *)nameList param:(NSString *)param, ...{
    
    va_list args;
    
    NSMutableString *signString = [@"" mutableCopy];
    
    NSMutableDictionary *mutableParams = [@{} mutableCopy];
    
    if (param){
        
        NSUInteger idx = 0;
        
        va_start(args, param);
        
        NSString *tmpString = [NSString stringWithFormat:@"%@%@",nameList[idx],param];
       
        [signString appendString:tmpString];
        
       
        [mutableParams setObject:param forKey:nameList[idx]];
        
        idx++;
        
        NSString *extendParam;
        
        while ((extendParam = va_arg(args, NSString *))){
            
            if(![@"" isEqualToString:extendParam]){
                
                tmpString = [NSString stringWithFormat:@"%@%@", nameList[idx], extendParam];
                
                [signString appendString:tmpString];
                
                [mutableParams setObject:extendParam forKey:nameList[idx]];
            }
            idx++;
        }
        
        va_end(args);
        
        [signString appendString:[@"miaotaoKJ" md5String]];
    }
  
    [mutableParams setObject:[signString md5String] forKey:@"sign"];
    
    return [mutableParams copy];
}

@end
