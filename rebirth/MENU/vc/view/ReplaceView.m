//
//  ReplaceView.m
//  rebirth
//
//  Created by WJF on 16/10/13.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "ReplaceView.h"

@implementation ReplaceView


-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        
        
        
    }
    
    return self;
    
}

-(instancetype)initWithFrame:(CGRect)frame withReplace:(NSDictionary *)replace{
    
    
    self = [super initWithFrame:frame];
    if (self) {

        self.replaceDict = replace;
        self.replaceTouXiang = [[UIImageView alloc]initWithFrame:CGRectMake(0, 12,56/2, 56/2)];
        
        [self.replaceTouXiang sd_setImageWithURL:[NSURL URLWithString:replace[@"head_img"]] placeholderImage:nil];
        [self addSubview:self.replaceTouXiang];
        
        self.replaceName = [[UILabel alloc]initWithFrame:CGRectMake(self.replaceTouXiang.frame.origin.x+self.replaceTouXiang.frame.size.width+12,16,520/2-40,12)];
        self.replaceName.font = [UIFont systemFontOfSize:10];
        self.replaceName.text = replace[@"nick"];
        self.replaceName.textColor = [NSString colorWithHexString:@"67696d"];
        [self addSubview:self.replaceName];
        
        if ([USER_DEFAULT objectForKey:@"id"] && [[USER_DEFAULT objectForKey:@"id"] isEqualToString:replace[@"user_id"]]) {
            self.delectReplaceImage = [UIButton buttonWithType:UIButtonTypeCustom];
            self.delectReplaceImage.frame =CGRectMake(300-10,16,10,10);
            
            [self.delectReplaceImage setImage:[UIImage imageNamed:@"delete_small"] forState:UIControlStateNormal];
           
            [self.delectReplaceImage addTarget:self action:@selector(delectReplace:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:self.delectReplaceImage];
        }
        
        
        self.replaceTime = [[UILabel alloc]initWithFrame:CGRectMake(self.replaceTouXiang.frame.origin.x+self.replaceTouXiang.frame.size.width+12,self.replaceName.frame.origin.y+self.replaceName.frame.size.height+8,520/2,10)];
        
        self.replaceTime.text = replace[@"date"];
        self.replaceTime.font  = [UIFont systemFontOfSize:10];
        
        self.replaceTime.textColor = [NSString colorWithHexString:@"a2aab2"];
        
        [self addSubview:self.replaceTime];
        
        NSString *str = replace[@"content"];
        CGSize labelSize  = {0,0};
        labelSize = [str boundingRectWithSize:CGSizeMake(520/2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil].size;

        self.replaceContext = [[UILabel alloc]initWithFrame:CGRectMake(self.replaceTouXiang.frame.origin.x+self.replaceTouXiang.frame.size.width+12,self.replaceTime.frame.origin.y+self.replaceTime.frame.size.height+8,520/2,labelSize.height)];
        self.replaceContext.font = [UIFont systemFontOfSize:10];
        //self.replaceContext.backgroundColor = [UIColor redColor];
        self.replaceContext.textColor = [NSString colorWithHexString:@"27292b"];
        self.replaceContext.text = str;
        self.replaceContext.numberOfLines = 0;
        self.replaceContext.textColor = [UIColor blackColor];
        [self addSubview:self.replaceContext];
        
        
        self.frame = CGRectMake(self.frame.origin.x,self.frame.origin.y,300,self.replaceContext.frame.origin.y+self.replaceContext.frame.size.height);
        
        
    }
    return self;
}


-(void)delectReplace:(UIButton *)btu{
    
    
    NSLog(@"删除");
    
    NSDictionary *dict = @{@"id":[USER_DEFAULT objectForKey:@"id"],@"token":[USER_DEFAULT objectForKey:@"token"],@"object_id":self.replaceDict[@"id"],@"route":@"News_delete",@"version":@"1",@"category":@"2"};
    NSDictionary *signDict = [self encryptDict:(NSMutableDictionary *)dict];
    [WJFCollection postWithUrlString:@"http://www.rempeach.com/rebirth/api/AppApi/receive" Parameter:signDict success:^(id responseObject) {
        NSLog(@"%@===%@",responseObject,responseObject[@"message"]);
        
        if ([responseObject[@"state"] isEqualToString:@"210"]) {
            [self.repdelegate clickBtn];
//            UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            
          //  NSLog(@"%@",nav.viewControllers);

            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

    
    
}


-(NSString*) createMd5Sign:(NSMutableDictionary*)dict
{
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        
        [contentString appendFormat:@"%@%@", categoryId, [dict objectForKey:categoryId]];
        
    }
    return contentString;
}


//md5加密
-(NSString *) md5:(NSString *)str
{
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
    
    
}


-(NSDictionary *)encryptDict:(NSMutableDictionary *)dict{
    
    
    NSString *str1  =   [self createMd5Sign:dict];
    
    NSString  *str2 = [self md5:@"miaotaoKJ"];
    
    
    NSString *sign  = [self md5:[NSString stringWithFormat:@"%@%@",str1,str2]];
    
    NSMutableDictionary  *total = [[NSMutableDictionary alloc]init];
    
    [total addEntriesFromDictionary:dict];
    
    [total setObject:sign forKey:@"sign"];
    
    return (NSDictionary *)total;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
