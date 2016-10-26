//
//  ReplaceZhengWenVC.m
//  rebirth
//
//  Created by WJF on 16/10/13.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "ReplaceZhengWenVC.h"
#import "ReplaceZhengWenCell.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ReplacePinglunCell.h"
#import "WJFReplaceVC.h"
#import "UIPlaceHolderTextView.h"
#import "ReplaceModel.h"
#import "SHEJIAOZWCell.h"
@interface ReplaceZhengWenVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,reldelegatecell>

@property(nonatomic, strong)UITableView  *replaceZhengWenTab;

@property(nonatomic, strong) UIPlaceHolderTextView *placeTextView;
@property(nonatomic, strong)UIButton  *sendText;
@property(nonatomic, strong)UIView  *totalTextView;

@property(nonatomic, strong)NSMutableArray *dataOneArray;

@property(nonatomic, strong)NSMutableArray *dataTwoArray;

@property(nonatomic, strong)UIView *menbanView;

/**
 *  声明播放视频的控件属性[既可以播放视频也可以播放音频]
 */
@property (nonatomic,strong)AVPlayer *player;
/**
 *  播放的总时长
 */
@property (nonatomic,assign)CGFloat sumPlayOperation;

@property(nonatomic,strong)UIImageView *videoImage;

@property(nonatomic,strong)AVPlayerLayer *playlayer;

@property(nonatomic,strong)UITableView *playerTab;

@property(nonatomic, strong)UIImageView  *lastplayImageView;

@property(nonatomic, strong)NSString *lastplayImageStr;

@end

@implementation ReplaceZhengWenVC
-(void)clickbbb{
    
    [self loadPingLunData];
    
}

-(void)backClick:(UIButton *)btu{
    [self.delegate clicksss:@"photo"];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _pinglunNum = self.model.review_num;
    self.view.backgroundColor = [UIColor whiteColor];
    self.menuView.text = @"正文";
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerLoadStateDidChange)name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    [self loadReaplaceTab];
    
    [self loadTextView];
    
    [self loadPingLunData];
    // Do any additional setup after loading the view.
}


-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [self.player pause];
    
    self.player = nil;
    
    [self.replaceZhengWenTab reloadData];
}

-(void)loadPingLunData{
    
    self.dataTwoArray = [NSMutableArray array];
    self.dataOneArray = [NSMutableArray array];
    NSDictionary *dict;
    if ([USER_DEFAULT objectForKey:@"id"]) {
        
        dict = @{@"id":[USER_DEFAULT objectForKey:@"id"] ,@"news_id":self.model.news_id,@"route":@"News_userReviewList",@"version":@"1",@"page":@"1",@"token":[USER_DEFAULT objectForKey:@"token"]};
    }else{
       dict = @{@"news_id":self.model.news_id,@"route":@"News_userReviewList",@"version":@"1",@"page":@"1"};
    }
    
    
    
    NSDictionary *signDict = [self encryptDict:(NSMutableDictionary *)dict];
    
    [WJFCollection getWithURLString:@"http://www.rempeach.com/rebirth/api/AppApi/receive" parameters:signDict success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        if ([responseObject[@"state"] isEqualToString:@"200"]) {
            
            self.pinglunNum = responseObject[@"data"][@"total"];

        for (NSDictionary *dict in responseObject[@"data"][@"list"]) {
            ReplaceModel *model = [[ReplaceModel alloc]init];
            if ([dict[@"child_list"] isKindOfClass:[NSString class]]) {
                
            }else{
                
               model.child_list = dict[@"child_list"];
            }
            model.child_num = dict[@"child_num"];
            model.content = dict[@"content"];
            model.date  = dict[@"date"];
            model.head_img = dict[@"head_img"];
            model.levels = dict[@"levels"];
            model.news_id = dict[@"news_id"];
            model.nick  = dict[@"nick"];
            model.review_id = dict[@"review_id"];
            model.user_id = dict[@"user_id"];
            [self.dataOneArray addObject:model];
        }
            
            [self.replaceZhengWenTab reloadData];
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
    
    
    
}


-(void)loadTextView{
    
    self.totalTextView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-96/2,WIDTH, 96/2)];
    
    self.totalTextView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.totalTextView];
    
    UILabel *henxian = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 0.5)];
    henxian.backgroundColor = [UIColor grayColor];
    
    [self.totalTextView addSubview:henxian];
    
    
    self.placeTextView = [[UIPlaceHolderTextView alloc]initWithFrame:CGRectMake(12,8,566/2,32)];
    self.placeTextView.delegate = self;
    self.placeTextView.textColor = [NSString colorWithHexString:@"949494"];
    self.placeTextView.placeholder = @"一级评论的内容...";
    self.placeTextView.placeholderColor = [NSString colorWithHexString:@"#6d7278"];
    self.placeTextView.font = [UIFont systemFontOfSize:14];
    self.placeTextView.backgroundColor = [UIColor whiteColor];
    [self.totalTextView addSubview: self.placeTextView];
    
   self.sendText = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.sendText setTitle:@"发送" forState:UIControlStateNormal];
    self.sendText.backgroundColor = [UIColor blackColor];
    [self.sendText addTarget:self action:@selector(sendReviewText:) forControlEvents:UIControlEventTouchUpInside];
    self.sendText.frame = CGRectMake(WIDTH-12-60,self.totalTextView.frame.size.height-32-8,60,32);
    [self.totalTextView addSubview:self.sendText];
    

}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    NSLog(@"%lu",(unsigned long)range.location);
    
    return YES;
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
        [UIView  animateWithDuration:animationDuration animations:^{
            
            self.placeTextView.frame = CGRectMake(12, 8,566/2, 70);
            
            self.totalTextView.frame = CGRectMake(0, HEIGHT-curkeyBoardHeight-86, WIDTH,86);
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
        self.placeTextView.frame = CGRectMake(12,8 ,566/2,32);
        self.sendText.frame = CGRectMake(WIDTH-12-60,self.totalTextView.frame.size.height-32-8,60,32);
        if (self.menbanView) {
            
            [self.menbanView removeFromSuperview];
            self.menbanView = nil;
        }

    } completion:^(BOOL finished) {
        
    }];
    //do something
}


-(void)loadReaplaceTab{
    
    self.replaceZhengWenTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH,HEIGHT-64-60) style:UITableViewStylePlain];
    
    self.replaceZhengWenTab.delegate = self;
    
    self.replaceZhengWenTab.dataSource = self;
    
    [self.view addSubview:self.replaceZhengWenTab];
      self.replaceZhengWenTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    
    
    BOOL contains1 = CGRectContainsPoint(self.placeTextView.frame,point);
    
    if ( contains1) {
        
        //[self.placeTextView becomeFirstResponder];
        
    }else{
        
        [self.placeTextView resignFirstResponder];
    }
    

    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
   // self.replaceBool = NO;
}

#pragma mark 协议
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        SHEJIAOZWCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qwe"];
        if (!cell) {
            
            cell = [[SHEJIAOZWCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"qwe"];
        }
        HSShejiaoModel *moel =self.model;
        cell.myModel1 = moel;
        if ([moel.category isEqualToString:@"2"]) {
            
            cell.videoImage.userInteractionEnabled = YES;
            
            cell.videoImage.tag = 9999+indexPath.row;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dianji:)];
            [cell.videoImage addGestureRecognizer:tap];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ([USER_DEFAULT objectForKey:@"id"] &&[moel.user_id isEqualToString:[USER_DEFAULT objectForKey:@"id"]]) {
            
            UIButton *delectBtu = [UIButton buttonWithType:UIButtonTypeCustom];
            
            delectBtu.frame = CGRectMake(WIDTH-20,20,12,12);
            
            [delectBtu setImage:[UIImage imageNamed:@"delete_small"] forState:UIControlStateNormal];
            
            [delectBtu addTarget:self action:@selector(delectBtu:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:delectBtu];
            
            
            
        }
        return cell;
    }else{
        
       
        
        if(indexPath.row == 0){
            
            ReplacePinglunCell *cell =[[ReplacePinglunCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ReplacePinglunCell"];
            NSLog(@"self.pinglunNum%@",self.pinglunNum);
            cell.pingLunNumber.text = self.pinglunNum;
            
            return cell;
        }else{
            
            BOOL replaceBool ;
            if (indexPath.row ==1) {
                
                replaceBool = YES;
            }
         ReplaceModel *model =self.dataOneArray[indexPath.row-1];
        
         ReplaceZhengWenCell *cell =[[ReplaceZhengWenCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ReplaceZhengWenCell" withbool:replaceBool withreplaceArr:model];
          cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate =self;
         [cell.delectBtu addTarget:self action:@selector(delecteTiezi:) forControlEvents:UIControlEventTouchUpInside];
            cell.delectBtu.tag = 888+indexPath.row;
          UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(subOneReplace:)];
          cell.subOneContent.userInteractionEnabled = YES;
          cell.subOneContent.tag = 888+indexPath.row;
          [cell.subOneContent addGestureRecognizer:tap];
        if (indexPath.row == 1) {
            
            [cell.moreLabel addTarget:self action:@selector(moreReplace:) forControlEvents:UIControlEventTouchUpInside];
        }
        
         return cell;
        }
        }
    return nil;
}

//删帖子
-(void)delectBtu:(UIButton *)btu{
    
    NSLog(@"删帖子");
    NSDictionary *dict = @{@"id":[USER_DEFAULT objectForKey:@"id"],@"token":[USER_DEFAULT objectForKey:@"token"],@"object_id":self.model.news_id,@"route":@"News_delete",@"version":@"1",@"category":@"1"};
    NSDictionary *signDict = [self encryptDict:(NSMutableDictionary*)dict];
    [WJFCollection postWithUrlString:@"http://www.rempeach.com/rebirth/api/AppApi/receive" Parameter:signDict success:^(id responseObject) {
        NSLog(@"%@=====%@",responseObject,responseObject[@"message"]);
        if ([responseObject[@"state"] isEqualToString:@"210"]) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


//删评论
-(void)delecteTiezi:(UIButton *)btu{
    
    ReplaceModel *model =self.dataOneArray[btu.tag-888-1];

    NSDictionary *dict = @{@"id":[USER_DEFAULT objectForKey:@"id"],@"token":[USER_DEFAULT objectForKey:@"token"],@"object_id":model.review_id,@"route":@"News_delete",@"version":@"1",@"category":@"2"};
    NSDictionary *signDict = [self encryptDict:(NSMutableDictionary *)dict];
    [WJFCollection postWithUrlString:@"http://www.rempeach.com/rebirth/api/AppApi/receive" Parameter:signDict success:^(id responseObject) {
        NSLog(@"%@===%@",responseObject,responseObject[@"message"]);
        
        if ([responseObject[@"state"] isEqualToString:@"210"]) {
            
            [self loadPingLunData];
            [_replaceZhengWenTab reloadData];
            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}

-(void)moviePlayerLoadStateDidChange{
    
    NSLog(@"4444444");
        [_player seekToTime:CMTimeMake(0, 1)];
        [_player play];
    
}
-(void)dianji:(UITapGestureRecognizer *)tap{
    
    NSString *urlStr;
    NSString *imageStr;
    if ([_model.category isEqualToString:@"2"]) {
        for (NSDictionary *shipinDict in _model.file_list) {
            if ([shipinDict [@"category"] isEqualToString:@"1"]) {
                urlStr = shipinDict[@"file_path"];
                
                
            }else if ([shipinDict[@"category"]isEqualToString:@"2"]){
                imageStr = shipinDict[@"file_path"];
            }
            
        }
        
    }
    if (self.lastplayImageView) {
        
        [self.lastplayImageView sd_setImageWithURL:[NSURL URLWithString:self.lastplayImageStr] placeholderImage:nil];
    }
    //设置播放的url
    NSString *playString = urlStr;
    self.lastplayImageStr = imageStr;
    NSURL *url = [NSURL URLWithString:playString];
    //设置播放的项目
    if (self.playlayer) {
        
        [self.playlayer removeFromSuperlayer];
        
        self.playlayer = nil;
        
        self.player = nil;
        
    }
    
    
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    
    //初始化player对象
    self.player = [[AVPlayer alloc] initWithPlayerItem:item];
    //设置播放页面
    self.playlayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    //设置播放页面的大小
    self.playlayer.frame = CGRectMake(0, 0,240, 180);
    // layer.backgroundColor = [UIColor blueColor].CGColor;
    //设置播放窗口和当前视图之间的比例显示内容
    self.playlayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    UIImageView *playImageView = [self.view viewWithTag:tap.view.tag];
    NSLog(@"%ld",tap.view.tag);
    playImageView.image = nil;
    //playImageView.backgroundColor = [UIColor grayColor];
    
    [playImageView.layer addSublayer:self.playlayer];
    
    //添加播放视图到self.view
    self.lastplayImageView = playImageView;
    
    //设置播放的默认音量值
    [self.player play];
    
    
    
    
}


-(void)subOneReplace:(UITapGestureRecognizer *)tap{
    
    
    
    ReplaceModel *model = [[ReplaceModel alloc]init];
    
    model = self.dataOneArray[tap.view.tag -888-1];
    WJFReplaceVC *vc = [[WJFReplaceVC alloc]init];
    vc.review_id = model.review_id;
    vc.head_img = model.head_img;
    vc.time = model.date;
    vc.name = model.nick;
    vc.content = model.content;
    vc.news_id = model.news_id;
    vc.user_id = model.user_id;

    [self.navigationController pushViewController:vc animated:YES];
    

}

//
-(void)moreReplace:(UIButton *)btu{
    
    WJFReplaceVC *vc = [[WJFReplaceVC alloc]init];
    ReplaceModel *model = [[ReplaceModel alloc]init];
    
    model = self.dataOneArray[0];
    vc.review_id = model.review_id;
    vc.head_img = model.head_img;
    vc.time = model.date;
    vc.name = model.nick;
    vc.content = model.content;
    vc.news_id  = model.news_id;
    vc.user_id = model.user_id;
    [self.navigationController pushViewController:vc animated:YES];
}


// 提交评论
-(void)sendReviewText:(UIButton *)btu{
    
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
    
    NSLog(@"9999");
    
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
    NSString *content = self.placeTextView.text;
    NSString *transformId=[USER_DEFAULT objectForKey:@"id"];
    NSString *levels = @"1";
    NSString *news_id = self.model.news_id;
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
            
            
            [self.placeTextView resignFirstResponder];
            
            [self loadPingLunData];
        }else{
            NSLog(@"失败");
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 1;
    }else{
        
        if ([self.pinglunNum isEqualToString:@"0"]) {
            
            return 0;
            
        }else{
            
            return self.dataOneArray.count +1;
        }
    }
  
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    UIView *view = [[UIView alloc]init];
    
    view.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        
        return 0;
    }
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
           
            return 40;
        }
        ReplaceZhengWenCell *cell = [self tableView:self.replaceZhengWenTab cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
        
    }else{
        
        SHEJIAOZWCell *cell = [self tableView:self.replaceZhengWenTab cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;;
    }
    
    
    return 0;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    WJFReplaceVC *vc = [[WJFReplaceVC alloc]init];
//    ReplaceModel *model = [[ReplaceModel alloc]init];
//    
//    model = self.dataOneArray[0];
//    vc.review_id = model.review_id;
//    vc.head_img = model.head_img;
//    vc.time = model.date;
//    vc.name = model.nick;
//    vc.content = model.content;
//    vc.news_id = self.model.news_id;
//    [self.navigationController pushViewController:vc animated:YES];

    
}


//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    
//        [self.textView resignFirstResponder];
//        
//        self.totalTextView.frame = CGRectMake(0,HEIGHT-96/2,WIDTH,96/2);
//
//       self.textView.editable = NO;
//       NSLog(@"%f",scrollView.contentOffset.y);
//       
//}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)ascrollView{
    
    NSLog(@"55555");
    self.placeTextView.editable = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
