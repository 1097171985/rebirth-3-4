//
//  HSSementViewController.m
//  rebirth
//  对味
//  Created by 侯帅 on 16/9/21.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSSementViewController.h"
#import "YAScrollSegmentControl.h"
#import "HSFHMCell.h"
#import "SDImageCache.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
#import "CCWebViewController.h"
#import "HSShejiaoCell.h"
#import "HSphotoViewController.h"
#import "MyModel.h"
#import "TableViewCell.h"
#import "Header.h"
#import "HSShejiaoModel.h"
#import "DisProModel.h"
#import "WJFVideoVC.h"
#import "ReplaceZhengWenVC.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "HomeViewController.h"

#define MENU_BUTTON_WIDTH 80
#define ViewWidth [[UIScreen mainScreen] bounds].size.width
#define ViewHeight [[UIScreen mainScreen] bounds].size.height
@interface HSSementViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ImageDelegate,fromDelegate,backdelegate>
@property (nonatomic, copy) NSArray *contentArray;
@property (strong, nonatomic) TableViewCell *cell;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableArray *dataShejiaoArr;
@property (strong,nonatomic)NSMutableArray *data;

@property (strong,nonatomic)YAScrollSegmentControl *segmentControl;
/**
 *  声明播放视频的控件属性[既可以播放视频也可以播放音频]
 */
@property (nonatomic,strong)AVPlayer *player;
/**
 *  播放的总时长
 */
@property (nonatomic,assign)CGFloat sumPlayOperation;
@property(nonatomic,strong)AVPlayerLayer *playlayer;

@property(nonatomic, strong)UIImageView  *lastplayImageView;

@property(nonatomic, strong)NSString *lastplayImageStr;

@end

@implementation HSSementViewController
{
    UITableView *htable;
    UITableView *hstable;
    NSMutableArray *dataXiaArr;
   // NSMutableArray *dataShejiaoArr;
    CCWebViewController *ccweb;
    NSInteger pagee;
    UIImagePickerController *imagePicker;
    NSString *fors;
    NSInteger pag;
    UIButton *addBtn;

}
-(NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


-(void)checkImage:(NSString *)imgname{
    
    self.navigationController.navigationBar.alpha = 0;
    hstable.scrollEnabled = NO;
    UIImageView *bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgImage.image = [UIImage imageNamed:imgname];
    [bgImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imgname]] placeholderImage:nil];
    bgImage.contentMode = UIViewContentModeScaleToFill;
    bgImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [bgImage addGestureRecognizer:tap];
    [self.view addSubview:bgImage];
}
-(void)clicksss:(NSString *)stttt{
    fors =stttt;
    [self creatNavi];
}
-(void)click:(NSString *)from{
    fors = from;
    [self creatNavi];
    
}
-(void)tapClick:(UITapGestureRecognizer*)tap{
    
    self.navigationController.navigationBar.alpha = 1;
    hstable.scrollEnabled = YES;
    [tap.view removeFromSuperview];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
   // [self creatNavi];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [self.player pause];
    
    self.player = nil;
    [self httpShejiao];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    pag = 1;
    dataXiaArr = [[NSMutableArray alloc] init];
     _dataShejiaoArr = [[NSMutableArray alloc] init];
    _hsmodel = [[HSHomexiaModel alloc] init];
    _hsshejiaomodel = [[HSShejiaoModel alloc] init];
    
    [self httpShejiao];
    //[self httpPinglun];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerLoadStateDidChange)name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
   
    pagee =1;
    
    [self httpHomeXia];
    [self creatNavi];
    [self didSelectItemAtIndex:0];
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate =self;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    imagePicker.allowsEditing = YES;
    
}

-(void)moviePlayerLoadStateDidChange{
    
    NSLog(@"4444444");
    [_player seekToTime:CMTimeMake(0, 1)];
    [_player play];
    
}

#pragma mark 从摄像头获取图片
- (void)selectImageFromCamera
{
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    //录制视频时长，默认10s
  // imagePicker.videoMaximumDuration = 15;
    
    //相机类型（拍照、录像...）字符串需要做相应的类型转换
    imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
    
    //视频上传质量
    //UIImagePickerControllerQualityTypeHigh高清
    //UIImagePickerControllerQualityTypeMedium中等质量
    //UIImagePickerControllerQualityTypeLow低质量
    //UIImagePickerControllerQualityType640x480
  //  imagePicker.videoQuality = UIImagePickerControllerQualityTypeLow;
    
    //设置摄像头模式（拍照，录制视频）为录像模式
    imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
-(void)httpHomeXia{
    /*202 对味获取列表
     URL：http://www.rempeach.com/rebirth/api/index/getIndexList
     接口描述：下半部分新闻列表（每次15条数据）
     请求方式：GET
     上传参数：
     id *
     page
     token  *
     sign
     a b c d e f g h i g k l m n o p q r s t u v w x y z
     返回参数：state ：200 111 101 121 状态码（见附录）
     */
    
    
    NSString *idd = [USER_DEFAULT objectForKey:@"id"];
    NSString *page =[NSString stringWithFormat:@"%ld",pagee];
    NSString *token = [USER_DEFAULT objectForKey:@"token"];
    
    if (token.length<6) {
        NSArray *nameList = @[vn(page)];
        NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(page),nil];
        
        NSLog(@"%@",parameters1);
        [YkxHttptools get:@"http://www.rempeach.com/rebirth/api/index/getNewsList" params:parameters1 success:^(id responseObj) {
            NSString *finishStr = [[NSString alloc]initWithData:responseObj encoding:NSUTF8StringEncoding];
            finishStr = [YkxHttptools repTabStr:finishStr];
            NSDictionary *paramDic = [[[SBJsonParser alloc]init] objectWithString:finishStr];
            NSLog(@"%@",paramDic);
            if ([[paramDic objectForKey:@"state"] isEqualToString:@"200"]) {
                NSDictionary   *brr = [paramDic objectForKey:@"data"];
                NSLog(@"-----------------%@---------------",brr);
                NSArray *arr = [brr objectForKey:@"list"];
                [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [dataXiaArr addObject:obj];
                }];
                NSDictionary *dic = arr[0];
                [htable.mj_header endRefreshing];
                
                //  _homexiamodel = [HSHomexiaModel HSHomeXiaModel:dic];
                [htable reloadData];
                
                
            }else if ([[paramDic objectForKey:@"state"] isEqualToString:@"111"]){
                [htable.mj_header endRefreshing];
                
            }else if ([[paramDic objectForKey:@"state"] isEqualToString:@"101"]){
                [htable.mj_header endRefreshing];
                
            }else if([[paramDic objectForKey:@"state"] isEqualToString:@"100"])
            {[htable.mj_footer endRefreshingWithNoMoreData];
                [htable.mj_header endRefreshing];
                
            }else{
                
            }
        } failure:^(NSError *error) {
            [htable.mj_footer endRefreshing];
            [htable.mj_header endRefreshing];
        }];
    }else{
        NSArray *nameList = @[@"id",vn(page),vn(token)];
        NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(idd),sv(page),sv(token),nil];
        NSString *str = sv(idd);
        NSLog(@"%@",parameters1);
        [YkxHttptools get:@"http://www.rempeach.com/rebirth/api/index/getNewsList" params:parameters1 success:^(id responseObj) {
            NSString *finishStr = [[NSString alloc]initWithData:responseObj encoding:NSUTF8StringEncoding];
            finishStr = [YkxHttptools repTabStr:finishStr];
            NSDictionary *paramDic = [[[SBJsonParser alloc]init] objectWithString:finishStr];
            NSLog(@"%@",paramDic);
            if ([[paramDic objectForKey:@"state"] isEqualToString:@"200"]) {
                NSDictionary   *brr = [paramDic objectForKey:@"data"];
                NSLog(@"-----------------%@---------------",brr);
                NSArray *arr = [brr objectForKey:@"list"];
                [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [dataXiaArr addObject:obj];
                }];
                NSDictionary *dic = arr[0];
                
                [htable.mj_header endRefreshing];
                [htable.mj_footer endRefreshing];
                //  _homexiamodel = [HSHomexiaModel HSHomeXiaModel:dic];
                [htable reloadData];
                
                
            }else if ([[paramDic objectForKey:@"state"] isEqualToString:@"111"]){
                [htable.mj_header endRefreshing];
                
            }else if ([[paramDic objectForKey:@"state"] isEqualToString:@"101"]){
                [htable.mj_header endRefreshing];
                
            }else{
                [htable.mj_header endRefreshing];
                
            }
        } failure:^(NSError *error) {
            [htable.mj_header endRefreshing];
            [htable.mj_footer endRefreshing];
        }];
    }
    
}

-(void)creatNavi{
    UIView *navi = [[UIView alloc] init];
    navi.frame =CGRectMake(0, 0,kScreenWidth , NAV_BAR_HEIGHT);
    navi.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navi];
        UIButton *backBtn=  [YkxHttptools initwithButton:[UIColor clearColor] Frame:CGRectMake(0, kStatusBarHeight, 50, NAV_BAR_HEIGHT-kStatusBarHeight) Image:[UIImage imageNamed:@"back_arrow@2x"] Title:nil Titlecolor:[NSString colorWithHexString:heitizi ] Titlefont:[UIFont systemFontOfSize:14] BaseView:navi];
    [backBtn addTarget:self action:@selector(click_back:) forControlEvents:UIControlEventTouchUpInside];
    self.segmentControl = [[YAScrollSegmentControl alloc] initWithFrame:CGRectMake(90*WIDTHRATIO, 20*HEIGHTRATIO, 200*WIDTHRATIO, 40*HEIGHTRATIO)];
    self.segmentControl.buttons = @[@"品质", @"生活"];
    self.segmentControl.delegate = self;
    self.segmentControl.tag = 11;
    NSLog(@"%@",[USER_DEFAULT objectForKey:@"photo"]);
    if ([[USER_DEFAULT objectForKey:@"photo"] isEqualToString:@"photo"]) {
        self.segmentControl.selectedIndex = 1;
        addBtn.hidden = NO;
        
        
    }else{
        
    
    if ([fors isEqualToString:@"photo"]) {
        self.segmentControl.selectedIndex = 1;
    }else if([self.frrr isEqualToString:@"shipin"]){
         self.segmentControl.selectedIndex = 1;
    }else{
        self.segmentControl.selectedIndex = 0;
    }
    }
    [self.segmentControl setBackgroundImage:[UIImage imageNamed:@"background"] forState:UIControlStateNormal];
    
    //[segmentControl setBackgroundImage:[UIImage imageNamed:@"backgroundSelected"] forState:UIControlStateSelected];
    
    [self.segmentControl setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    // segmentControl.gradientColor = [UIColor redColor];
    [navi addSubview:self.segmentControl];
    addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame =CGRectMake(kScreenWidth-45, kStatusBarHeight+1, 40, 40);
    [addBtn setImage:[UIImage imageNamed:@"photo_icon@2x"] forState:UIControlStateNormal];
    if ([[USER_DEFAULT objectForKey:@"photo"] isEqualToString:@"photo"]) {
        
    }else{
        addBtn.hidden = YES;}
    [navi addSubview:addBtn];
    [addBtn addTarget:self action:@selector(click_add_msg:) forControlEvents:UIControlEventTouchUpInside];
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(0, NAV_BAR_HEIGHT-1, kScreenWidth, 0.5);
    line.backgroundColor = [UIColor grayColor];
    [navi addSubview:line];
    [USER_DEFAULT removeObjectForKey:@"photo"];

}
-(void)click_add_msg:(UIButton *)sender{
    NSLog(@"add");
    if ([USER_DEFAULT objectForKey:@"id"]) {
        
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle: UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"小视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (TARGET_IPHONE_SIMULATOR) {
                [Common tipAlert:@"模拟器无拍摄视频功能"];
            }else{
                WJFVideoVC *video  = [[WJFVideoVC alloc]init];
                
                [self.navigationController pushViewController:video animated:YES];
            }
            
        }];
        UIAlertAction *hrchiveAction = [UIAlertAction actionWithTitle:@"发帖子" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            HSphotoViewController * p = [[HSphotoViewController alloc] init];
            p.delegate = self;
            [self.navigationController pushViewController:p animated:YES];
            
            
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:deleteAction];
        //  [alertController addAction:archiveAction];
        [alertController addAction:hrchiveAction];
        
        [self presentViewController:alertController animated:YES completion:nil];

    }else{
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"您尚未登录，无法发帖" preferredStyle:UIAlertControllerStyleAlert];
        
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
        

        
        
}}
//segment回调方法
- (void)didSelectItemAtIndex:(NSInteger)index
{
    
    if (index == 0) {
        [self creatTab];
        addBtn.hidden = YES;
        
        
    }else if(index == 1){
        
        NSLog(@"社交");
        addBtn.hidden = NO;
        [self creatshejiaoTab];
        
    }else{
        
        NSLog(@"分类");
    }
}
-(void)creatTab{
    if (!htable) {
         htable =[[UITableView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, kScreenWidth, kScreenHeight-NAV_BAR_HEIGHT) style:UITableViewStylePlain];
    }
    __weak typeof(self)weakSelf = self;
    __weak UITableView *table = htable;
    table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        pagee = 1;
        [_dataShejiaoArr removeAllObjects];
        [self httpHomeXia];
    }];
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

    htable.estimatedRowHeight = 200;//随便给
    htable.rowHeight = UITableViewAutomaticDimension;
    htable.delegate =self;
    htable.dataSource = self;
    [self.view addSubview:htable];
    htable.separatorStyle = UITableViewCellSeparatorStyleNone;
    UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backpreviousClick:)];
    rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [htable addGestureRecognizer:rightSwipeGestureRecognizer];
    
}
-(void)creatshejiaoTab{
    if (!hstable) {
        hstable =[[UITableView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, kScreenWidth, kScreenHeight-NAV_BAR_HEIGHT) style:UITableViewStylePlain];

    }
    __weak typeof(self)weakSelf = self;
    __weak UITableView *table = hstable;
    table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        pag = 1;
        [_dataShejiaoArr removeAllObjects];
        [self httpShejiao];
    }];
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [footer setTitle:@"" forState:MJRefreshStateIdle];
        [footer setTitle:@"松开获取更多数据" forState:MJRefreshStateWillRefresh];
        [footer setTitle:@"获取中" forState:MJRefreshStateRefreshing];
        [footer setRefreshingTitleHidden:YES];
        pag++;
        [self httpShejiao];
        [table.mj_footer endRefreshing];
    }];
    table.mj_footer = footer;

  //    hstable.estimatedRowHeight = 200;//随便给
//    hstable.rowHeight = UITableViewAutomaticDimension;
    hstable.delegate =self;
    hstable.dataSource = self;
    [self.view addSubview:hstable];
    hstable.separatorStyle = UITableViewCellSeparatorStyleNone;
    UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backpreviousClick:)];
    rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [htable addGestureRecognizer:rightSwipeGestureRecognizer];
}
//手势返回
-(void)backpreviousClick:(UISwipeGestureRecognizer *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (hstable == tableView) {
        
        return 1;
    }
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (hstable == tableView) {
        
       return _dataShejiaoArr.count;
       //
        //return 3;
    }
    return dataXiaArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (htable ==tableView) {
        
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[HSFHMCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    HSFHMCell *celll = cell;
    NSLog(@"%lu12121212",dataXiaArr.count);
    if (dataXiaArr.count!=0) {
        
        NSDictionary *dic = dataXiaArr[indexPath.row];
        _hsmodel  = [HSHomexiaModel HSHomeXiaModel:dic];
        [celll setHsmodel:_hsmodel];
        // ******* 动画 效果 ***********
        // 定义 cell 的初始状态
        //    celll.alpha = 0.0;
        //    celll.layer.transform = CATransform3DMakeTranslation(0, 200, 0);;
        //
        //    [UIView animateWithDuration:0.5 animations:^{
        //        celll.alpha = 1.0;
        //        celll.layer.transform = CATransform3DIdentity;
        //    }];
        // ******* 动画 效果 ***********
    }
    
    
    
    return cell;
    }else{
        
        NSString *cellID = @"myCellID";
        HSShejiaoCell * cell = [[HSShejiaoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID withDisProArray:self.data];
        cell.tag = indexPath.row;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
       // MyModel *model = self.dataArray[indexPath.row];
        
        // *model = self.dataArray[indexPath.row];
        
       // cell.myModel = model;
       // self.cell  =cell;
        if (_dataShejiaoArr.count > 0 ) {
            HSShejiaoModel *mm = [[HSShejiaoModel alloc]init];
            mm =   _dataShejiaoArr[indexPath.row];
            for (HSShejiaoModel *model in _dataShejiaoArr) {
                
              //NSLog(@"model.file_list==%@",model.file_list);
            }
            NSLog(@"----%@",mm.file_list);
            cell.myModel1 = mm;
            if ([mm.category isEqualToString:@"2"]) {
                
                cell.videoImage.userInteractionEnabled = YES;
                
                cell.videoImage.tag = 9999+indexPath.row;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(videotap:)];
                
                [cell.videoImage addGestureRecognizer:tap];
                
            }

            
        }
        cell.myDelegate = self;
        return cell;

    }
}


-(void)videotap:(UITapGestureRecognizer *)tap{
    
    
    NSString *urlStr;
    NSString *imageStr;
    HSShejiaoModel *model =  _dataShejiaoArr[tap.view.tag -9999];
    if ([model.category isEqualToString:@"2"]) {
        for (NSDictionary *shipinDict in model.file_list) {
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
    
    NSLog(@"%@",url);
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
    
    [playImageView.layer addSublayer:self.playlayer];
    
    //添加播放视图到self.view
    self.lastplayImageView = playImageView;
    
    //设置播放的默认音量值
    //self.player.volume = 100;
    [self.player play];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (htable ==tableView) {
        return 182*HEIGHTRATIO;
    }else{
      
//        HSShejiaoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCellID"];
//        NSInteger width = kWidth - 75;
//        
//        NSInteger jj = indexPath.row;
//        NSLog(@"jjj=====%ld",(long)jj);
//        MyModel *model = self.dataArray[indexPath.row];
//        NSString *contentText = model.trends;
//        NSInteger H = 30;
//        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
//        CGSize size = [contentText boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
//        NSInteger imgcount = [model.contentImgs componentsSeparatedByString:@","].count;
//        CGFloat imgH = (kSpace+imgWidth)*(imgcount/4+1);
//        [cell setNeedsUpdateConstraints];
//        [cell updateConstraints];
        
        HSShejiaoCell *cell = [self tableView:hstable cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;;
    }
    return 0;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (htable ==tableView) {
        static float lastOff =0;
        if (tableView.contentOffset.y > lastOff) {
            
            cell.alpha = 0.0;
            cell.layer.transform = CATransform3DMakeTranslation(0, 200, 0);;
            
            [UIView animateWithDuration:0.5 animations:^{
                cell.alpha = 1.0;
                cell.layer.transform = CATransform3DIdentity;
            }];
            
        } else{
            
            
            
        }
        
        lastOff = tableView.contentOffset.y;
        
        NSLog(@"%ld",(long)lastOff);
    }
   
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (hstable ==tableView) {
//        NSDictionary *dic = _dataShejiaoArr[indexPath.row];
//        NSLog(@"%@",dic);
        
       // NSString *news_id = [dic objectForKey:@"news_id"];
        ReplaceZhengWenVC *zwvc = [[ReplaceZhengWenVC alloc] init];
        zwvc.model = _dataShejiaoArr[indexPath.row];
        zwvc.delegate= self;
        [self.navigationController pushViewController:zwvc animated:YES];
        
        
    }else{
    
    NSDictionary *dic = dataXiaArr[indexPath.row];
    
    [CCWebViewController showWithContro:self withUrlStr:[dic objectForKey:@"url"] withTitle:@"男人装"];
    }
}
-(void)click_back:(UIButton *)sender{

    if ([self.stype isEqualToString:@"login"]) {
        
        NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
        
        for (UIViewController *vc in marr) {
            if ([vc isKindOfClass:[HSLoginViewController class]]) {
                [marr removeObject:vc];
                break;
            }
           
        }
        self.navigationController.viewControllers = marr;
        NSLog(@"%@",self.navigationController.viewControllers);
        HomeViewController *vc = [[HomeViewController alloc]init];
        [self.navigationController popToViewController:vc animated:YES];
        
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self creatNavi];
   // [self httpShejiao];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
    [USER_DEFAULT removeObjectForKey:@"photo"];
}
-(void)httpPinglun{
    /*603 获取评论列表
     URL：http://www.rempeach.com/rebirth/api/AppApi/receive
     接口描述：获取对味社交列表
     请求方式：GET
     上传参数：
     id
     route         News_userReviewList
     version
     page
     token
     sign
     news_id
     
     
     返回参数：state ：210 111 101 121 状态码（见附录） 
*/
    
    self.data = [NSMutableArray array];
    NSString *transformId=[USER_DEFAULT objectForKey:@"id"];
    NSString *news_id = @"1";
    NSString *page = @"1";
    NSString *route=@"News_userReviewList";
    NSString *token=[USER_DEFAULT objectForKey:@"token"];
    NSString *version=@"1";

    NSArray *nameList = @[@"id",vn(news_id),vn(page),vn(route),vn(token),vn(version)];
    NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(transformId),sv(news_id),sv(page),sv(route),sv(token),sv(version),nil];
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
            NSArray *arr = [dic objectForKey:@"list"];
            NSLog(@"%@",arr);
            
            for (NSDictionary *pingLun in arr) {
                
                
                DisProModel *model = [[DisProModel alloc]init];
                
                model.name1 = pingLun[@"nick"];
                model.textStr = pingLun[@"content"];

                [self.data addObject:model];
                
            }
            
            [hstable reloadData];
            
        }else{
            
        }
    } failure:^(NSError *error) {
        
    }];
    
}
-(void)httpShejiao{
    /*601 获取对味社交列表
     URL：http://www.rempeach.com/rebirth/api/AppApi/receive
     接口描述：获取对味社交列表
     请求方式：GET
     上传参数：
     id
     route
     version
     page
     token
     
     
     返回参数：state ：210 111 101 121 状态码（见附录）
     a b c d e f g h i j k l m n o p q r s t u v w x y z
     */
    
    NSString *transformId=[USER_DEFAULT objectForKey:@"id"];
    NSString *page = [NSString stringWithFormat:@"%ld",pag];
    NSString *route=@"News_userNewsList";
    NSString *token=[USER_DEFAULT objectForKey:@"token"];
    NSString *version=@"1";
    
    
    NSArray *nameList = @[@"id",vn(page),vn(route),vn(token),vn(version)];
    NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(transformId),sv(page),sv(route),sv(token),sv(version),nil];
    NSLog(@"%@",parameters1);
    NSString *str = sv(transformId);
  //  NSDictionary *dic = @{@"id":@"1",@"page":@"1",@"route":@"News_submitNews",@"token":[USER_DEFAULT objectForKey:@"token"],@"version":@"1",@"sign":@"b571194de646528d16c1dbd4c5a88cfa",@"debug":@"true"};
[YkxHttptools get:@"http://www.rempeach.com/rebirth/api/AppApi/receive" params:parameters1 success:^(id responseObj) {
    NSString *finishStr = [[NSString alloc]initWithData:responseObj encoding:NSUTF8StringEncoding];
    finishStr = [YkxHttptools repTabStr:finishStr];
    NSDictionary *paramDic = [[[SBJsonParser alloc]init] objectWithString:finishStr];
    NSLog(@"%@",paramDic);
    NSLog(@"%@",[paramDic objectForKey:@"tip"]);
    if ([[paramDic objectForKey:@"state"] isEqualToString:@"200"]) {
        NSDictionary *dic = [paramDic objectForKey:@"data"];
        
        
        NSArray *arr = [dic objectForKey:@"list"];
        NSLog(@"啊啊啊啊啊啊啊啊啊啊啊%@",arr);
        for (NSDictionary *listDict in arr) {
            
            HSShejiaoModel *model = [[HSShejiaoModel alloc]init];
            if (listDict[@"file_list"]) {
                
                
                NSMutableArray *arr = [NSMutableArray arrayWithArray:listDict[@"file_list"]];
                
                model.file_list = [NSMutableArray arrayWithArray:arr];
                
                NSLog(@"%@",model.file_list);
                
            }else{
                
                
                
            }
            model.category = listDict[@"category"];
            
            model.date = listDict[@"date"];
            
            
            model.head_img = listDict[@"head_img"];
            
            model.news_id = listDict[@"news_id"];
            
            model.nick = listDict[@"nick"];
            
            model.review_num = listDict[@"review_num"];
            
            model.text = listDict[@"text"];
            
            model.user_id = listDict[@"user_id"];
            
            
            [_dataShejiaoArr addObject:model];
            
            
        }
        
       
       

        [hstable reloadData];
        [hstable.mj_footer endRefreshing];
       
         [hstable.mj_header endRefreshing ];
        
    }else{
          [hstable.mj_footer endRefreshing];
         [hstable.mj_header endRefreshing ];
        
    }
} failure:^(NSError *error) {
    
    
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
