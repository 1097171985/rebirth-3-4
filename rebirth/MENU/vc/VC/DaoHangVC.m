//
//  DaoHangVC.m
//  rebirth
//
//  Created by boom on 16/7/27.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "DaoHangVC.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapServices.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import "SpeechSynthesizer.h"
#import "GPSEmulator.h"


#define CASE_COR CLLocationCoordinate2DMake(30.278500, 120.160466)

@interface DaoHangVC ()<AMapNaviDriveManagerDelegate, AMapNaviDriveViewDelegate, AMapNaviDriveDataRepresentable,CLLocationManagerDelegate>

{
    MAMapView *_mapView;
    CLLocationManager *_locationManager;
//    /**
//     导航
//     */
//    AMapNaviDriveManager *_driveManager;
//    AMapNaviDriveView *_naviDriveView;
    /**
     工具栏
     */
    UIToolbar *_toolBar;

}

@property (nonatomic, strong) AMapNaviDriveManager *driveManager;

@property (nonatomic, strong) AMapNaviDriveView *naviDriveView;


@property (nonatomic, strong) GPSEmulator *gpsEmulator;

@property (nonatomic, strong) AMapNaviPoint* startPoint;
@property (nonatomic, strong) AMapNaviPoint* endPoint;

@end

@implementation DaoHangVC


- (void)dealloc
{
    //停止语音
    [[SpeechSynthesizer sharedSpeechSynthesizer] stopSpeak];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // 初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 44)];
    //_mapView.delegate = self;
    [self.view addSubview:_mapView];
   
    // 展示当前用户的地理位置
    _mapView.showsUserLocation = YES;
    
    // 跟随用户的移动, 加Header则为跟随方向
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    // 开启旋转 3D 旋转角度的范围是[0.f 360.f]，以逆时针为正向
    [_mapView setRotationDegree:60.f animated:YES duration:0.5];
    
    // 开启倾斜 3D 倾斜角度范围为[0.f, 45.f]
    [_mapView setCameraDegree:10.f animated:YES duration:0.5];

    
    _driveManager = [[AMapNaviDriveManager alloc] init];
    [_driveManager setDelegate:self];
    

    
    // Toor Bar
   

    
    for (int i = 0; i < 2; i++) {
        
        UIButton *btu = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btu.frame = CGRectMake(0+(WIDTH+1)/2*i, HEIGHT-40,WIDTH/2,40);
        btu.backgroundColor = [UIColor blackColor];
        btu.tag = 900+i;
        if (btu.tag == 900) {
            
            [btu setTitle:@"退出导航页" forState:UIControlStateNormal];
            
        }else{
            
            [btu setTitle:@"开始导航" forState:UIControlStateNormal];

        }
       
        [btu addTarget:self action:@selector(clcilk:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btu];
        
    }
    
}


-(void)clcilk:(UIButton *)btu{
    
    
    if (btu.tag == 901) {
        
        [self R_RAction];
        
    }else{
        
        //停止语音
        [[SpeechSynthesizer sharedSpeechSynthesizer] stopSpeak];
        
        //停止导航
        [_driveManager stopNavi];
        
        //将naviDriveView从AMapNaviDriveManager中移除
        [_driveManager removeDataRepresentative:_naviDriveView];
        
        //将导航视图从视图层级中移除
        [_naviDriveView removeFromSuperview];
        
        [_mapView removeFromSuperview];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
    
}
#pragma mark - route delegate method

- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager {
    
    //将naviDriveView添加到AMapNaviDriveManager中
    [_driveManager addDataRepresentative:_naviDriveView];
    
    //将导航视图添加到视图层级中
    [self.view addSubview:_naviDriveView];
    
    //开始实时导航
    [_driveManager startGPSNavi];
    
     self.gpsEmulator = [[GPSEmulator alloc] init];
}

- (void)driveViewCloseButtonClicked:(AMapNaviDriveView *)driveView {
    //停止导航
    [_driveManager stopNavi];
    
    //将naviDriveView从AMapNaviDriveManager中移除
    [_driveManager removeDataRepresentative:_naviDriveView];
    
    //将导航视图从视图层级中移除
    [_naviDriveView removeFromSuperview];
}

- (void)driveManager:(AMapNaviDriveManager *)naviManager
 playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType {
    
    
    //if (soundStringType == AMapNaviSoundTypePassedReminder) {
        
      //AudioServicesPlaySystemSound(1009);//播放系统“叮叮”提示音
        [[SpeechSynthesizer sharedSpeechSynthesizer] speakString:soundString];

          //  }
   // else {
        // 播放语音, 注意在停止导航的时候停止播报语音
     //   [[SpeechSynthesizer sharedSpeechSynthesizer] stopSpeak];

      //  NSLog(@"%@", soundString);
   // }
}


- (void)R_RAction {
    
    
    if ( !_naviDriveView ) {
        
        // 初始化导航视图, 使用另一种样式 : AMapNaviHUDView
        _naviDriveView = [[AMapNaviDriveView alloc]
                          initWithFrame:CGRectMake(0, 0,WIDTH, CGRectGetHeight(self.view.bounds) - 44)];
        _naviDriveView.delegate = self;
    }
    
    AMapNaviPoint *startPoint = [AMapNaviPoint locationWithLatitude:_mapView.userLocation.coordinate.latitude longitude:_mapView.userLocation.coordinate.longitude];
    AMapNaviPoint *endPoint = [AMapNaviPoint locationWithLatitude:CASE_COR.latitude longitude:CASE_COR.longitude];
    
    NSArray *startPoints = @[startPoint];
    NSArray *endPoints   = @[endPoint];
    
    //// 关闭智能播报
    // [_driveManager setDetectedMode:AMapNaviDetectedModeNone];
    // 智能播报
    [_driveManager setDetectedMode:AMapNaviDetectedModeCameraAndSpecialRoad];
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
//        _locationManager.allowsBackgroundLocationUpdates = YES;
//    }
    //iOS9(含)以上系统需设置
    [_driveManager setAllowsBackgroundLocationUpdates:YES];
    //驾车路径规划（未设置途经点、导航策略为速度优先）
    [_driveManager calculateDriveRouteWithStartPoints:startPoints endPoints:endPoints wayPoints:nil drivingStrategy:AMapNaviDrivingStrategyDefault];
    
    NSLog(@"%d",[_driveManager calculateDriveRouteWithStartPoints:startPoints endPoints:endPoints wayPoints:nil drivingStrategy:AMapNaviDrivingStrategyDefault]
          );
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
}


@end

