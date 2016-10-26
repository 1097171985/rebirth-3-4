//
//  HomeViewController.m
//  rebirth
//
//  Created by 侯帅 on 16/7/11.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HomeViewController.h"
#import "LeftMenuView.h"
#import "MenuView.h"
#import "HSLunBoViewCell.h"
#import "HSTwoSecViewCell.h"
#import "HThreeViewCell.h"
#import "HSHelpViewController.h"
#import "HSBindingViewController.h"
#import "HSFourViewCell.h"
#import "HSVegetableViewController.h"
#import "HSLoginViewController.h"
#import "HSHomeModel.h"
#import "HSPayViewController.h"
#import "HSHomexiaModel.h"
#import "HSManCell.h"
#import "HSManViewController.h"
#import "HSPersonaInformationViewController.h"
#import "HSAboutViewController.h"
#import "Order.h"
#import "APAuthV2Info.h"
#import "DataSigner.h"
#import "DingZhiVC.h"
#import "TotalItinerVC.h"
#import "CCWebViewController.h"
#import "HSZCZNViewController.h"
#import "WanZhuanVC.h"

#import "HSPlayer.h"
#import "HSSementViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "ProjectManageViewController.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import "HSGerenzhongxinViewController.h"
#import "HSXYViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "WJFCouponsVC.h"
#import "PriceDingzhiVC.h"
#define LocationTimeout 3 //定位超时时间，可修改，最小2s
#define ReGeocodeTimeout 3 //逆地理请求超时时间，可修改 最小2s
@interface HomeViewController ()<HomeMenuViewDelegate,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,AMapLocationManagerDelegate,AMapSearchDelegate>
{
    
    NSString *body;
    UIImagePickerController *mypicker;
    UIButton *returnbtn;
    NSString *sttt;
    UIView *navi;
    UIButton *gpsBtn;
    
    
}
@property (nonatomic,strong)AMapLocationManager *locationManager;
@property (nonatomic,strong)AMapLocatingCompletionBlock completionBlock;
@property (nonatomic,strong)MenuView *menu;
@property (nonatomic,strong)AMapSearchAPI *search;


;
@property (nonatomic, assign) NSInteger angle;

@property(nonatomic, strong)AVPlayerLayer *playlayer;

@property(nonatomic, strong)AVPlayer  *player;
@end

@implementation HomeViewController
{
    UITableView *mainTable;
    NSMutableArray *dataArr;
    NSMutableArray *dataXiaArr;
    NSInteger pagee;
    LeftMenuView *leftmenu;
    HSVegetableViewController *hsv;
    PriceDingzhiVC *vc;
  
    
}

-(void)moviePlayerLoadStateDidChange{
    
    NSLog(@"4444444");
    [_player seekToTime:CMTimeMake(0, 1)];
    [_player play];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self httpfirst];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(someMethod)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
    
   
    // Do any additional setup after loading the view.
    
}

-(void)someMethod{
    
    if(self.player){
        
        [self.player play];
    }
    
}
-(void)httpfirst{
    /*001 第一次启动统计装机量及设备类型
     URL：http://www.rempeach.com/rebirth/api/AppApi/receive
     接口描述：第一次启动时发送，装机一次仅发送一次
     请求方式：POST
     上传参数：
     route
     version
     system
     appVersion
     deviceID
     deviceInfo
     
     a b c d e f g h i j k l m n o p q r s t u v w x y z
     
     返回参数：state ：210 101  状态码（见附录）
*/
    NSString *appVersion =@"2.0.0";
    NSString *deviceID = [YkxHttptools randomUUID];
    NSString *deviceInfo = [[UIDevice currentDevice] model];
    
    NSString *route = @"Index_firstLaunch";
    NSString *system =[[UIDevice currentDevice] systemName];
    NSString *version = @"1";
    
    
}

-(void)ggSmida{
    
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    [self configLocationManager];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerLoadStateDidChange)name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    
    
    // [self httpCeshi];
    //    int num = (arc4random() % 1000000);
    //   NSString* randomNumber = [NSString stringWithFormat:@"%.5d", num];
    //    NSLog(@"%@", randomNumber);
    
    //  self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    leftmenu = [[LeftMenuView alloc] initWithFrame:CGRectMake(0, 0,  [[UIScreen mainScreen] bounds].size.width * 0.64, [[UIScreen mainScreen] bounds].size.height)];
    leftmenu.customDelegate = self;
    leftmenu.alpha = 0.8;
    self.menu = [[MenuView alloc] initWithDependencyView:self.view MenuView:leftmenu isShowCoverView:YES];
    
    [self creatBtn];
    self.view.backgroundColor = [UIColor whiteColor];
    dataArr = [[NSMutableArray alloc] init];
    dataXiaArr = [[NSMutableArray alloc] init];
    _homeModel = [[HSHomeModel alloc] init];
    _homeModel1 = [[HSHomeModel alloc] init];
    _homeModel2 = [[HSHomeModel alloc] init];
    _homexiamodel = [[HSHomexiaModel alloc] init];
    pagee = 1;
    [self httpHomeTop];
    [self httpHomeXia];
    [self creatTab];
    [self creatNavi];
    [self creattab];
    __weak typeof(self)weakSelf = self;
    __weak UITableView *table = mainTable;
    //    table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    //        pagee = 1;
    //        [dataXiaArr removeAllObjects];
    //        [self httpHomeXia];
    //    }];
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [footer setTitle:@"" forState:MJRefreshStateIdle];
        [footer setTitle:@"松开获取更多数据" forState:MJRefreshStateWillRefresh];
        [footer setTitle:@"获取中" forState:MJRefreshStateRefreshing];
        [footer setRefreshingTitleHidden:YES];
        pagee++;
        [self httpHomeXia];
        [table.mj_footer endRefreshing];
    }];
    table.mj_footer = footer;
    
    

    
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    if (homePlayer) {
//        [homePlayer play];
//    }
    
    [self httptouxiang];
    
    NSString *idd = [USER_DEFAULT objectForKey:@"token"];
    NSString *iddd = [NSString stringWithFormat:@"%@",idd];
    if (iddd.length<7) {
        [leftmenu.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [leftmenu.NameBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
        // [leftmenu.NameLabel setText:@"登录/注册"];
        leftmenu.arrow.image = [UIImage imageNamed:@"default_avatar@2x"];
    }else{
        [leftmenu.loginBtn setTitle:@"注销" forState:UIControlStateNormal];
        // [leftmenu.NameLabel setText:[USER_DEFAULT objectForKey:@"phone"]];
        [leftmenu.NameBtn setTitle:[USER_DEFAULT objectForKey:@"phone"] forState:UIControlStateNormal];
    }
    
    
    [self ggSmida];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];

    if (self.player) {
        
        [self.player pause];
        
        self.playlayer = nil;
        
        self.player = nil;
    }
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    [super viewWillDisappear:animated];
}

-(void)httptouxiang{
    /*112 获取用户信息
     URL：http://www.rempeach.com/rebirth/api/user/get_userInfo
     接口描述：获取用户信息
     请求方式：GET
     上传参数：
     
     返回参数：state ：200 111 101 121 状态码（见附录）
     */
    NSString *transformId = [USER_DEFAULT objectForKey:@"id"];
    NSString *round = @"12345";
    NSString *token = [USER_DEFAULT objectForKey:@"token"];
    NSArray *nameList = @[@"id",vn(round),vn(token)];
    
    NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(transformId),sv(round),sv(token),nil];
    NSLog(@"%@",parameters1);
    NSString *str = sv(transformId);
    [YkxHttptools get:@"http://www.rempeach.com/rebirth/api/user/get_userInfo" params:parameters1 success:^(id responseObj) {
        NSString *finishStr = [[NSString alloc]initWithData:responseObj encoding:NSUTF8StringEncoding];
        finishStr = [YkxHttptools repTabStr:finishStr];
        NSDictionary *paramDic = [[[SBJsonParser alloc]init] objectWithString:finishStr];
        NSLog(@"%@",paramDic);
        if ([[paramDic objectForKey:@"state"] isEqualToString:@"200"]) {
            NSDictionary *dic = [paramDic objectForKey:@"data"];
            sttt= [dic objectForKey:@"head_img"];
            
            
            
            //[user setObject:@"" forKey:@""];
            if (sttt.length >0) {
                [leftmenu.arrow sd_setImageWithURL:[NSURL URLWithString:sttt] placeholderImage:nil];
                
                [returnbtn sd_setImageWithURL:[NSURL URLWithString:sttt] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"my@2x"]];
                
            }else{
                
                leftmenu.arrow.image = [UIImage imageNamed:@"default_avatar"];
                [returnbtn setImage:[UIImage imageNamed:@"my@2x"] forState:UIControlStateNormal];
            }
            
            
        }else{
            
            // [Common tipAlert:@"请重新登录"];
            [USER_DEFAULT removeObjectForKey:@"id"];
            [USER_DEFAULT removeObjectForKey:@"token"];
            [USER_DEFAULT removeObjectForKey:@"phone"];
            leftmenu.arrow.image = [UIImage imageNamed:@"default_avatar"];
            [returnbtn setImage:[UIImage imageNamed:@"my@2x"] forState:UIControlStateNormal];
            
        }
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)httpHomeTop{
    /*
     200 首页上半部分
     URL：www.rempeach.com/rebirth/api/index/getIndex
     接口描述：上半部分三张banner图（建议设置缓存）以及通知开关
     请求方式：GET
     上传参数：
     
     id          5
     token
     sign
     返回参数：state ：200 111 101 121 状态码（见附录）
     
     a b c d e f g h i g k l m n o p q r s t u v w x y z
     
     */
    
    
    NSString *idd = [USER_DEFAULT objectForKey:@"id"];
    NSString *token = [USER_DEFAULT objectForKey:@"token"];
    NSArray *nameList = @[vn(id),vn(token)];
    
    
    NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(idd),sv(token),nil];
    NSLog(@"%@",parameters1);
    [YkxHttptools get:shouyeTop params:parameters1 success:^(id responseObj) {
        NSString *finishStr = [[NSString alloc]initWithData:responseObj encoding:NSUTF8StringEncoding];
        finishStr = [YkxHttptools repTabStr:finishStr];
        NSDictionary *paramDic = [[[SBJsonParser alloc]init] objectWithString:finishStr];
        NSLog(@"%@",paramDic);
        if ([[paramDic objectForKey:@"state"] isEqualToString:@"200"]) {
            
            NSDictionary   *brr = [paramDic objectForKey:@"data"];
            NSLog(@"-----------------%@---------------",brr);
            NSArray *arr = [brr objectForKey:@"index_list"];
            NSDictionary *dic = arr[0];
            NSDictionary *dic1 = arr[1];
            NSDictionary *dic2 = arr[2];
            NSLog(@"%@11111111111",dic);
            _homeModel = [HSHomeModel HSHomeModel:dic];
            _homeModel1 = [HSHomeModel HSHomeModel:dic1];
            _homeModel2 = [HSHomeModel HSHomeModel:dic2];
            NSLog(@"%@333333",_homeModel);
            
            [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [dataArr addObject:obj];
                
            }];
            NSLog(@"%@22222222",dataArr);
            
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
            [mainTable reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            NSIndexSet *indexSet1=[[NSIndexSet alloc]initWithIndex:3];
            [mainTable reloadSections:indexSet1 withRowAnimation:UITableViewRowAnimationAutomatic];
            // [mainTable reloadData];
            
            
            
            // NSLog(@"%@",brr[@"index_list"]);
        }
    } failure:^(NSError *error) {
        
    }];
    
}
-(void)httpHomeXia{
    /*
     201 首页下半部分
     URL：http://www.rempeach.com/rebirth/api/index/getIndexList
     接口描述：下半部分新闻列表（每次15条数据）
     请求方式：GET
     上传参数：
     id
     page
     token
     sign
     a b c d e f g h i g k l m n o p q r s t u v w x y z
     返回参数：state ：200 111 101 121 状态码（见附录）
     */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *page =[NSString stringWithFormat:@"%ld",pagee];
            
            NSArray *nameList = @[vn(page)];
            
            NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(page),nil];
            NSLog(@"%@",parameters1);
            [YkxHttptools get:shouyexia params:parameters1 success:^(id responseObj) {
                NSString *finishStr = [[NSString alloc]initWithData:responseObj encoding:NSUTF8StringEncoding];
                finishStr = [YkxHttptools repTabStr:finishStr];
                NSDictionary *paramDic = [[[SBJsonParser alloc]init] objectWithString:finishStr];
                NSLog(@"%@",paramDic);
                if ([[paramDic objectForKey:@"state"] isEqualToString:@"200"]) {
                    NSDictionary   *brr = [paramDic objectForKey:@"data"];
                    NSLog(@"-----------------%@---------------",brr);
                    NSArray *arrr = [brr objectForKey:@"list"];
                    [arrr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        [dataXiaArr addObject:obj];
                    }];
                    NSDictionary *dic = arrr[0];
                    //单独刷新有动画错乱的bug
                   [UIView performWithoutAnimation:^{
                        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:4];
                      [mainTable reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                    }];
                    
                    
                     [mainTable.mj_footer endRefreshing];
                    [mainTable.mj_header endRefreshing];
                    
                  //  [mainTable reloadData];
                    
                }else if ([[paramDic objectForKey:@"state"] isEqualToString:@"100"]){
                    [mainTable.mj_footer endRefreshingWithNoMoreData];
                    [mainTable.mj_footer setHidden:YES];
                    [mainTable.mj_header endRefreshing];
                    
                }else if ([[paramDic objectForKey:@"state"] isEqualToString:@"111"]){
                    [mainTable.mj_header endRefreshing];
                    
                }else if ([[paramDic objectForKey:@"state"] isEqualToString:@"101"]){
                    [mainTable.mj_header endRefreshing];
                    
                }else if ([[paramDic objectForKey:@"state"] isEqualToString:@"121"]){
                    [mainTable.mj_header endRefreshing];
                    
                    [LCProgressHUD showStatus:LCProgressHUDStatusInfo text:@"您的账号异常,已经在其他设备登录,已退出你的登录状态"];
                    [USER_DEFAULT removeObjectForKey:@"id"];
                    [USER_DEFAULT removeObjectForKey:@"token"];
                }
                
            } failure:^(NSError *error) {
               
            }];
            
        });
    });
}

#pragma mark-----table----

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 4) {
        return 40;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    //    UILabel *label = [[UILabel alloc]init];
    //    // label.font = [UIFont systemFontOfSize:12 ];
    //    label.font = [UIFont systemFontOfSize:12 weight:bold];
    //    label.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    //    label.text = @"一 对味 一";
    //    label.textColor = [NSString colorWithHexString:heitizi];
    //    label.textAlignment = NSTextAlignmentCenter;
    //
    //    return  label;
    // 118 * 25
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *iconIMG = [[UIImageView alloc] init];
    iconIMG.frame =CGRectMake((kScreenWidth-59)/2, 14, 118/2, 25/2);
    iconIMG.image = [UIImage imageNamed:@"biggerup@2x"];
    [view addSubview:iconIMG];
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==4) {
        return dataXiaArr.count;
    }else{
        
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = nil;
    cellID = [NSString stringWithFormat:@"cellID%ld",(long)indexPath.section];
 ;
    
    switch (indexPath.section) {
        case 0:
        {
        
             HSLunBoViewCell   *cell = [[HSLunBoViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            NSString *path=[[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"];
            //
            NSURL *url=[[NSURL alloc] initFileURLWithPath:path];
            AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
            
            //初始化player对象
            self.player = [[AVPlayer alloc] initWithPlayerItem:item];
            //设置播放页面
            self.playlayer = [AVPlayerLayer playerLayerWithPlayer:_player];
          // self.playlayer.backgroundColor = [UIColor greenColor].CGColor;
            //设置播放页面的大小
            NSLog(@"%@",cell.imageScrollView);
            //cell.imageScrollView.layer.backgroundColor = [UIColor blueColor].CGColor;
            
            NSLog(@"%@",cell.imageScrollView.layer);
            self.playlayer.frame =cell.imageScrollView.frame;
            // layer.backgroundColor = [UIColor blueColor].CGColor;
            //设置播放窗口和当前视图之间的比例显示内容
           self.playlayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
            
           // cell.layer.backgroundColor = [UIColor redColor].CGColor;
            [cell.imageScrollView.layer addSublayer:self.playlayer];
            
            //设置播放的默认音量值
            //self.player.volume = 100;
            [self.player play];
            
            
            return cell;
        }
        case 1:
        {
            HSTwoSecViewCell *cell = [[HSTwoSecViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            [cell.zucheBtn addTarget:self action:@selector(click_chezu:) forControlEvents:UIControlEventTouchUpInside];
            [cell.wanzhuanBtn addTarget:self action:@selector(wanzhuanBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        case 2:{
            HThreeViewCell*   cell=(HThreeViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"HThreeViewCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            HThreeViewCell *celll = cell;
            [celll setModel:_homeModel];
            NSLog(@"%@44444",_homeModel);
            
            
            return cell;
        }
        case 3:{
             HSFourViewCell*   cell = [[HSFourViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            HSFourViewCell *celll = cell;
            celll.secondBtn.tag = 1000+indexPath.section+indexPath.row;
            celll.firstBtn.tag = 2000+indexPath.section;
            [celll.firstBtn addTarget:self action:@selector(clcik_canting:) forControlEvents:UIControlEventTouchUpInside];
            [celll.secondBtn addTarget:self action:@selector(click_jiudian:) forControlEvents:UIControlEventTouchUpInside];
            [celll setmodel:_homeModel1];
            [celll setmodell:_homeModel2];
            return cell;
        }
        case 4:{
           
            HSManCell   *cell = [[HSManCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
           //cell.opaque =YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            HSManCell *celll = cell;
            NSLog(@"%lu12121212",dataXiaArr.count);
            if (dataXiaArr.count!=0) {
                
                        NSDictionary *dic = dataXiaArr[indexPath.row];
                        _homexiamodel  = [HSHomexiaModel HSHomeXiaModel:dic];
                        
                        [celll setXiamodel:_homexiamodel];
                 
                };
                return cell;
                
            }
        default:{
            
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            return cell;
            break;
        }
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 510/2+20;
            break;
        case 1:{
            return 70;
        }
        case 2:{
            return 128*HEIGHTRATIO;
        }
        case 3:{
            return 130;
        }
        case 4:{
            return 182*HEIGHTRATIO;
        }
        default:
            return 0;
            break;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==4) {
        NSDictionary *dic = dataXiaArr[indexPath.row];
        CCWebViewController *ccw = [[CCWebViewController alloc] init];
        [ccw showWithContro:self withUrlStr:[dic objectForKey:@"url"] withTitle:@"对味"];
        
     //   [CCWebViewController showWithContro:self withUrlStr:[dic objectForKey:@"url"] withTitle:@"男人装"];
    }else if (indexPath.section ==2){
        NSDictionary *dic = dataArr[indexPath.row];
        
        
        hsv = [[HSVegetableViewController alloc] init];
        
        
        hsv.info_id =[dic objectForKey:@"info_id"];
        hsv.caipu = @"car";
        hsv.arrow = @"home";
        [self.navigationController pushViewController:hsv animated:YES];
        
    }
    
}

//滚动导航变色
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"offset---scroll:%f",mainTable.contentOffset.y);
    UIColor *color=[NSString colorWithHexString:@"27292b"];
    CGFloat offset=scrollView.contentOffset.y;
    if (offset<1) {
        
        navi.backgroundColor = [color colorWithAlphaComponent:0];
    }else {
        CGFloat alpha=1-((kScreenHeight-offset)/kScreenHeight);
        navi.backgroundColor=[color colorWithAlphaComponent:alpha];
        NSLog(@"%f11111111111111",alpha);
    }
}
//cell动画
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    static float lastOff =0;
    if (indexPath.section==4) {
        if (tableView.contentOffset.y > lastOff) {
            
            cell.alpha = 0.0;
            cell.layer.transform = CATransform3DMakeTranslation(0, 180, 0);;
            
            [UIView animateWithDuration:0.2 animations:^{
                cell.alpha = 1.0;
                cell.layer.transform = CATransform3DIdentity;
            }];
            lastOff = tableView.contentOffset.y;

            
        } else{
            cell.alpha = 1;
            
            
        }
        
        
    }
    
    
    NSLog(@"%ld",(long)lastOff);
    
    
}
#pragma mark---点击事件---

-(void)click_a:(UIButton *)sender{
    NSLog(@"开启rebirth");
    if (!vc) {
        vc = [[PriceDingzhiVC alloc]init];
    }
    
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)click_dingzhi:(UIButton *)sender{
    if (!vc) {
        vc = [[PriceDingzhiVC alloc]init];
    }
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


-(void)click_jingcheng:(UIButton *)sender{
    
    
    NSMutableString *userid = [USER_DEFAULT objectForKey:@"id"];
    
    if (!userid) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"您需要登录,请先登录" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSLog(@"确定");
            HSLoginViewController *login = [[HSLoginViewController alloc]init];
            login.source = @"ItineraryVC";
            
            [UIView transitionWithView: self.navigationController.view
                              duration: 0.35f
                               options: nil
                            animations: ^(void)
             {
                 
                 CATransition *transition = [CATransition animation];
                 transition.type = kCATransitionPush;
                 transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                 transition.fillMode = kCAFillModeForwards;
                 transition.duration = 0.6;
                 transition.subtype = kCATransitionFromBottom;
                 [[self.navigationController.view layer] addAnimation:transition forKey:@"NavigationControllerAnimationKey"];
                 
             }completion: ^(BOOL isFinished)
             {
                 /* TODO: Whatever you want here */
                 [self.navigationController.view.layer removeAnimationForKey:@"NavigationControllerAnimationKey"];
                 
             }];
            
            [self.navigationController pushViewController:login animated:NO];
            
            
            
            
            
        }];
        
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            NSLog(@"取消");
            
        }];
        
        [alert addAction:ok];//添加按钮
        [alert addAction:cancel];//添加按钮
        //以modal的形式
        [self presentViewController:alert animated:YES completion:^{ }];
        
        
    }else{
        
        
        
        
        TotalItinerVC *itvc = [[TotalItinerVC alloc]init];
        
        [self.navigationController pushViewController:itvc animated:YES];
        
        
    }
    
}

-(void)click_duiwei:(UIButton *)sender{
    
    NSLog(@"对味");
   // TopMenuSelectViewController *hsman = [[TopMenuSelectViewController alloc] init];
    HSSementViewController *hsman = [[HSSementViewController alloc] init];
   // HSManViewController*hsman = [[HSManViewController alloc] init];
    [self.navigationController pushViewController:hsman animated:YES];
}

-(void)clcik_canting:(UIButton *)sender{
    
    
    NSDictionary *dic = dataArr[1];
    
    HSVegetableViewController *hs = [[HSVegetableViewController alloc] init];
    
    
    hs.info_id = [dic objectForKey:@"info_id"];
    hs.arrow = @"home";
    [self.navigationController pushViewController:hs animated:YES];
    
}
-(void)click_jiudian:(UIButton *)sender{
    NSDictionary *dic = dataArr[2];
    
    HSVegetableViewController *hsve = [[HSVegetableViewController alloc] init];
    
    hsve.arrow = @"home";
    hsve.info_id = [dic objectForKey:@"info_id"];
    
    [self.navigationController pushViewController:hsve animated:YES];
}
-(void)click_chezu:(UIButton *)sender{
    [self.navigationController pushViewController:[[HSZCZNViewController alloc] init] animated:YES];
}
-(void)LeftMenuViewClick:(NSInteger)tag{
    [self.menu hidenWithAnimation];
    
    NSLog(@"tag = %lu",tag);
    
    if (tag == 1) {
        HSHelpViewController *help = [[HSHelpViewController alloc] init];
        
        [self.navigationController pushViewController:help animated:YES];
        
    }else if (tag ==0){
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSMutableString *userid = [user objectForKey:@"id"];
        
        if (!userid) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"您需要登录,请先登录" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                
                NSLog(@"确定");
                HSLoginViewController *login = [[HSLoginViewController alloc]init];
                login.source = @"BindingView";
                
                [UIView transitionWithView: self.navigationController.view
                                  duration: 0.35f
                                   options: nil
                                animations: ^(void)
                 {
                     
                     CATransition *transition = [CATransition animation];
                     transition.type = kCATransitionPush;
                     transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                     transition.fillMode = kCAFillModeForwards;
                     transition.duration = 0.6;
                     transition.subtype = kCATransitionFromBottom;
                     [[self.navigationController.view layer] addAnimation:transition forKey:@"NavigationControllerAnimationKey"];
                     
                 }completion: ^(BOOL isFinished)
                 {
                     /* TODO: Whatever you want here */
                     [self.navigationController.view.layer removeAnimationForKey:@"NavigationControllerAnimationKey"];
                     
                 }];
                
                [self.navigationController pushViewController:login animated:NO];
                
                
                
                
                
            }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                NSLog(@"取消");
                
            }];
            
            [alert addAction:ok];//添加按钮
            [alert addAction:cancel];//添加按钮
            //以modal的形式
            [self presentViewController:alert animated:YES completion:^{ }];
            
            
        }else{
            
            [self.navigationController pushViewController:[[HSBindingViewController alloc] init] animated:YES];
        }
        
    }
    //    else if (tag ==0){
    //       // [self.navigationController pushViewController:[[HSVegetableViewController alloc] init] animated:YES];
    //    }
    else if (tag ==1000){
//        if ([USER_DEFAULT objectForKey:@"id"]) {
//            
//        }else{
        
        [USER_DEFAULT removeObjectForKey:@"id"];
        [USER_DEFAULT removeObjectForKey:@"token"];
        [USER_DEFAULT removeObjectForKey:@"phone"];
        sttt=@"";
        HSLoginViewController *hslg = [[HSLoginViewController alloc] init];
            [self.navigationController pushViewController:hslg animated:YES];
    }else if (tag==1111){
                if ([USER_DEFAULT objectForKey:@"id"]) {
        
                }else{
        
        [USER_DEFAULT removeObjectForKey:@"id"];
        [USER_DEFAULT removeObjectForKey:@"token"];
        [USER_DEFAULT removeObjectForKey:@"phone"];
        sttt=@"";
        HSLoginViewController *hslg = [[HSLoginViewController alloc] init];
        [self.navigationController pushViewController:hslg animated:YES];
                }
    }
    else if (tag ==2){
//         [self.navigationController pushViewController:[[HSGerenzhongxinViewController alloc] init] animated:YES];
        HSAboutViewController *hsab= [[HSAboutViewController alloc] init];
        
        [self.navigationController pushViewController:hsab animated:YES];
    }else if (tag ==1001){
        if (![USER_DEFAULT objectForKey:@"id"]) {
            [Common tipAlert:@"请登录"];
        }else{
        HSGerenzhongxinViewController *hs = [[HSGerenzhongxinViewController alloc] init];
            [self.navigationController pushViewController:hs animated:YES];}
        //  [self.navigationController pushViewController:[[HSPersonaInformationViewController alloc] init] animated:YES];
       
//        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//        NSMutableString *userid = [user objectForKey:@"id"];
//        
//        if (!userid) {
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"您需要登录,请先登录" preferredStyle:UIAlertControllerStyleAlert];
//            
//            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                
//                
//                NSLog(@"确定");
//                HSLoginViewController *login = [[HSLoginViewController alloc]init];
//                login.source = @"ItineraryVC";
//                
//                [UIView transitionWithView: self.navigationController.view
//                                  duration: 0.35f
//                                   options: nil
//                                animations: ^(void)
//                 {
//                     
//                     CATransition *transition = [CATransition animation];
//                     transition.type = kCATransitionPush;
//                     transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//                     transition.fillMode = kCAFillModeForwards;
//                     transition.duration = 0.6;
//                     transition.subtype = kCATransitionFromBottom;
//                     [[self.navigationController.view layer] addAnimation:transition forKey:@"NavigationControllerAnimationKey"];
//                     
//                 }completion: ^(BOOL isFinished)
//                 {
//                     /* TODO: Whatever you want here */
//                     [self.navigationController.view.layer removeAnimationForKey:@"NavigationControllerAnimationKey"];
//                     
//                 }];
//                
//                [self.navigationController pushViewController:login animated:NO];
//                
//                
//                
//            }];
//            
//            
//            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//                
//                NSLog(@"取消");
//                
//            }];
//            
//            [alert addAction:ok];//添加按钮
//            [alert addAction:cancel];//添加按钮
//            //以modal的形式
//            [self presentViewController:alert animated:YES completion:^{ }];
//            
//            
//        }else{
//            
//            
//            
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//            
//            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                
//                NSLog(@"确定");
//                if (TARGET_IPHONE_SIMULATOR) {
//                    [Common tipAlert:@"模拟器无拍照功能"];
//                }else{
//                    
//                    
//                    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
//                    // 2. 创建图片选择控制器
//                    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
//                    /**
//                     typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
//                     UIImagePickerControllerSourceTypePhotoLibrary, // 相册
//                     UIImagePickerControllerSourceTypeCamera, // 用相机拍摄获取
//                     UIImagePickerControllerSourceTypeSavedPhotosAlbum // 相簿
//                     }
//                     */
//                    // 3. 设置打开照片相册类型(显示所有相簿)
//                    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
//                    // ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//                    // 照相机
//                    // ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
//                    // 4.设置代理
//                    ipc.delegate = self;
//                    // 5.modal出这个控制器
//                    [self presentViewController:ipc animated:YES completion:nil];
//                    
//                    
//                }
//                
//                
//            }];
//            UIAlertAction *cancel1 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                
//                NSLog(@"取消");
//                NSLog(@"确定");
//                if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
//                // 2. 创建图片选择控制器
//                UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
//                /**
//                 typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
//                 UIImagePickerControllerSourceTypePhotoLibrary, // 相册
//                 UIImagePickerControllerSourceTypeCamera, // 用相机拍摄获取
//                 UIImagePickerControllerSourceTypeSavedPhotosAlbum // 相簿
//                 }
//                 */
//                // 3. 设置打开照片相册类型(显示所有相簿)
//                ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//                // ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//                // 照相机
//                // ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
//                // 4.设置代理
//                ipc.delegate = self;
//                // 5.modal出这个控制器
//                [self presentViewController:ipc animated:YES completion:nil];
//                
//                
//                
//                
//                
//            }];
//            
//            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//                
//                NSLog(@"取消");
//                
//            }];
//            
//            [alert addAction:ok];//添加按钮
//            [alert addAction:cancel1];
//            [alert addAction:cancel];//添加按钮
//            //以modal的形式
//            [self presentViewController:alert animated:YES completion:^{ }];
//        }
    }else if (tag==3){
        NSLog(@"优惠券");
        if (![USER_DEFAULT objectForKey:@"id"]) {
            [Common tipAlert:@"请登录"];
        }else{
            WJFCouponsVC *his = [[WJFCouponsVC alloc] init];
            [self.navigationController pushViewController:his animated:YES];

        }
            
           }
}

#pragma mark -- <UIImagePickerControllerDelegate>--
//当选择一张图片后进入到这个协议方法里
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
//{
//    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
//    //当选择的类型是图片
//    if ([type isEqualToString:@"public.image"])
//    {
//
//        //先把图片转成NSData
//        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
//
//
//        NSData *data1;
//        if (UIImagePNGRepresentation(image) == nil)
//        {
//            data1 = UIImageJPEGRepresentation(image, 1);
//        }
//        else
//        {
//            data1 = UIImagePNGRepresentation(image);
//        }
//        [YkxHttptools imageData:image];
//
//        [self saveImage:image withName:@"image.png"];
//
//        //图片保存的路径
//        //这里将图片放在沙盒的documents文件夹中
//        //        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//        //        //文件管理器
//        //        NSFileManager *fileManager = [NSFileManager defaultManager];
//        //        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
//        //        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
//        //        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data1 attributes:nil];
//        //        //得到选择后沙盒中图片的完整路径
//        //        NSString *filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];self.dirveimg.image = image;
//
//        // NSLog(@"%@",filePath);
//        // //关闭相册界面
//        [picker dismissViewControllerAnimated:YES completion:^{
//            NSLog(@"关闭相册界面");
//        }];
//
//
//    }
//}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)clikc_btn:(UIButton *)sedner{
    [self.menu show];
}
#pragma mark wanzhaunbtuu

-(void)wanzhuanBtn:(UIButton *)btu{
    
    WanZhuanVC *wzvc = [[WanZhuanVC alloc]init];
    
    [self.navigationController pushViewController:wzvc animated:YES];
    
    
}



#pragma mark---创建控件---
-(void)creattab{
    //96*96
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(kScreenWidth/2-48-32-48-32/2, kScreenHeight-60, 48, 48);
    
    [btn setImage:[UIImage imageNamed:@"home@2x"] forState:UIControlStateNormal];
    // [btn setTitle:@"开启" forState:UIControlStateNormal];
    
    
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(click_dingzhi:) forControlEvents:UIControlEventTouchUpInside];
    // btn.layer.cornerRadius = 3;
    // btn.layer.shadowOffset = CGSizeMake(-1, 1);
    //btn.layer.shadowOpacity = 1;
    // btn.layer.shadowColor = [UIColor blackColor].CGColor;
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame =CGRectMake(kScreenWidth/2-48-32/2, kScreenHeight-60, 48, 48);
    [btn2 setImage:[UIImage imageNamed:@"dui_wei@2x"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(click_duiwei:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    btn2.layer.cornerRadius = 3;
    // btn2.layer.shadowOffset = CGSizeMake(-1, 1);
    //  btn2.layer.shadowOpacity = 0.8;
    // btn2.layer.shadowColor = [UIColor blackColor].CGColor;
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame =CGRectMake(kScreenWidth/2+32/2, kScreenHeight-60, 48, 48);
    [btn1 setImage:[UIImage imageNamed:@"travel_route@2x"] forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    [btn1 addTarget:self action:@selector(click_jingcheng:) forControlEvents:UIControlEventTouchUpInside];
    btn1.layer.cornerRadius = 3;
    // btn1.layer.shadowOffset = CGSizeMake(-1, 1);
    // btn1.layer.shadowOpacity = 0.8;
    //  btn1.layer.shadowColor = [UIColor blackColor].CGColor;
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame =CGRectMake(kScreenWidth/2+32/2+btn2.frame.size.width+32, kScreenHeight-60, 48, 48);
    [btn3 setImage:[UIImage imageNamed:@"wish@2x"] forState:UIControlStateNormal];
    [self.view addSubview:btn3];
    [btn3 addTarget:self action:@selector(click_xinyuan:) forControlEvents:UIControlEventTouchUpInside];
    btn1.layer.cornerRadius = 3;

    
}
-(void)click_xinyuan:(UIButton *)sender{
    NSLog(@"心愿");
    if (![USER_DEFAULT objectForKey:@"id"]) {
        [Common tipAlert:@"请登录"];
        
    }else{
        HSXYViewController *hsxy = [[HSXYViewController alloc] init];
        [self.navigationController pushViewController:hsxy animated:YES];
    }
   
}
-(void)creatBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(32, 210, kScreenWidth-32*2, 96/2);
    [btn setBackgroundColor:[NSString colorWithHexString:heitizi]];
    [btn setTitle:@"开始UP！" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [mainTable addSubview:btn];
    [btn addTarget:self action:@selector(click_a:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 3;
    btn.layer.shadowOffset = CGSizeMake(-1, 1);
    btn.layer.shadowOpacity = 0.8;
    btn.layer.shadowColor = [UIColor blackColor].CGColor;
    
}
-(void)creatNavi{
    //底层view
    
    navi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,NAV_BAR_HEIGHT)];
    navi.backgroundColor = [UIColor clearColor];
    [self.view addSubview:navi];
    
    UILabel *titlelbl = [[UILabel alloc] init];
    returnbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnbtn.frame = CGRectMake(8, kStatusBarHeight+5, 56/2, 56/2);
    returnbtn.layer.masksToBounds = YES;
    returnbtn.layer.cornerRadius = 56/4;
    [returnbtn setImage:[UIImage imageNamed:@"my@2x"] forState:UIControlStateNormal];
    [returnbtn sd_setImageWithURL:[NSURL URLWithString:sttt] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"my@2x"]];
    [returnbtn addTarget:self action:@selector(clikc_btn:) forControlEvents:UIControlEventTouchUpInside];
    [navi addSubview:returnbtn];
    
    
    //132*88   66   44
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(171*WIDTHRATIO, kStatusBarHeight+7, 33,22)];
    img.image = [UIImage imageNamed:@"logoo@2x"];
    [navi addSubview:img];
    //    titlelbl.frame = CGRectMake(12+returnbtn.frame.size.width, kStatusBarHeight, kScreenWidth-12-returnbtn.frame.size.width-12-returnbtn.frame.size.width, NAV_BAR_HEIGHT-kStatusBarHeight);
    //    titlelbl.text = @"UP！";
    //    titlelbl.textColor = [UIColor whiteColor];
    //    titlelbl.font = [UIFont systemFontOfSize:38/2];
    //    titlelbl.textAlignment = NSTextAlignmentCenter;
    //    [navi addSubview:titlelbl];
   gpsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    gpsBtn.frame =CGRectMake(kScreenWidth-60, kStatusBarHeight+13, 50, 16);
    [gpsBtn setTitle:@"杭州" forState:UIControlStateNormal];
    gpsBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [navi addSubview:gpsBtn];
    
}

-(void)creatTab{
    mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, -kStatusBarHeight, kScreenWidth, kScreenHeight+kStatusBarHeight) style:UITableViewStylePlain];
    mainTable.backgroundColor = [UIColor whiteColor];
    mainTable.delegate = self;
    mainTable.dataSource = self;
    //mainTable.opaque = YES;
    [self.view addSubview:mainTable];
    //线
    mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self creatBtn];
}

-(void)creatGD{
    
}
#pragma mark 获取 定位
- (void)configLocationManager
{
    
    [AMapLocationServices sharedServices].apiKey = @"c822e9e86d82c9da13e1b37a00dfa8da";
    _locationManager = [[AMapLocationManager alloc] init];
    
    [_locationManager setDelegate:self];
    
    // 设定定位精度
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    
    // 指定单次定位超时时间
    _locationManager.locationTimeout = 6;
    
    // 指定单次定位逆地理超时时间,默认为5s。最小值是2s
    _locationManager.reGeocodeTimeout = 3;
    
    
    //带逆地理的单次定位
    [_locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
        //定位信息
        NSLog(@"定位信息:%@", location);
        
        //逆地理信息
        if (regeocode)
        {
            NSLog(@"定位城市:%@", regeocode.city);
            [gpsBtn setTitle:regeocode.city forState:UIControlStateNormal];
        }
    }];
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
