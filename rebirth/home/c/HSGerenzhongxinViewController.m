//
//  HSGerenzhongxinViewController.m
//  rebirth
//
//  Created by 侯帅 on 16/10/8.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSGerenzhongxinViewController.h"
#import "HSbianjiGRZLViewController.h"
#import "HSGRZXCell.h"
#import "HSGRZXModel.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ReplaceZhengWenVC.h"

@interface HSGerenzhongxinViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray *_dataArr;
@property (nonatomic,strong) NSMutableArray *_dataarr;


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

@implementation HSGerenzhongxinViewController
{
    UILabel *cslabel;
    UILabel *namelabel;
    UIImageView *iconIMG;
    UILabel *dengjilabel;
    UITableView *htable;
    UILabel *titleLbl;
    UIImageView *dengjiIMG;
    NSInteger pagee;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    pagee=1;
    UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backpreviousClick:)];
    rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGestureRecognizer];

    __dataArr = [[NSMutableArray alloc] init];
    __dataarr = [[NSMutableArray alloc] init];
    [self httpUser_userPage];
    [self httpNews_getUserNews];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatTab];
    [self creatView];
    [self creatNavi];
    // Do any additional setup after loading the view.
}
-(void)backpreviousClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)creatTab{
    htable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT+ 315/2*HEIGHTRATIO, kScreenWidth, kScreenHeight-NAV_BAR_HEIGHT-315/2*HEIGHTRATIO) style:UITableViewStylePlain];
    htable.delegate=self;
    htable.dataSource = self;
    [self.view addSubview:htable];
     htable.separatorStyle = UITableViewCellSeparatorStyleNone;
    htable.mj_header.hidden = YES;
    __weak typeof(self)weakSelf = self;
    __weak UITableView *table = htable;
    table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        pagee = 1;
        [__dataArr removeAllObjects];
        [self httpNews_getUserNews];
    }];
    
     table.mj_header.automaticallyChangeAlpha = YES;
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [footer setTitle:@"" forState:MJRefreshStateIdle];
        [footer setTitle:@"松开获取更多数据" forState:MJRefreshStateWillRefresh];
        [footer setTitle:@"获取中" forState:MJRefreshStateRefreshing];
        [footer setRefreshingTitleHidden:YES];
        pagee++;
        [self httpNews_getUserNews];
        [table.mj_footer endRefreshing];
    }];
    table.mj_footer = footer;

    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return __dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    
      HSGRZXCell  *cell = [[HSGRZXCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    
    
    if (__dataArr.count!=0) {
        HSGRZXModel *mm = [[HSGRZXModel alloc]init];
        mm =   __dataArr[indexPath.row];
       
       // NSLog(@"----%@",mm.file_list);
      //  cell.myModel1 = mm;
        [cell setModel:mm];
        if ([mm.category isEqualToString:@"2"]) {
            
            cell.videoImage.userInteractionEnabled = YES;
            
            cell.videoImage.tag = 9999+indexPath.row;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dianji:)];
            
            [cell.videoImage addGestureRecognizer:tap];
        }
        
    }
   
    
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ReplaceZhengWenVC *zwvc = [[ReplaceZhengWenVC alloc] init];
    zwvc.model = __dataarr[indexPath.row];
    zwvc.model.head_img = [USER_DEFAULT objectForKey:@"head"];
    NSLog(@"%@",zwvc.model.review_num);
   
    [self.navigationController pushViewController:zwvc animated:YES];

    
    
}

-(void)moviePlayerLoadStateDidChange{
    
    NSLog(@"4444444");
    [_player seekToTime:CMTimeMake(0, 1)];
    [_player play];
    
}
-(void)dianji:(UITapGestureRecognizer *)tap{
    HSGRZXModel *modell = [[HSGRZXModel alloc] init];
    modell =__dataArr[tap.view.tag-9999];
    NSString *urlStr;
    NSString *imageStr;
    if ([modell.category isEqualToString:@"2"]) {
        for (NSDictionary *shipinDict in modell.file_list) {
            if ([shipinDict [@"file_category"] isEqualToString:@"1"]) {
                urlStr = shipinDict[@"file_path"];
               
                
            }else if ([shipinDict[@"file_category"]isEqualToString:@"2"]){
                imageStr = shipinDict[@"file_path"];
            }
            
        }

    }
    
    if (self.lastplayImageView) {
        
        [self.lastplayImageView sd_setImageWithURL:[NSURL URLWithString:self.lastplayImageStr] placeholderImage:nil];
    }
    
    
    //设置播放的url
    NSString *playString = urlStr;
    self.lastplayImageStr = urlStr;
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
    self.playlayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    UIImageView *playImageView = [self.view viewWithTag:tap.view.tag];
    NSLog(@"%ld",tap.view.tag);
    playImageView.image = nil;
    playImageView.backgroundColor = [UIColor whiteColor];
    
    [playImageView.layer addSublayer:self.playlayer];
    
    //添加播放视图到self.view
    self.lastplayImageView = playImageView;
    
    //设置播放的默认音量值
    //self.player.volume = 100;
    [self.player play];
    
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HSGRZXCell *cell = [self tableView:htable cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;;

}
-(void)httpUser_userPage{
    /*406 获取用户主页用户信息
     URL：http://www.rempeach.com/rebirth/api/AppApi/receive
     接口描述：获取代金券列表
     请求方式：GET
     上传参数：
     id
     route         User_userPage
     version
     token
     sign
     
     
     返回参数：state ：200 100 111 101 121 状态码（见附录）
*/
    if ([self.form isEqualToString:@"shejiao"]) {
        NSString *transformId = self.userid;
        NSString *route=@"User_userPage";
        NSString *token=[USER_DEFAULT objectForKey:@"token"];
        NSString *version=@"1";
        
        
        NSArray *nameList = @[@"id",vn(route),vn(token),vn(version)];
        NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(transformId),sv(route),sv(token),sv(version),nil];
        NSLog(@"%@",parameters1);
        NSString *str = sv(transformId);
        [YkxHttptools get:@"http://www.rempeach.com/rebirth/api/AppApi/receive" params:parameters1 success:^(id responseObj) {
            NSString *finishStr = [[NSString alloc]initWithData:responseObj encoding:NSUTF8StringEncoding];
            finishStr = [YkxHttptools repTabStr:finishStr];
            NSDictionary *paramDic = [[[SBJsonParser alloc]init] objectWithString:finishStr];
            NSLog(@"%@",paramDic);
            NSLog(@"%@",[paramDic objectForKey:@"tip"]);
            if ([[paramDic objectForKey:@"state"] isEqualToString:@"200"]) {
                NSDictionary *dic = [paramDic objectForKey:@"data"];
                
                namelabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"nick"]];
                //    namelabel.text = [dic objectForKey:@"nick"];
                
                
                dengjilabel.text = [NSString stringWithFormat:@"V%@",[dic
                                                                      objectForKey:@"user_level"]];
                [USER_DEFAULT setObject:[dic objectForKey:@"sex"] forKey:@"sex"];
                cslabel.text = [NSString stringWithFormat:@"%@次",[dic objectForKey:@"costNum"]];
                [iconIMG sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"head_img"]] placeholderImage:[UIImage imageNamed:@"headImg"]];
                [USER_DEFAULT setObject:[dic objectForKey:@"head_img"] forKey:@"head"];
                
                titleLbl.text = [NSString stringWithFormat:@"%@的个人中心",namelabel.text];
                //iconIMG.layer.cornerRadius = 72/2;
                
            }
        } failure:^(NSError *error) {
            
        }];

    }else{
    NSString *transformId=[USER_DEFAULT objectForKey:@"id"];
        NSString *route=@"User_userPage";
        NSString *token=[USER_DEFAULT objectForKey:@"token"];
        NSString *version=@"1";
        
        
        NSArray *nameList = @[@"id",vn(route),vn(token),vn(version)];
        NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(transformId),sv(route),sv(token),sv(version),nil];
        NSLog(@"%@",parameters1);
        NSString *str = sv(transformId);
        [YkxHttptools get:@"http://www.rempeach.com/rebirth/api/AppApi/receive" params:parameters1 success:^(id responseObj) {
            NSString *finishStr = [[NSString alloc]initWithData:responseObj encoding:NSUTF8StringEncoding];
            finishStr = [YkxHttptools repTabStr:finishStr];
            NSDictionary *paramDic = [[[SBJsonParser alloc]init] objectWithString:finishStr];
            NSLog(@"%@",paramDic);
            NSLog(@"%@",[paramDic objectForKey:@"tip"]);
            if ([[paramDic objectForKey:@"state"] isEqualToString:@"200"]) {
                NSDictionary *dic = [paramDic objectForKey:@"data"];
                
                namelabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"nick"]];
                //    namelabel.text = [dic objectForKey:@"nick"];
                
                dengjiIMG.image = [UIImage imageNamed:[NSString stringWithFormat:@"vip_%ld@2x",[[dic objectForKey:@"user_level"] integerValue]+1]];
                
                
               // dengjilabel.text = [NSString stringWithFormat:@"V%@",[dic
                                                                      //objectForKey:@"user_level"]];
                [USER_DEFAULT setObject:[dic objectForKey:@"sex"] forKey:@"sex"];
                cslabel.text = [NSString stringWithFormat:@"%@次",[dic objectForKey:@"costNum"]];
                [iconIMG sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"head_img"]] placeholderImage:[UIImage imageNamed:@"headImg"]];
                [USER_DEFAULT setObject:[dic objectForKey:@"head_img"] forKey:@"head"];
                
                titleLbl.text = [NSString stringWithFormat:@"%@的个人中心",namelabel.text];
                //iconIMG.layer.cornerRadius = 72/2;
                
            }
        } failure:^(NSError *error) {
            
        }];

    }
    
}
-(void)httpNews_getUserNews{
    /*604 获取个人的对味列表
     URL：http://www.rempeach.com/rebirth/api/AppApi/receive
     接口描述：获取个人对味社交列表
     请求方式：GET
     上传参数：
     id
     route        News_getUserNews
     version
     page
     token
     sign
     
     返回参数：state ：210 111 101 121 状态码（见附录）
*/
    if ([self.form isEqualToString:@"shejiao"]) {
        NSString *transformId=self.userid;
        NSString *page = [NSString stringWithFormat:@"%ld",pagee];
        NSString *route=@"News_getUserNews";
        NSString *token=[USER_DEFAULT objectForKey:@"token"];
        NSString *version=@"1";
        NSArray *nameList = @[@"id",vn(page),vn(route),vn(token),vn(version)];
        NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(transformId),sv(page),sv(route),sv(token),sv(version),nil];
        NSLog(@"%@",parameters1);
        NSString *str = sv(transformId);
        [YkxHttptools get:@"http://www.rempeach.com/rebirth/api/AppApi/receive" params:parameters1 success:^(id responseObj) {
            NSString *finishStr = [[NSString alloc]initWithData:responseObj encoding:NSUTF8StringEncoding];
            finishStr = [YkxHttptools repTabStr:finishStr];
            NSDictionary *paramDic = [[[SBJsonParser alloc]init] objectWithString:finishStr];
            NSLog(@"%@",paramDic);
            NSLog(@"%@",[paramDic objectForKey:@"tip"]);
            if ([[paramDic objectForKey:@"state"]isEqualToString:@"200"]) {
                NSDictionary *dic = [paramDic objectForKey:@"data"];
                NSArray *arr = [dic objectForKey:@"list"];
                NSLog(@"%@",arr);
                for (NSDictionary *listDict in arr) {
                    HSShejiaoModel *sjjmodel = [[HSShejiaoModel alloc] init];
                    HSGRZXModel *model = [[HSGRZXModel alloc]init];
                    if (listDict[@"file_list"]) {
                        //
                        //                   if([listDict[@"file_list"][0] isEqualToString:@""]){
                        //
                        //                       model.file_list = [NSMutableArray array];
                        //
                        //                   }else{
                        NSMutableArray *arr = [NSMutableArray arrayWithArray:listDict[@"file_list"]];
                        
                        model.file_list = [NSMutableArray arrayWithArray:arr];
                        sjjmodel.file_list = [NSMutableArray arrayWithArray:arr];
                        
                        //                   }
                        
                        NSLog(@"33333333333333%@",model.file_list[0]);
                        
                    }else{
                        
                        
                        
                    }
                    model.category = listDict[@"category"];
                    sjjmodel.category = listDict[@"category"];
                    
                    model.created_date = listDict[@"created_date"];
                    sjjmodel.date = listDict[@"created_date"];
                    
                    
                    //    model.head_img = listDict[@"head_img"];
                    
                    model.news_id = listDict[@"news_id"];
                    sjjmodel.news_id =listDict [@"news_id"];
                    
                    //  model.nick = listDict[@"nick"];
                    
                    //  model.review_num = listDict[@"review_num"];
                    
                    model.textContent = listDict[@"textContent"];
                    sjjmodel.text = listDict[@"textContent"];
                    
                    // model.user_id = listDict[@"user_id"];
                    
                    
                    [__dataArr addObject:model];
                    [__dataarr addObject:sjjmodel];
                    
                }
                [htable reloadData];
            }
        } failure:^(NSError *error) {
            
        }];

    }else{
        NSString *transformId=[USER_DEFAULT objectForKey:@"id"];
        NSString *page = [NSString stringWithFormat:@"%ld",(long)pagee];
        NSString *route=@"News_getUserNews";
        NSString *token=[USER_DEFAULT objectForKey:@"token"];
        NSString *version=@"1";
        NSArray *nameList = @[@"id",vn(page),vn(route),vn(token),vn(version)];
        NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(transformId),sv(page),sv(route),sv(token),sv(version),nil];
        NSLog(@"%@",parameters1);
        NSString *str = sv(transformId);
        [YkxHttptools get:@"http://www.rempeach.com/rebirth/api/AppApi/receive" params:parameters1 success:^(id responseObj) {
            NSString *finishStr = [[NSString alloc]initWithData:responseObj encoding:NSUTF8StringEncoding];
            finishStr = [YkxHttptools repTabStr:finishStr];
            NSDictionary *paramDic = [[[SBJsonParser alloc]init] objectWithString:finishStr];
            NSLog(@"%@",paramDic);
            NSLog(@"%@",[paramDic objectForKey:@"tip"]);
            if ([[paramDic objectForKey:@"state"]isEqualToString:@"200"]) {
                NSDictionary *dic = [paramDic objectForKey:@"data"];
                NSArray *arr = [dic objectForKey:@"list"];
                NSLog(@"%@",arr);
                for (NSDictionary *listDict in arr) {
                    HSShejiaoModel *sjjmodel = [[HSShejiaoModel alloc] init];
                    
                    HSGRZXModel *model = [[HSGRZXModel alloc]init];
                    if (listDict[@"file_list"]) {
                        //
                        //                   if([listDict[@"file_list"][0] isEqualToString:@""]){
                        //
                        //                       model.file_list = [NSMutableArray array];
                        //
                        //                   }else{
                        NSMutableArray *arr = [NSMutableArray arrayWithArray:listDict[@"file_list"]];
                        
                        model.file_list = [NSMutableArray arrayWithArray:arr];
                        sjjmodel.file_list = [NSMutableArray arrayWithArray:arr];
                        //                   }
                        
                        NSLog(@"33333333333333%@",model.file_list[0]);
                        [htable.mj_header endRefreshing];
                        [htable.mj_footer endRefreshing];
                        
                    }else{
                        
                        
                        
                    }
                    model.category = listDict[@"category"];
                    sjjmodel.category = listDict[@"category"];
                    model.created_date = listDict[@"created_date"];
                    sjjmodel.date = listDict[@"created_date"];
                    
                    
                    //    model.head_img = listDict[@"head_img"];
                    
                    model.news_id = listDict[@"news_id"];
                    sjjmodel.news_id = listDict[@"news_id"];
                    
                    //  model.nick = listDict[@"nick"];
                    
                    //  model.review_num = listDict[@"review_num"];
                    
                    model.textContent = listDict[@"textContent"];
                    sjjmodel.text = listDict[@"textContent"];
                    // model.user_id = listDict[@"user_id"];
                    
                    [__dataarr addObject:sjjmodel];
                    [__dataArr addObject:model];
                    
                }
                [htable reloadData];
                [htable.mj_header endRefreshing];
                [htable.mj_footer endRefreshing];
            }
        } failure:^(NSError *error) {
            [htable.mj_header endRefreshing];
            [htable.mj_footer endRefreshing];
            
        }];

    }
    
}
-(void)creatView{
    UIImageView *img = [[UIImageView alloc] init];
    img.frame =CGRectMake(0, NAV_BAR_HEIGHT, kScreenWidth, 315/2*HEIGHTRATIO);
    img.image = [UIImage imageNamed:@"主页背景"];
    [self.view addSubview:img];
    img.userInteractionEnabled = YES;
    
    
    iconIMG = [[UIImageView alloc]init];
    iconIMG.frame =CGRectMake(15, 60, 72, 72);
    iconIMG.image = [UIImage imageNamed:@"headImg"];
    [img addSubview:iconIMG];
    iconIMG.layer.masksToBounds = YES;
    iconIMG.layer.cornerRadius = 72/2;
    //36*36
    UIImageView *xingbieIMG = [[UIImageView alloc] init];
    xingbieIMG.frame =CGRectMake(12+iconIMG.frame.size.width-18, 60+72-18, 18, 18);
    if ([[USER_DEFAULT objectForKey:@"sex"] isEqualToString:@"0"]) {
         xingbieIMG.image = [UIImage imageNamed:@"personal_information_male@2x"];
    }else if([[USER_DEFAULT objectForKey:@"sex"] isEqualToString:@"1"]){
       xingbieIMG.image = [UIImage imageNamed:@"personal_information_male@2x"];
    }else{
        xingbieIMG.image = [UIImage imageNamed:@"personal_information_female@2x"];
    }
   
    [img addSubview:xingbieIMG];
    
    
    namelabel = [[UILabel alloc] init];
   // namelabel.text = @"鸡巴";
    namelabel.textColor = [NSString colorWithHexString:@"ffffff"];
    namelabel.font = [UIFont systemFontOfSize:16];
    [img addSubview:namelabel];
    [namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconIMG.mas_right).offset(8);
        make.top.equalTo(img).offset(70);
        make.width.equalTo(@100);
        make.height.equalTo(@16);
    }];
   dengjiIMG = [[UIImageView alloc] init];
    [img addSubview:dengjiIMG];
    
   // dengjiIMG.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",]]
    
//    dengjilabel = [[UILabel alloc] init];
//    dengjilabel.textColor = [UIColor yellowColor];
//   // dengjilabel.text = @"V4";
//    dengjilabel.font = [UIFont systemFontOfSize:16];
//    [img addSubview:dengjilabel];
    [dengjiIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(namelabel);
        make.top.equalTo(namelabel.mas_bottom).offset(12);
        make.width.equalTo(@28);
        make.height.equalTo(@28);
    }];
    
    UIButton *bianjiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bianjiBtn.frame =CGRectMake(kScreenWidth-70, 12, 50, 20);
    [bianjiBtn setImage:[UIImage imageNamed:@"personal_information_edit@2x"] forState:UIControlStateNormal];
    [img addSubview:bianjiBtn];
    [bianjiBtn addTarget:self action:@selector(click_bianji:) forControlEvents:UIControlEventTouchUpInside];
    cslabel = [[UILabel alloc] init];
    cslabel.textAlignment = NSTextAlignmentCenter;
   // cslabel.text = @"2次";
    cslabel.textColor = [NSString colorWithHexString:@"ffffff"];
    cslabel.font = [UIFont systemFontOfSize:24];
    [img addSubview:cslabel];
    [cslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(img).offset(-20);
        make.top.equalTo(bianjiBtn.mas_bottom).offset(50);
        make.width.equalTo(@100);
        make.height.equalTo(@24);
    }];
    UILabel *cishulabel = [[UILabel alloc] init];
    cishulabel.textColor = [NSString colorWithHexString:@"ffffff"];
    cishulabel.text = @"完成定制次数";
    cishulabel.textAlignment=NSTextAlignmentCenter;
    cishulabel.font = [UIFont systemFontOfSize:12];
    [img addSubview:cishulabel];
    [cishulabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cslabel);
        make.right.equalTo(cslabel);
        make.top.equalTo(cslabel.mas_bottom).offset(8);
        make.bottom.equalTo(img).offset(-34);
    }];
    }
-(void)click_bianji:(UIButton *)sender{
    NSLog(@"编辑");
    HSbianjiGRZLViewController *hsbianji = [[HSbianjiGRZLViewController alloc] init];
    [self.navigationController pushViewController:hsbianji animated:YES];
}
-(void)creatNavi{
    UIView *navi = [[UIView alloc] init];
    navi.frame =CGRectMake(0, 0,kScreenWidth , NAV_BAR_HEIGHT);
    navi.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navi];
    titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(50, kStatusBarHeight, kScreenWidth-100, NAV_BAR_HEIGHT-kStatusBarHeight)];
    titleLbl.textColor = [NSString colorWithHexString:heitizi];
    //titleLbl.text = @"昵称";
    titleLbl.font = [UIFont systemFontOfSize:16];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    [navi addSubview:titleLbl];
    UIButton *backBtn=  [YkxHttptools initwithButton:[UIColor clearColor] Frame:CGRectMake(0, kStatusBarHeight, 50, NAV_BAR_HEIGHT-kStatusBarHeight) Image:[UIImage imageNamed:@"back_arrow@2x"] Title:nil Titlecolor:[NSString colorWithHexString:heitizi ] Titlefont:[UIFont systemFontOfSize:14] BaseView:navi];
    [backBtn addTarget:self action:@selector(click_back:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)click_back:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
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
