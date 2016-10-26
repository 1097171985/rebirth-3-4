//
//  WJFReplaceVC.m
//  rebirth
//
//  Created by WJF on 16/10/13.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "WJFReplaceVC.h"
#import "ReplaceView.h"
#import "UIPlaceHolderTextView.h"
@interface WJFReplaceVC ()<UIScrollViewDelegate,UITextViewDelegate,replaceDelegate>

@property(nonatomic, assign)CGFloat  replaceHeight;

@property(nonatomic, strong) UIPlaceHolderTextView *twoReplaceView;

@property(nonatomic, strong)UIButton  *sendText;
@property(nonatomic, strong)UIView  *totalTextView;

@property(nonatomic, assign)BOOL replaceBool;

@property(nonatomic, strong)NSMutableArray *replaceTwoArray;
@property(nonatomic, strong)UIView *menbanView ;

@property(nonatomic, strong)UIScrollView *replaceScro;
@end

@implementation WJFReplaceVC
-(void)clickBtn{
    
    if (self.replaceScro) {
        
        for (UIView *view in self.replaceScro.subviews) {
            
            [view removeFromSuperview];
        }
        
        [self.replaceScro removeFromSuperview];
        
        self.replaceScro = nil;
        
    }
    self.replaceHeight = -8;

    [self loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.replaceHeight = -8;
    self.menuView.text = @"回复";
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
    [self loadTextView];
    
    [self loadData];
    // Do any additional setup after loading the view.
}

-(void)loadData{
    
    
    self.replaceTwoArray = [NSMutableArray array];
    NSDictionary *dict;
    if ([USER_DEFAULT objectForKey:@"id"]) {
        
        dict = @{@"id":[USER_DEFAULT objectForKey:@"id"],@"review_id":self.review_id,@"route":@"News_userSubReviewList",@"version":@"1",@"page":@"1",@"token":[USER_DEFAULT objectForKey:@"token"]};
        
        
        
    }else{
        
        dict = @{@"review_id":self.review_id,@"route":@"News_userSubReviewList",@"version":@"1",@"page":@"1"};
    }
    NSDictionary *signDict = [self encryptDict:(NSMutableDictionary *)dict];
    
    [WJFCollection getWithURLString:@"http://www.rempeach.com/rebirth/api/AppApi/receive" parameters:signDict success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        if ([responseObject[@"state"] isEqualToString:@"200"]) {
            
            self.replaceTwoArray = responseObject[@"data"][@"list"];
            
            [self loadReplaceView];

        }else if ([responseObject[@"state"] isEqualToString:@"100"]){
            
            [self loadReplaceView];
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);;
        
        
    }];
    
}


-(void)loadTextView{
    
    self.totalTextView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-96/2,WIDTH, 96/2)];
    
    self.totalTextView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.totalTextView];
    
    UILabel *henxian = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 0.5)];
    henxian.backgroundColor = [UIColor grayColor];
    
    [self.totalTextView addSubview:henxian];
    
    
    self.twoReplaceView = [[UIPlaceHolderTextView alloc]initWithFrame:CGRectMake(12,8,566/2,32)];
    self.twoReplaceView.delegate = self;
    self.twoReplaceView.textColor = [NSString colorWithHexString:@"949494"];
    self.twoReplaceView.placeholder = @"二级评论的内容...";
    self.twoReplaceView.placeholderColor = [NSString colorWithHexString:@"#6d7278"];
    self.twoReplaceView.font = [UIFont systemFontOfSize:14];
    self.twoReplaceView.backgroundColor = [UIColor whiteColor];
    [self.totalTextView addSubview: self.twoReplaceView];
    
    
    self.sendText = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.sendText setTitle:@"发送" forState:UIControlStateNormal];
    [self.sendText addTarget:self action:@selector(sendReviewBtu:) forControlEvents:UIControlEventTouchUpInside];
    self.sendText.backgroundColor = [UIColor blackColor];
    self.sendText.frame = CGRectMake(WIDTH-12-60,self.totalTextView.frame.size.height-32-8,60,32);
    [self.totalTextView addSubview:self.sendText];
    
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    NSLog(@"%lu",(unsigned long)range.location);
    
    return YES;
}


-(void)sendReviewBtu:(UIButton *)btu{
    
    if ([USER_DEFAULT objectForKey:@"id"]) {
        
           [self httpPinglun];
        
    }else{
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"您尚未登录，无法评论" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSLog(@"确定");
            HSLoginViewController  *vc = [[HSLoginViewController alloc]init];
            vc.source = @"TieZhi";
            [self.navigationController pushViewController:vc animated:YES];
            
        }];
        
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            NSLog(@"取消");
            
        }];
        
        [alert addAction:ok];//添加按钮
        [alert addAction:cancel];//添加按钮
        //以modal的形式
        [self presentViewController:alert animated:YES completion:^{ }];
        
        
        
        
    }
    
  
    
}

//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    CGFloat curkeyBoardHeight = [[[aNotification userInfo] objectForKey:@"UIKeyboardBoundsUserInfoKey"] CGRectValue].size.height;
    CGRect begin = [[[aNotification userInfo] objectForKey:@"UIKeyboardFrameBeginUserInfoKey"] CGRectValue];
    CGRect end = [[[aNotification userInfo] objectForKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    // 第三方键盘回调三次问题，监听仅执行最后一次
    if(begin.size.height>0 && (begin.origin.y-end.origin.y>0)){
        
        NSValue *animationDurationValue = [[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        NSTimeInterval animationDuration;
        [animationDurationValue getValue:&animationDuration];
        
        NSLog(@"%@===%f",animationDurationValue,animationDuration);
        [UIView animateWithDuration:animationDuration animations:^{
            self.twoReplaceView.frame = CGRectMake(12, 8,566/2, 70);
            
            self.totalTextView.frame = CGRectMake(0, HEIGHT-curkeyBoardHeight-86, WIDTH,86);
            
            [self.view bringSubviewToFront:self.totalTextView];
            self.sendText.frame = CGRectMake(WIDTH-12-60,self.totalTextView.frame.size.height-32-8,60,32);
            
            if (!self.menbanView) {
                self.menbanView = [[UIView alloc]initWithFrame:CGRectMake(0,0,WIDTH,HEIGHT-curkeyBoardHeight-86)];
                self.menbanView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.2];
                [self.view addSubview:self.menbanView];
            }
            

        } completion:^(BOOL finished) {
            
        }];
       
    }
}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    
    
    NSValue *animationDurationValue = [[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    [UIView animateWithDuration:animationDuration animations:^{
        self.totalTextView.frame = CGRectMake(0,HEIGHT-96/2,WIDTH,96/2);
        self.twoReplaceView.frame = CGRectMake(12,8 ,566/2,32);
        self.sendText.frame = CGRectMake(WIDTH-12-60,self.totalTextView.frame.size.height-32-8,60,32);
        if (self.menbanView) {
            
            [self.menbanView removeFromSuperview];
            self.menbanView = nil;
        }

    } completion:^(BOOL finished) {
        
    }];
    //do something
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    
    self.replaceBool = YES;
    
    BOOL contains1 = CGRectContainsPoint(self.twoReplaceView.frame,point);
    
    if (!contains1) {
        
        [self.twoReplaceView resignFirstResponder];
        
    }else{
        
        //[self.twoReplaceView becomeFirstResponder];
    }
    
    
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    // self.replaceBool = NO;
}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    
//    
//    [self.textView resignFirstResponder];
//    
//    self.totalTextView.frame = CGRectMake(0,HEIGHT-96/2,WIDTH,96/2);
//    
//    
//    NSLog(@"%f",scrollView.contentOffset.y);
//    
//}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(!decelerate){
        
        
        NSLog(@"222222");
        
    }else{
        
        NSLog(@"3333");
    }
}

-(void)loadReplaceView{
    
    self.replaceScro = [[UIScrollView alloc]initWithFrame:CGRectMake(0,64, WIDTH, HEIGHT-64-96/2)];
    self.replaceScro.delegate = self;
    self.replaceScro.backgroundColor = [UIColor whiteColor];
    self.replaceScro.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:self.replaceScro];
    
    
    UIImageView *subOneImage = [[UIImageView alloc]initWithFrame:CGRectMake(20,8, 40, 40)];
    [subOneImage sd_setImageWithURL:[NSURL URLWithString:self.head_img] placeholderImage:nil];
    //subOneImage.backgroundColor = [UIColor redColor];
    [self.replaceScro addSubview:subOneImage];
    
    
    UILabel  *subOneName = [[UILabel alloc]initWithFrame:CGRectMake(subOneImage.frame.origin.x+subOneImage.frame.size.width+12,16,WIDTH-(subOneImage.frame.origin.x+subOneImage.frame.size.width+12)-40,12)];
    
    subOneName.text = self.name;
    
    subOneName.font = [UIFont systemFontOfSize:12];
    
    subOneName.textColor = [NSString colorWithHexString:@"6D7278"];
    
    [self.replaceScro addSubview:subOneName];
    
    
    if ([USER_DEFAULT objectForKey:@"id"] && [[USER_DEFAULT objectForKey:@"id"] isEqualToString:self.user_id]) {
        UIButton *delectBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        
        delectBtu.frame = CGRectMake(WIDTH-20,20,12,12);
        
        [delectBtu setImage:[UIImage imageNamed:@"delete_small"] forState:UIControlStateNormal];
        
        [delectBtu addTarget:self action:@selector(delectHuiFuBtu:) forControlEvents:UIControlEventTouchUpInside];
        [self.replaceScro addSubview:delectBtu];
        
    }
    
    UILabel *subOneTime = [[UILabel alloc]initWithFrame:CGRectMake(subOneImage.frame.origin.x+subOneImage.frame.size.width+12,subOneName.frame.origin.y+subOneName.frame.size.height+8,WIDTH-(subOneImage.frame.origin.x+subOneImage.frame.size.width+12)-20,10)];
    
    subOneTime.text =self.time;
    subOneTime.font  = [UIFont systemFontOfSize:10];
    
    subOneTime.textColor = [NSString colorWithHexString:@"a2aab2"];
    
    [self.replaceScro addSubview:subOneTime];
    
    
    NSString *str =self.content;
    CGSize labelSize  = {0,0};
    labelSize = [str boundingRectWithSize:CGSizeMake(WIDTH-(subOneImage.frame.origin.x+subOneImage.frame.size.width+12)-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    
    UILabel *subOneContent = [[UILabel alloc]initWithFrame:CGRectMake(subOneImage.frame.origin.x+subOneImage.frame.size.width+12, subOneTime.frame.origin.y+subOneTime.frame.size.height+12,WIDTH-(subOneImage.frame.origin.x+subOneImage.frame.size.width+12)-20,labelSize.height)];
    
    subOneContent.text = self.content;
    subOneContent.numberOfLines = 0;
    
    subOneContent.textColor = [NSString colorWithHexString:@"27292b"];
    
    subOneContent.font = [UIFont systemFontOfSize:12];
    
    [self.replaceScro addSubview:subOneContent];
    
    
    UIView  *totalSunTwView  = [[UIView alloc]init];
    totalSunTwView.backgroundColor = [NSString colorWithHexString:@"edf0f1"];
    [self.replaceScro addSubview:totalSunTwView];
    
   
    for (int i = 0 ; i < self.replaceTwoArray.count; i++) {
        
        ReplaceView *peplace = [[ReplaceView alloc]initWithFrame:CGRectMake(12,self.replaceHeight+8,300,100) withReplace:self.replaceTwoArray[i]];
         peplace.repdelegate = self;
        [totalSunTwView addSubview:peplace];
        
        self.replaceHeight = peplace.frame.origin.y + peplace.frame.size.height;
        
    }
    
   
    if (self.replaceTwoArray.count == 0) {
        
        self.replaceHeight = 0;
    }
     totalSunTwView.frame = CGRectMake(20, subOneContent.frame.origin.y+subOneContent.frame.size.height+8,336,self.replaceHeight);
    self.replaceScro.contentSize = CGSizeMake(0,subOneContent.frame.origin.y+subOneContent.frame.size.height+self.replaceHeight);
}

-(void)delectHuiFuBtu:(UIButton *)btu{
    
    
    NSDictionary *dict = @{@"id":[USER_DEFAULT objectForKey:@"id"],@"token":[USER_DEFAULT objectForKey:@"token"],@"object_id":self.review_id,@"route":@"News_delete",@"version":@"1",@"category":@"2"};
    NSDictionary *signDict = [self encryptDict:(NSMutableDictionary *)dict];
    
    [WJFCollection postWithUrlString:@"http://www.rempeach.com/rebirth/api/AppApi/receive" Parameter:signDict success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)httpPinglun{
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
    NSString *content = self.twoReplaceView.text;
    NSString *transformId=[USER_DEFAULT objectForKey:@"id"];
    NSString *levels = @"2";
    NSString *news_id = self.news_id;
    NSString *route = @"News_submitReview";
    NSString *token = [USER_DEFAULT objectForKey:@"token"];
    NSString *toNews_id = self.review_id;
    NSString *version = @"1";
    NSArray *nameList = @[vn(category),vn(content),@"id",vn(levels),vn(news_id),vn(route),vn(toNews_id),vn(token),vn(version)];
    NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(category),sv(content),sv(transformId),sv(levels),sv(news_id),sv(route),sv(toNews_id),sv(token),sv(version),nil];
    NSLog(@"%@",parameters1);
    NSString *str = sv(transformId);
    NSDictionary *dic = @{@"category":@"2",@"content":self.twoReplaceView.text,@"id":[USER_DEFAULT objectForKey:@"id"],@"levels":@"2",@"news_id":self.news_id,@"route":@"News_submitReview",@"token":[USER_DEFAULT objectForKey:@"token"],@"version":@"1",@"toNews_id":self.review_id};
    
    NSDictionary *signDict = [self encryptDict:dic];
    
    [WJFCollection  postWithUrlString:@"http://www.rempeach.com/rebirth/api/AppApi/receive" Parameter:signDict success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        if ([responseObject[@"state"] isEqualToString:@"210"]) {
            
            if (self.replaceScro) {
                
                for (UIView *view in self.replaceScro.subviews) {
                    
                    [view removeFromSuperview];
                }
                
                [self.replaceScro removeFromSuperview];
                
                self.replaceScro = nil;
                
            }
            self.replaceHeight = -8;
            [self.twoReplaceView resignFirstResponder];
            [self loadData];
            
        }
        
    } failure:^(NSError *error) {
        
        
        NSLog(@"%@",error);
    }];
    
//    [YkxHttptools post:@"http://www.rempeach.com/rebirth/api/AppApi/receive" params:dic success:^(id responseObj) {
//        if ([[responseObj objectForKey:@"state"] isEqualToString:@"210"]) {
//            NSLog(@"成功")
//        }else{
//            NSLog(@"失败");
//        }
//        
//    } failure:^(NSError *error) {
////        
//    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
