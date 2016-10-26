//
//  WJFDetailDiTuVC.m
//  rebirth
//
//  Created by boom on 16/7/27.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "WJFDetailDiTuVC.h"

#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
@interface WJFDetailDiTuVC ()<MAMapViewDelegate,AMapSearchDelegate>

@property(nonatomic,strong)MAMapView *mapView;

@property(nonatomic,strong) AMapSearchAPI *search;


@end

@implementation WJFDetailDiTuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.coordinate.length == 0) {
        [self searchAddress];
    }
    
    NSArray *coor = [self.coordinate componentsSeparatedByString:@","];
    
    self.view.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    
    [self.leftBtu setImage:[UIImage imageNamed:@"back_arrow@2x"] forState:UIControlStateNormal];
    
    self.menuView.text = @"具体位置";
    

    self.mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0,64, WIDTH, HEIGHT)];
    self.mapView.showsScale= NO;
    self.mapView.showsCompass= NO;
    [self.mapView setVisibleMapRect:MAMapRectMake(22080, 101470, 2720, 4660) animated:YES];
    [self.view addSubview:self.mapView];
    self.mapView.delegate = self;
    
    
    
    
    
    if (self.coordinate.length == 0) {
        
        
        
        
        
    }else{
        
        MAPointAnnotation *a1 = [[MAPointAnnotation alloc] init];
        
        a1.coordinate = CLLocationCoordinate2DMake([coor[0] floatValue], [coor[1] floatValue]);
        
        [self.mapView addAnnotation:a1];
        
        NSMutableArray *arr = [NSMutableArray array];
        
        [arr addObject:a1];
        
        [self.mapView showAnnotations:arr edgePadding:UIEdgeInsetsMake(5,5,5, 5) animated:YES];
        
    }
    
   

    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, 96/2)];
    view.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    
    [self.view addSubview:view];
    
    
    UIImageView *tubiaoImage = [[UIImageView alloc]init];
    tubiaoImage.image = [UIImage imageNamed:@"map_address@2x"];
    
    [view addSubview:tubiaoImage];
    
    [tubiaoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(view.mas_left).with.offset(12);
        
        make.height.mas_equalTo(16);
        
        make.width.mas_equalTo(16);
        
        make.centerY.equalTo(view.mas_centerY);
        
    }];
    
    UILabel *address = [[UILabel alloc]init];
    address.text = self.address;
    address.font = [UIFont systemFontOfSize:16];
    address.textColor = [NSString colorWithHexString:@"#27292b"];
    [view addSubview:address];
    
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(tubiaoImage.mas_right).with.offset(8);
        
        make.height.mas_equalTo(16);
        
       //make.width.mas_equalTo(16);
        
        make.centerY.equalTo(view.mas_centerY);
        
    }];
    
    
    // Do any additional setup after loading the view.
}


-(void)searchAddress{
    
    //初始化检索对象
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    
    //构造AMapGeocodeSearchRequest对象，address为必选项，city为可选项
    AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
    geo.address = self.address;
    geo.city = @"杭州市";
    
    //发起正向地理编码
    [_search AMapGeocodeSearch: geo];
    
    
}




- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"address@2x"];
        
        // 设置为NO，用以调用自定义的calloutView
        annotationView.canShowCallout = NO;
        
        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }
    return nil;
}


- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"accessory view :%@", view);
}

- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view didChangeDragState:(MAAnnotationViewDragState)newState fromOldState:(MAAnnotationViewDragState)oldState
{
    NSLog(@"old :%ld - new :%ld", (long)oldState, (long)newState);
}

- (void)mapView:(MAMapView *)mapView didAnnotationViewCalloutTapped:(MAAnnotationView *)view
{
    NSLog(@"callout view :%@", view);
}



//实现正向地理编码的回调函数
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    if(response.geocodes.count == 0)
    {
        return;
    }
    
    //通过AMapGeocodeSearchResponse对象处理搜索结果
    NSString *strCount = [NSString stringWithFormat:@"count: %d", response.count];
    NSString *strGeocodes = @"";
    for (AMapTip *p in response.geocodes) {
        strGeocodes = [NSString stringWithFormat:@"%@\ngeocode: %@", strGeocodes, p.description];
        
        self.coordinate = [NSString stringWithFormat:@"%@",p.location];
        NSLog(@"self.coordinate%@",self.coordinate);
        
        
        MAPointAnnotation *a1 = [[MAPointAnnotation alloc] init];
        
        a1.coordinate = CLLocationCoordinate2DMake(p.location.latitude,p.location.longitude);
        
        [self.mapView addAnnotation:a1];
        
        NSMutableArray *arr = [NSMutableArray array];
        
        [arr addObject:a1];
        
        [self.mapView showAnnotations:arr edgePadding:UIEdgeInsetsMake(5,5,5, 5) animated:YES];
    }
    NSString *result = [NSString stringWithFormat:@"%@ \n %@", strCount, strGeocodes];
    
       
    NSLog(@"Geocode: %@", result);
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
