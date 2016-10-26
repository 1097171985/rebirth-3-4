//
//  TableViewCell.m
//  TableView--test
//
//  Created by kaizuomac2 on 16/8/3.
//  Copyright © 2016年 kaizuo. All rights reserved.
//

#import "TableViewCell.h"
#import "Masonry.h"
#import "Header.h"
#import "NSDate+Category.h"
#import "FirstViewController.h"
//  添加
#import "TextFieldView.h"
#import "DisProView.h"

@interface TableViewCell()<UITextFieldDelegate,SendReviewValueDelegate>

{
    NSString *imgStr;
}

@property (strong ,nonatomic) UIView *bgView;
@property (strong, nonatomic) UITextField *textField;

@property(nonatomic, strong)DisProView  *disProView;


@end

@implementation TableViewCell

-(void)awakeFromNib{
   
}
-(void)loadDisProCell:(NSMutableArray *)disProArray{
    
    
    self.disProView = [[DisProView alloc]initWithFrame:CGRectMake(0, pinglunBtn.frame.origin.y+pinglunBtn.frame.size.height,WIDTH,200) withDisPro:disProArray];
    
    self.disProView .backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.disProView ];
    
    
    self.frame = CGRectMake(0, 0,WIDTH,self.disProView .frame.origin.y+self.disProView .frame.size.height);
    
}
-(void)setArr:(NSMutableArray *)ARR{
    [self loadDisProCell:ARR];
}
-(void)setMyModel:(MyModel *)myModel{

    headImg.image = [UIImage imageNamed:myModel.headImg];
    
    username.text = myModel.name;
    contentText.text = myModel.trends;
    contentText.numberOfLines = 0;
    review.text = myModel.reviewStr;
    review.numberOfLines = 0;
    review.backgroundColor = [UIColor cyanColor];
    [self imageViewWithImg:myModel.contentImgs];
    imgStr = myModel.contentImgs;
}
-(void)setMyModel1:(HSShejiaoModel *)myModel1{
    [pinglunBtn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
    username.textColor = [NSString colorWithHexString:@"#6d7278"];
    username.font = [UIFont systemFontOfSize:14];
    username.text = myModel1.nick;
    contentText.font = [UIFont systemFontOfSize:12];
    contentText.textColor = [NSString colorWithHexString:@"27292b"];
    contentText.text = myModel1.text;
//    contentText.text = myModel1.trends;
//    contentText.numberOfLines = 0;
//    review.text = myModel.reviewStr;
    review.numberOfLines = 0;
    review.backgroundColor = [UIColor cyanColor];
//    [self imageViewWithImg:myModel.contentImgs];
//    imgStr = myModel.contentImgs;
    //时间
    tiamelabel.font = [UIFont systemFontOfSize:10];
    tiamelabel.textColor = [NSString colorWithHexString:@"a2aab3"];
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [fmt setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate * datePost = [fmt dateFromString:myModel1.date];
    //        fmt.dateFormat = @"MM-dd HH:mm";
    //        NSString *dateStr = [fmt stringFromDate:datePost];
    tiamelabel.text =[datePost timeIntervalDescription];
    
    
    
    
    
    
    
    
}

//发表的图片
-(void)imageViewWithImg:(NSString*)imgName{
    
    NSArray *imgs = [imgName componentsSeparatedByString:@","];
    for (NSInteger i=0;i<imgs.count;i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((kSpace+imgWidth)*(i%3),(kSpace+imgWidth)*(i/3), imgWidth, imgWidth)];
        imageView.image = [UIImage imageNamed:imgs[i]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [imageView addGestureRecognizer:tap];
        [newImage addSubview:imageView];
    }
}

-(void)tapAction:(UITapGestureRecognizer*)tap{
    
    NSArray *imgs = [imgStr componentsSeparatedByString:@","];

    FirstViewController *vc = [[FirstViewController alloc]init];
    vc.firstArray = [NSMutableArray array];
    for (int i = 0; i < imgs.count-1; i++) {
        
        [vc.firstArray addObject:imgs[i]];
    }
    vc.selecteIndex = (int)tap.view.tag;
    
    
    
    [[self viewController] presentViewController:vc animated:YES completion:^{
        
        
        
    }];
}


- (UIViewController *)viewController
{
    //获取当前view的superView对应的控制器
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
    
}


#pragma mark 发送 传值 代理函数
- (void)sendReviewValue:(NSString *)text
{
    NSLog(@"%@", text);
    
    /*602 提交评论
     URL：http://www.rempeach.com/rebirth/api/AppApi/receive
     接口描述：提交评论 范围包括对味资讯和对味社交
     请求方式：POST
     上传参数：
     id
     route               News_submitReview
     version
     news_id
     content
     category
     levels
     toNews_id
     token
     sign
     
     
     返回参数：state ：210 111 101 121 状态码（见附录）
     a b c d e f g h i j k l m n o p q r s t u v w  x y z
     */
    NSString *category = @"2";
    NSString *content = text;
    NSString *transformId=[USER_DEFAULT objectForKey:@"id"];
    NSString *levels = @"1";
    NSString *news_id = @"1";
    NSString *route = @"News_submitReview";
    NSString *token = [USER_DEFAULT objectForKey:@"token"];
    NSString *version = @"1";
    NSArray *nameList = @[vn(category),vn(content),@"id",vn(levels),vn(news_id),vn(route),vn(token),vn(version)];
    NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(category),sv(content),sv(transformId),sv(levels),sv(news_id),sv(route),sv(token),sv(version),nil];
    NSLog(@"%@",parameters1);
    NSString *str = sv(transformId);
    [YkxHttptools post:@"http://www.rempeach.com/rebirth/api/AppApi/receive" params:parameters1 success:^(id responseObj) {
        if ([[responseObj objectForKey:@"state"] isEqualToString:@"210"]) {
            NSLog(@"成功");
        }else{
            NSLog(@"失败");
        }
        
    } failure:^(NSError *error) {
        
    }];

}
- (IBAction)praise:(id)sender
{
    
    [self.delegate publishReiseOrPraise:@"praise" cellTag:self.tag];
}


@end
