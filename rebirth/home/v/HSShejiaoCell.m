//
//  HSShejiaoCell.m
//  rebirth
//
//  Created by 侯帅 on 16/9/22.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSShejiaoCell.h"
#import "NSDate+Category.h"
#import "Header.h"
#import "TextFieldView.h"
#import "DisProView.h"
#import "FirstViewController.h"
@interface  HSShejiaoCell()<UITextFieldDelegate>
{
    NSString *imgStr;
    UIButton *pinglunBtn;
    UIView *contentView;
    UIView *line;
    NSString *news_idd;
}
@property(nonatomic, strong) UIImageView *aimageView;
@property(nonatomic, strong) NSMutableArray *imageViewArray;
@property (strong ,nonatomic) UIView *bgView;
@property (strong, nonatomic) UITextField *textField;

@property(nonatomic, strong)DisProView  *disProView;


@property(nonatomic, strong)NSMutableArray *disProArray;

@property(nonatomic, assign)CGFloat lastHeight;

@end


@implementation HSShejiaoCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDisProArray:(NSMutableArray *)disProArray{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.lastHeight = 0;
      //  self.backgroundColor = [UIColor yellowColor];
        
        self.disProArray = [NSMutableArray arrayWithArray:disProArray];
        
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.frame =CGRectMake(12, 12, 96/2, 96/2);
        _headerImageView.image = [UIImage imageNamed:@""];
        [self addSubview:_headerImageView];
        _headerImageView.layer.cornerRadius = 96/4;
        _headerImageView.layer.masksToBounds = YES;
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.frame =CGRectMake(12+_headerImageView.frame.size.width+12, 20, kScreenWidth/2, 14);
        
        _nameLabel.textColor = [NSString colorWithHexString:@"6d7278"];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_nameLabel];
        _contentLabel = [[UILabel alloc] init];
        
        _contentLabel.textColor = [NSString colorWithHexString:heitizi];
        _contentLabel.font = [UIFont systemFontOfSize:12];
      //  _contentLabel.backgroundColor = [UIColor greenColor];
        [self addSubview:_contentLabel];
        contentView = [[UIView alloc] init];
      //  contentView.backgroundColor = [UIColor redColor];
        contentView.frame =CGRectMake(144/2, 20+_nameLabel.frame.size.height+12+_contentLabel.frame.size.height+12, 240, 180);
        [self addSubview:contentView];
        pinglunBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        pinglunBtn.frame =CGRectMake(kScreenWidth-50, 20+_nameLabel.frame.size.height+12+_contentLabel.frame.size.height+12+contentView.frame.size.height+12, 50, 20);
       // pinglunBtn.backgroundColor = [UIColor blueColor];
        [pinglunBtn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
        [self addSubview:pinglunBtn];
        pinglunBtn.enabled =YES;
        [pinglunBtn addTarget:self action:@selector(clcik_pinglun:) forControlEvents:UIControlEventTouchUpInside];
        line = [[UIView alloc] init];
        line.backgroundColor = [UIColor grayColor];
        [self addSubview:line];
        _timeLabel = [[UILabel alloc] init];
        [self addSubview:_timeLabel];
       
        
   
    }
       return self;
}


-(void)loadDisProCell:(NSMutableArray *)disProArray{
    
    
    self.disProView = [[DisProView alloc]initWithFrame:CGRectMake(144/2, pinglunBtn.frame.origin.y+pinglunBtn.frame.size.height,566/2,200) withDisPro:disProArray];
    
    self.disProView .backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    
    [self addSubview:self.disProView ];
    
    for (UIView *view in self.disProView.subviews) {
        
        [view removeFromSuperview];
    }
    
    self.disProView.frame =CGRectMake(144/2, pinglunBtn.frame.origin.y+pinglunBtn.frame.size.height,566/2,0);
    self.frame = CGRectMake(0, 0,WIDTH,self.disProView.frame.origin.y+self.disProView .frame.size.height+1);
    line.frame =CGRectMake(0, self.disProView.frame.origin.y+self.disProView .frame.size.height+1, kScreenWidth, 0.5);
    
}


-(void)setMyModel1:(HSShejiaoModel *)myModel1{
  //  [pinglunBtn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
    NSLog(@"%@kjjk",myModel1.file_list);
    news_idd = myModel1.news_id;
    
 
    
    _nameLabel.textColor = [NSString colorWithHexString:@"#6d7278"];
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.text = myModel1.nick;
    _contentLabel.font = [UIFont systemFontOfSize:12];
    _contentLabel.textColor = [NSString colorWithHexString:@"27292b"];
    _contentLabel.text = myModel1.text;
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:myModel1.head_img] placeholderImage:[UIImage imageNamed:@"headImg"]];
    
    CGSize labelSize  = {0,0};
    labelSize = [_contentLabel.text boundingRectWithSize:CGSizeMake(WIDTH, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    _contentLabel.frame =CGRectMake(12+_headerImageView.frame.size.width+12, 20+_nameLabel.frame.size.height+5, kScreenWidth-12+_headerImageView.frame.size.width+12,labelSize.height);
  
    
    
    NSMutableString *image1 = [[NSMutableString alloc]init];
    if ([myModel1.category isEqualToString:@"1"]) {
       
        
        for (NSDictionary *imdDict in myModel1.file_list) {
            
            if ([imdDict[@"category"] isEqualToString:@"2"]) {
                
                
            }else if([imdDict[@"category"] isEqualToString:@"0"]){
                
                [image1 appendString:[NSString stringWithFormat:@"%@,",imdDict[@"file_path"]]];
                
            }
            
            
        }
        
        
        NSLog(@"imagestr=====%@",image1);
    
        [self imageViewWithImg:image1];
        imgStr = image1;

        
    }else if ([myModel1.category isEqualToString:@"2"]){
        
        for (NSDictionary *shipinDict in myModel1.file_list) {
            if ([shipinDict [@"category"] isEqualToString:@"2"]) {
                 NSString *str = shipinDict[@"file_path"];
                contentView.frame =CGRectMake(144/2, 20+_nameLabel.frame.size.height+12+_contentLabel.frame.size.height+12, 240, 180);
                
                [self imageViewWithImg1:str];
            }
           
        }
        
    }

    
   
    //时间
    _timeLabel.font = [UIFont systemFontOfSize:10];
    _timeLabel.textColor = [NSString colorWithHexString:@"a2aab3"];
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [fmt setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate * datePost = [fmt dateFromString:myModel1.date];
    //        fmt.dateFormat = @"MM-dd HH:mm";
    //        NSString *dateStr = [fmt stringFromDate:datePost];
    _timeLabel.text =[datePost timeIntervalDescription];
  
    
}
//视频播放
-(void)imageViewWithImg1:(NSString*)imgName1{
    
    self.videoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, contentView.frame.size.width, contentView.frame.size.height)];
    // imageView.image = [UIImage imageNamed:imgs[i]];
    [self.videoImage sd_setImageWithURL:[NSURL URLWithString:imgName1] placeholderImage:[UIImage imageNamed:@"default_img_qualityduiwei"]];
    
   
    //   imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.videoImage.userInteractionEnabled = YES;
    CALayer * maskLayer = [CALayer layer];
    // 蒙版的坐标是基于它所影响的那个图层的坐标系
    maskLayer.frame = CGRectMake(self.videoImage.center.x-22,self.videoImage.center.y-22, 44,44);
    
    maskLayer.contents = (__bridge id)[UIImage imageNamed:@"video_play"].CGImage;
    // 将maskLayer作为layer的蒙版
    [self.videoImage.layer addSublayer:maskLayer];
    
    
    [contentView addSubview:self.videoImage];
    pinglunBtn.frame =CGRectMake(kScreenWidth-50, 20+_nameLabel.frame.size.height+12+_contentLabel.frame.size.height+12+contentView.frame.size.height+12, 50, 20);
    _timeLabel.frame =CGRectMake(144/2, 20+_nameLabel.frame.size.height+12+_contentLabel.frame.size.height+12+contentView.frame.size.height+12, kScreenWidth/2-144/2, 14);
    [self loadDisProCell:self.disProArray];
}





//发表的图片
-(void)imageViewWithImg:(NSString*)imgName{
    NSArray *imgs;
    if ([imgName isEqualToString:@""]) {
    
        contentView.frame = CGRectMake(144/2, 20+_nameLabel.frame.size.height+12+_contentLabel.frame.size.height+12, 250, 0);
        pinglunBtn.frame =CGRectMake(kScreenWidth-50, 20+_nameLabel.frame.size.height+12+_contentLabel.frame.size.height+12+contentView.frame.size.height+12, 50, 20);
        _timeLabel.frame = CGRectMake(144/2, 20+_nameLabel.frame.size.height+12+_contentLabel.frame.size.height+12+contentView.frame.size.height+12, 50, 20);
        line.frame =CGRectMake(0, 20+_nameLabel.frame.size.height+12+_contentLabel.frame.size.height+12+contentView.frame.size.height+12+_timeLabel.frame.size.height+5, kScreenWidth, 0.5);
        [self loadDisProCell:self.disProArray];
    }else{
       imgs  = [imgName componentsSeparatedByString:@","];
        NSLog(@"%lu",(unsigned long)imgs.count);
        if (imgs.count ==2) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, contentView.frame.size.width, contentView.frame.size.height)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:imgs[0]] placeholderImage:[UIImage imageNamed:@"default_img_qualityduiwei"]];
            imageView.userInteractionEnabled = YES;
            imageView.tag = 0;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
            [imageView addGestureRecognizer:tap];
            
            self.lastHeight = imageView.frame.origin.y+imageView.frame.size.height;
            [contentView addSubview:imageView];
            
        }else{
        for (NSInteger i=0;i<imgs.count-1;i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((kSpace+imgWidth1)*(i%3),(kSpace+imgWidth1)*(i/3), imgWidth1, imgWidth1)];
           // imageView.image = [UIImage imageNamed:imgs[i]];
            [imageView sd_setImageWithURL:[NSURL URLWithString:imgs[i]] placeholderImage:[UIImage imageNamed:@"default_img_qualityduiwei"]];
            imageView.userInteractionEnabled = YES;
            imageView.tag = i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
            [imageView addGestureRecognizer:tap];
            
            self.lastHeight = imageView.frame.origin.y+imageView.frame.size.height;
            [contentView addSubview:imageView];
        }
        }
        contentView.frame = CGRectMake(144/2, 20+_nameLabel.frame.size.height+12+_contentLabel.frame.size.height+12, 240, self.lastHeight);
        pinglunBtn.frame =CGRectMake(kScreenWidth-50, 20+_nameLabel.frame.size.height+12+_contentLabel.frame.size.height+12+contentView.frame.size.height+12, 50, 20);
        _timeLabel.frame =CGRectMake(144/2, 20+_nameLabel.frame.size.height+12+_contentLabel.frame.size.height+12+contentView.frame.size.height+12, kScreenWidth/2-144/2, 14);
        [self loadDisProCell:self.disProArray];
        
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
    
    
    //[self.myDelegate checkImage:imgs[tap.view.tag]];
    NSLog(@"%@",imgs[tap.view.tag]);
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
-(void)clcik_pinglun:(UIButton *)sender{
    //评论
    NSLog(@"评论");
    if ([USER_DEFAULT objectForKey:@"id"]) {
        
        [self.delegate publishReiseOrPraise:@"comment" cellTag:self.tag];
        
        TextFieldView *textField = [[TextFieldView alloc]init];
        textField.delegate = self;
        
        [self addSubview:textField];
    }else{
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"您尚未登录，无法评论" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSLog(@"确定");
            HSLoginViewController  *vc = [[HSLoginViewController alloc]init];
            vc.source = @"TieZhi";
            [[self viewController].navigationController pushViewController:vc animated:YES];
            
        }];
        
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            NSLog(@"取消");
            
        }];
        
        [alert addAction:ok];//添加按钮
        [alert addAction:cancel];//添加按钮
        //以modal的形式
        [[self viewController] presentViewController:alert animated:YES completion:^{ }];
        
        
        
        
    }

    
   
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
    NSString *news_id = news_idd;
    NSString *route = @"News_submitReview";
    NSString *token = [USER_DEFAULT objectForKey:@"token"];
    NSString *version = @"1";
    NSArray *nameList = @[vn(category),vn(content),@"id",vn(levels),vn(news_id),vn(route),vn(token),vn(version)];
    NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(category),sv(content),sv(transformId),sv(levels),sv(news_id),sv(route),sv(token),sv(version),nil];
    NSLog(@"%@",parameters1);
    NSString *str = sv(transformId);
    [YkxHttptools post:@"http://www.rempeach.com/rebirth/api/AppApi/receive" params:parameters1 success:^(id responseObj) {
        if ([[responseObj objectForKey:@"state"] isEqualToString:@"210"]) {
            NSLog(@"成功");;
        }else{
            NSLog(@"失败");
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
