//
//  PriceDingzhiVC.m
//  rebirth
//
//  Created by WJF on 16/9/20.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "PriceDingzhiVC.h"
#import "YSLDraggableCardContainer.h"
#import "CardView.h"
#import "PriceView.h"
#import "CardsView.h"
#import "DingZhiVC.h"
#import "CardDingZhiDistance.h"
#define MINDISTANCE 10
@interface PriceDingzhiVC ()
<
UIScrollViewDelegate,
UIGestureRecognizerDelegate
>

@property (nonatomic, strong) CardsView *container1;

@property (nonatomic, strong) CardsView *container2;

@property(nonatomic, strong)PriceView *priceView;

@property(nonatomic, strong)UIButton *sectPriceBtu;

@property (nonatomic, strong) CardsView *container3;

@property (nonatomic, strong) NSMutableArray *dataSources1;
@property (nonatomic, strong) NSMutableArray *dataSources2;
@property (nonatomic, strong) NSMutableArray *dataSources3;
@property (nonatomic, strong)NSMutableArray *data;

@property(nonatomic, strong)UIScrollView *customCards;

@property(nonatomic, strong)UILabel *sectPriceLabel;

@property(nonatomic ,assign)int  currurtPage;

@property(nonatomic, assign)CGPoint touchPoint;

@end
#define PriceGrade @[@"选定5000元套餐",@"选定10000元套餐",@"选定15000元套餐"]
@implementation PriceDingzhiVC

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [USER_DEFAULT removeObjectForKey:@"foodArray"];
    
}

-(void)loadPriceView{
    
   self.priceView = [[PriceView alloc]initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, WIDTH, 50*HEIGHTRATIO)];
    
    UITapGestureRecognizer *fivetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fivetap:)];
    self.priceView.fiveImage.userInteractionEnabled = YES;
    
    [self.priceView.fiveImage addGestureRecognizer:fivetap];
    
    
    UITapGestureRecognizer *tentap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tenTap:)];
    self.priceView.tenImage.userInteractionEnabled = YES;
    
    [self.priceView.tenImage addGestureRecognizer:tentap];
    
    UITapGestureRecognizer *fifteentap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fifteentap:)];
    self.priceView.fifteenImage.userInteractionEnabled = YES;
    
    [self.priceView.fifteenImage addGestureRecognizer:fifteentap];
    
    [self.view addSubview:self.priceView];
    
}


-(void)tenTap:(UITapGestureRecognizer *)tap{
    //中档
    [self.customCards setContentOffset:CGPointMake(WIDTH, 0) animated:YES];
    _priceView.tenImage.image = [UIImage imageNamed:@"price_range_1"];
    _priceView.fifteenImage.image = [UIImage imageNamed:@"price_range_0"];
    _priceView.fiveImage.image = [UIImage imageNamed:@"price_range_0"];
    
}

-(void)fivetap:(UITapGestureRecognizer *)tap{
    //抵挡
    [self.customCards setContentOffset:CGPointMake(0, 0) animated:YES];
    _priceView.tenImage.image = [UIImage imageNamed:@"price_range_0"];
    _priceView.fifteenImage.image = [UIImage imageNamed:@"price_range_0"];
    _priceView.fiveImage.image = [UIImage imageNamed:@"price_range_1"];

}


-(void)fifteentap:(UITapGestureRecognizer *)tap{
    //高档
    [self.customCards setContentOffset:CGPointMake(WIDTH*2, 0) animated:YES];
    _priceView.tenImage.image = [UIImage imageNamed:@"price_range_0"];
    _priceView.fifteenImage.image = [UIImage imageNamed:@"price_range_1"];
    _priceView.fiveImage.image = [UIImage imageNamed:@"price_range_0"];
}





-(void)loadScrollView{
    
    self.customCards = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT+55*HEIGHTRATIO, WIDTH,HEIGHT-(NAV_BAR_HEIGHT+55*HEIGHTRATIO))];
    
    self.customCards.delegate = self;
    // 设置内容大小
    // 是否反弹
    // scrollView.bounces = NO;
    // 是否分页
    self.customCards.pagingEnabled = YES;
    // 是否滚动
     self.customCards.scrollEnabled = NO;
    self.customCards.showsVerticalScrollIndicator = NO;
    self.customCards.showsHorizontalScrollIndicator = NO;
    // 设置indicator风格
    //    scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    // 设置内容的边缘和Indicators边缘
    //    scrollView.contentInset = UIEdgeInsetsMake(0, 50, 50, 0);
    //self.customCards.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    // 提示用户,Indicators flash
    [self.customCards flashScrollIndicators];
    // 是否同时运动,lock
    self.customCards.directionalLockEnabled = YES;
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
    
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    leftSwipe.delegate = self;
    
    [self.customCards addGestureRecognizer:leftSwipe];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
    
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    rightSwipe.delegate = self;
    
    [self.customCards addGestureRecognizer:rightSwipe];


}


-(void)leftSwipe:(UISwipeGestureRecognizer *)swipe{
    
    //左滑
    NSLog(@"左滑");
    if (self.currurtPage == 2) {
        
        
        
    }else{
        
        [self.customCards setContentOffset:CGPointMake(WIDTH*(self.currurtPage+1), 0) animated:YES];
        
        self.currurtPage ++;
        
        [self siwpage:self.currurtPage];

    }
   
}

-(void)rightSwipe:(UISwipeGestureRecognizer *)swipe{
    //右滑
    NSLog(@"右滑");
    if (self.currurtPage == 0) {
        
        
        
    }else{
        
        [self.customCards setContentOffset:CGPointMake(WIDTH*(self.currurtPage-1), 0) animated:YES];
        
        self.currurtPage --;
        [self siwpage:self.currurtPage];
    }
   

    
}

-(void)siwpage:(int)page{
    
   
    if (page == 1) {
        
        _priceView.tenImage.image = [UIImage imageNamed:@"price_range_1"];
        _priceView.fifteenImage.image = [UIImage imageNamed:@"price_range_0"];
        _priceView.fiveImage.image = [UIImage imageNamed:@"price_range_0"];
        
        
    }else if (page == 2){
        
        _priceView.tenImage.image = [UIImage imageNamed:@"price_range_0"];
        _priceView.fifteenImage.image = [UIImage imageNamed:@"price_range_1"];
        _priceView.fiveImage.image = [UIImage imageNamed:@"price_range_0"];
        
        
    }else if (page == 0){
        
        _priceView.tenImage.image = [UIImage imageNamed:@"price_range_0"];
        _priceView.fifteenImage.image = [UIImage imageNamed:@"price_range_0"];
        _priceView.fiveImage.image = [UIImage imageNamed:@"price_range_1"];
        
        
    }

}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    
    return YES;
}

-(void)loadTotalUI{
    
    NSArray *data = @[_dataSources1,_dataSources2,_dataSources3];
    for (int i = 0; i < 3; i++) {
        
        CardsView  *container = [[CardsView alloc] initWithFrame:CGRectMake(WIDTH*i, 0, WIDTH, 430*HEIGHTRATIO) arrWithView:data[i] withOrigin:@"PriceDingZhi"];
        container.grade = i;
        
        [self.customCards addSubview:container];
        
        UIButton  *sectPriceBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        
        sectPriceBtu.tag = 666+i;
        sectPriceBtu.frame = CGRectMake((WIDTH-335)/2*WIDTHRATIO+WIDTH*i,self.customCards.frame.size.height-90*HEIGHTRATIO,670/2, 96/2*HEIGHTRATIO);
        sectPriceBtu.layer.cornerRadius = 8;
        sectPriceBtu.backgroundColor = [UIColor blackColor];
        [sectPriceBtu addTarget:self action:@selector(sectPriceBtu:) forControlEvents:UIControlEventTouchUpInside];
        [self.customCards addSubview:sectPriceBtu];
        
        
        UILabel  *sectPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60,60 )];
        sectPriceLabel.tag = 777+i;
        sectPriceLabel .font = [UIFont systemFontOfSize:16];
        NSString *str = PriceGrade[i];
        
        sectPriceLabel .attributedText = [self addAttributeStr:str];
        [sectPriceLabel  sizeToFit];
        [sectPriceBtu addSubview: sectPriceLabel];
        [sectPriceLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(sectPriceBtu.mas_centerY);
            make.centerX.equalTo(sectPriceBtu.mas_centerX);
           
            
        }];

        
    }
    
    self.customCards.contentSize = CGSizeMake(WIDTH*3, 0);
    [self.view addSubview:self.customCards];
    
    
    
}

-(NSAttributedString *)addAttributeStr:(NSString *)str{
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[NSString colorWithHexString:@"ffffff"]
                    range:NSMakeRange(0, 2)];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[NSString colorWithHexString:@"e4c675"]
                    range:NSMakeRange(2, attrStr.length-4)];
     // NSLog(@"attrStr.length==%lu",(unsigned long)attrStr.length);
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[NSString colorWithHexString:@"ffffff"]
                    range:NSMakeRange(attrStr.length-2, 2)];
    
    return attrStr;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.currurtPage = 0;
    self.menuView.text = @"套餐选择";
    [self loadData];
   
}

- (void)loadData {
    
    _dataSources1 = [NSMutableArray array];
    
    _dataSources3 = [NSMutableArray array];
    
    _dataSources2 = [NSMutableArray array];
    
    [self getHttpData:@"1"];
    [self getHttpData:@"2"];
    
    [self getHttpData:@"3"];
}


-(void)getHttpData:(NSString *)price_level{
    
    NSDictionary  *dict;
    self.data = [NSMutableArray array];
    if ([USER_DEFAULT objectForKey:@"id"]) {
        
        dict =  @{@"id":[USER_DEFAULT objectForKey:@"id"],@"route":@"Item_priceLevelShow",@"version":@"1",@"price_level":price_level,@"token":[USER_DEFAULT objectForKey:@"token"]};
        
    }else{
        
        dict  = @{@"route":@"Item_priceLevelShow",@"version":@"1",@"price_level":price_level};
    }
    
    NSDictionary *signDict = [self encryptDict:(NSMutableDictionary *)dict];
    
    [WJFCollection getWithURLString:@"http://www.rempeach.com/rebirth/api/AppApi/receive" parameters:signDict success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        if ([price_level isEqualToString:@"1"]) {
            
            self.dataSources1 = (NSMutableArray *)responseObject[@"data"][@"list"];
        }else if ([price_level isEqualToString:@"2"]) {
        
            self.dataSources2 = (NSMutableArray *)responseObject[@"data"][@"list"];
        }else if ([price_level isEqualToString:@"3"]) {
            
            self.dataSources3 = (NSMutableArray *)responseObject[@"data"][@"list"];
        }

  
        if (self.dataSources1.count > 0 && self.dataSources2.count >0 && self.dataSources3.count >0) {
        
            [self loadPriceView];
            [self loadScrollView];
            [self loadTotalUI];
        }
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
   
}

-(void)sectPriceBtu:(UIButton *)btu{
    
    
    
    CardDingZhiDistance *vc = [[CardDingZhiDistance alloc]init];
    
    UILabel *priceLabel = [self.view viewWithTag:btu.tag +111];
    if ([priceLabel.text isEqualToString:@"选定10000元套餐"]) {
        
        vc.grade = @"2";
    }else if ([priceLabel.text isEqualToString:@"选定5000元套餐"]){
        vc.grade = @"1";
    }else if ([priceLabel.text isEqualToString:@"选定15000元套餐"]){
        vc.grade = @"3";
        
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark touch
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    UITouch* touch=[[event allTouches] anyObject];
//    self.touchPoint=[touch locationInView:self.view];
//}

//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    UITouch* touch=[[event allTouches] anyObject];
//    CGPoint currentPoint=[touch locationInView:self.view.superview];
//    CGFloat pointX=(self.touchPoint.x-currentPoint.x);
//    CGFloat pointY=(self.touchPoint.y-currentPoint.y);
//    NSLog(@"x=%f y=%f",fabs(pointX),fabs(pointY));
//    //上下滑动
//    if (fabs(pointY)>fabs(pointX)) {
//        //向上滑动
//        if (pointY>MINDISTANCE) {
//            NSLog(@"第二种方式：向上滑动");
//        }else if(pointY<-MINDISTANCE){
//            NSLog(@"第二种方式：向下滑动");
//        }
//    }else if(fabs(pointX)>fabs(pointY)){//左右滑动
//        //向右滑动
//        if (pointX<-MINDISTANCE) {
//            NSLog(@"第二种方式：向右滑动");
//        }else if(pointX>MINDISTANCE){
//            NSLog(@"第二种方式：向左滑动");
//        }
//    }
//}


#pragma mark UIScrollViewDelegate
////完成拖拽
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    
//    //page的计算方法为scrollView的偏移量除以屏幕的宽度即为第几页。
//    int page = scrollView.contentOffset.x/CGRectGetWidth(self.view.frame);
//    if (page == 1) {
//        
//         _priceView.tenImage.image = [UIImage imageNamed:@"price_range_1"];
//         _priceView.fifteenImage.image = [UIImage imageNamed:@"price_range_0"];
//         _priceView.fiveImage.image = [UIImage imageNamed:@"price_range_0"];
//       
//
//    }else if (page == 2){
//       
//        _priceView.tenImage.image = [UIImage imageNamed:@"price_range_0"];
//        _priceView.fifteenImage.image = [UIImage imageNamed:@"price_range_1"];
//        _priceView.fiveImage.image = [UIImage imageNamed:@"price_range_0"];
//       
//
//    }else if (page == 0){
//      
//        _priceView.tenImage.image = [UIImage imageNamed:@"price_range_0"];
//        _priceView.fifteenImage.image = [UIImage imageNamed:@"price_range_0"];
//        _priceView.fiveImage.image = [UIImage imageNamed:@"price_range_1"];
//       
//
//    }
//}



@end
