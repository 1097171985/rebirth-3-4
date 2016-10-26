//
//  CardDingZhiDistance.m
//  rebirth
//
//  Created by WJF on 16/10/20.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "CardDingZhiDistance.h"

#import "YSLDraggableCardContainer.h"
#import "CardView.h"
#import "PriceView.h"
#import "CardsView.h"
#import "DingZhiVC.h"
#import "OrderVC.h"
#import "XingChengGuanLiViewController.h"
#define MINDISTANCE 10
@interface CardDingZhiDistance ()
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
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) NSMutableArray *food;//吃的数组

@property(nonatomic, strong)UIScrollView *customCards;

@property(nonatomic, strong)UILabel *sectPriceLabel;

@property(nonatomic ,assign)int  currurtPage;

@property(nonatomic, assign)CGPoint touchPoint;

@end
#define PriceGrade @[@"完成定制",@"完成定制",@"完成定制"]
@implementation CardDingZhiDistance



-(void)backClick:(UIButton *)btu{
    
    
    if ([self.hStype isEqualToString:@"food"] || [self.hStype isEqualToString:@"car"] ||[self.hStype isEqualToString:@"hotel"]) {
        
        NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
        for (UIViewController *vc in marr) {
            if ([vc isKindOfClass:[HSVegetableViewController class]]) {
                [marr removeObject:vc];
                break;
            }
        }
        self.navigationController.viewControllers = marr;
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }

}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
     [self.rightBtu setImage:[UIImage imageNamed:@"card_manage_1"] forState:UIControlStateNormal];
     [self TubiaoPriView];
    
   
    
}

-(void)caipuArr{
    
    
    
}


-(void)TubiaoPriView{
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    if ([[user objectForKey:@"car"] isEqualToString:@"car"]) {
        
        self.priceView.fiveImage.image = [UIImage imageNamed:@"card_choose_0"];
        
        [self.rightBtu setImage:[UIImage imageNamed:@"card_manage_1_first"] forState:UIControlStateNormal];
        NSLog(@"%f",self.customCards.contentOffset.x);
        if (self.currurtPage == 0) {
            
            self.priceView.fiveImage.image = [UIImage imageNamed:@"card_choose_1"];
            
        }
    }else{
        
        if (self.currurtPage == 0) {
            self.priceView.fiveImage.image = [UIImage imageNamed:@"card_selection_1"];
        }else{
            
            self.priceView.fiveImage.image = [UIImage imageNamed:@"card_selection_0"];
        }
    }
    
    self.food = [NSMutableArray arrayWithArray:[user objectForKey:@"foodArray"]];

    
    if (self.food.count >0) {
        
        [self.rightBtu setImage:[UIImage imageNamed:@"card_manage_1_first"] forState:UIControlStateNormal];
        self.priceView.tenImage.image = [UIImage imageNamed:@"card_choose_0"];
        if (self.currurtPage == 1) {
            
            self.priceView.tenImage.image = [UIImage imageNamed:@"card_choose_1"];
            
        }
        
    }else{
        
        if (self.currurtPage == 1) {
            self.priceView.tenImage.image = [UIImage imageNamed:@"card_selection_1"];
        }else{
            
            self.priceView.tenImage.image = [UIImage imageNamed:@"card_selection_0"];
            
        }
        
    }

    
    if ([[user objectForKey:@"hotel"] isEqualToString:@"hotel"]) {
        
        [self.rightBtu setImage:[UIImage imageNamed:@"card_manage_1_first"] forState:UIControlStateNormal];
        self.priceView.fifteenImage.image = [UIImage imageNamed:@"card_choose_0"];
        if (self.currurtPage == 2) {
            
            self.priceView.fifteenImage.image = [UIImage imageNamed:@"card_choose_1"];
            
        }
        
    }else{
        
        if (self.currurtPage == 2) {
            self.priceView.fifteenImage.image = [UIImage imageNamed:@"card_selection_1"];
        }else{
            
            self.priceView.fifteenImage.image = [UIImage imageNamed:@"card_selection_0"];
        }
        
    }
    
    if ([[user objectForKey:@"hotel"] isEqualToString:@"hotel"] ||self.food.count >0||[[user objectForKey:@"car"] isEqualToString:@"car"]) {
        
       [self.rightBtu setImage:[UIImage imageNamed:@"card_manage_1_first"] forState:UIControlStateNormal];
        
    }

}

-(void)loadPriceView{
    
    self.priceView = [[PriceView alloc]initWithFrame:CGRectMake(0,NAV_BAR_HEIGHT, WIDTH, 50*HEIGHTRATIO)];
    
    UITapGestureRecognizer *fivetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fivetap:)];
    self.priceView.fiveImage.userInteractionEnabled = YES;
    self.priceView.fiveLabel.text = @"出行";
    [self.priceView.fiveImage addGestureRecognizer:fivetap];
    
    UITapGestureRecognizer *tentap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tenTap:)];
    self.priceView.tenImage.userInteractionEnabled = YES;
    self.priceView.tenLabel.text = @"就餐";
    [self.priceView.tenImage addGestureRecognizer:tentap];
    
    UITapGestureRecognizer *fifteentap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fifteentap:)];
    self.priceView.fifteenImage.userInteractionEnabled = YES;
    self.priceView.fifteenLabel.text = @"入住";
    [self.priceView.fifteenImage addGestureRecognizer:fifteentap];
    
    [self.view addSubview:self.priceView];
    
}


-(void)tenTap:(UITapGestureRecognizer *)tap{
    //就餐
//    [UIView animateWithDuration:.25 animations:^
//    {
        [self.customCards setContentOffset:CGPointMake(WIDTH, 0) animated:YES];
//      self.customCards.contentOffset = CGPointMake(WIDTH, 0);

        self.currurtPage = 1;
        [self TubiaoPriView];
//}];
   
}

-(void)fivetap:(UITapGestureRecognizer *)tap{
    //车  这里 写成yes 有问题
    
//    {
      [self.customCards setContentOffset:CGPointMake(0, 0) animated:YES];
      //  self.customCards.contentOffset = CGPointMake(0, 0);
        self.currurtPage = 0;
        [self TubiaoPriView];
   // }];
   
    
}


-(void)fifteentap:(UITapGestureRecognizer *)tap{
    //住
   // [UIView animateWithDuration:0.25 animations:^{
        [self.customCards setContentOffset:CGPointMake(WIDTH*2, 0) animated:YES];
        self.currurtPage = 2;
        [self TubiaoPriView];
   // }];
   
}





-(void)loadScrollView{
    
    self.customCards = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT+55*HEIGHTRATIO, WIDTH,HEIGHT-NAV_BAR_HEIGHT-55*HEIGHTRATIO)];
    
    self.customCards.delegate = self;
    
    // 设置内容大小
    
    // 是否反弹
      self.customCards.bounces = NO;
    // 是否分页
    self.customCards.pagingEnabled = YES;
    // 是否滚动
    self.customCards.scrollEnabled = YES;
    self.customCards.showsVerticalScrollIndicator = NO;
    self.customCards.showsHorizontalScrollIndicator = NO;
    // 设置indicator风格
    //    scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    // 设置内容的边缘和Indicators边缘
    // scrollView.contentInset = UIEdgeInsetsMake(0, 50, 50, 0);
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
        
        [self TubiaoPriView];
        
    }
    
}

-(void)rightSwipe:(UISwipeGestureRecognizer *)swipe{
    //右滑
    NSLog(@"右滑");
    if (self.currurtPage == 0) {
        
        
        
    }else{
        
        [self.customCards setContentOffset:CGPointMake(WIDTH*(self.currurtPage-1), 0) animated:YES];
        
        self.currurtPage --;
        
        [self TubiaoPriView];
        //[self siwpage:self.currurtPage];
    }
    
    
    
}


-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    
    return YES;
}

-(void)loadTotalUI{
    
    NSArray *data = @[_dataSources1,_dataSources2,_dataSources3];
    for (int i = 0; i < 3; i++) {
        
        CardsView  *container = [[CardsView alloc] initWithFrame:CGRectMake(WIDTH*i, 0, WIDTH, 430*HEIGHTRATIO) arrWithView:data[i] withOrigin:@"DingzhiRoute"];
        container.grade = i;
        
        [self.customCards addSubview:container];
        
        UIButton  *sectPriceBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        sectPriceBtu.tag = 666+i;
        sectPriceBtu.frame = CGRectMake((WIDTH-335)/2.0+WIDTH*i,self.customCards.frame.size.height-90*HEIGHTRATIO,335, 96/2);
        sectPriceBtu.layer.cornerRadius = 8;
        sectPriceBtu.backgroundColor = [UIColor blackColor];
        [sectPriceBtu addTarget:self action:@selector(sectPriceBtu:) forControlEvents:UIControlEventTouchUpInside];
        [self.customCards addSubview:sectPriceBtu];
        
        UILabel  *sectPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60,60 )];
        sectPriceLabel.tag = 777+i;
        sectPriceLabel .font = [UIFont systemFontOfSize:16];
        sectPriceLabel.text =@"完成定制";
        sectPriceLabel.textColor = [UIColor whiteColor];
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
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[NSString colorWithHexString:@"ffffff"]
                    range:NSMakeRange(attrStr.length-2, 2)];
    
    return attrStr;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNav];

    self.view.backgroundColor = [UIColor whiteColor];
    self.currurtPage = 0;
    self.menuView.text = @"定制行程";
    [self loadData];
    
    
    
}

-(void)creatNav{
    
    self.rightBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.naviView addSubview:self.rightBtu];
    //  8, kStatusBarHeight+5, 56/2, 56/2
    
    [self.rightBtu mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.right.equalTo(self.naviView.mas_right).with.offset(-8);
        
        make.width.mas_equalTo(56/2);
        
        make.centerY.equalTo(self.naviView.mas_centerY).with.offset(kStatusBarHeight/2);
        
        
    }];
    
    [self.rightBtu addTarget:self action:@selector(routeBtu:) forControlEvents:UIControlEventTouchUpInside];
    
    
}


-(void)routeBtu:(UIButton*)btu{
    
    XingChengGuanLiViewController *vc = [[XingChengGuanLiViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];

    
    
}

- (void)loadData {
    
    _dataSources1 = [NSMutableArray array];
    
    _dataSources3 = [NSMutableArray array];
    
    _dataSources2 = [NSMutableArray array];
    
    [self getHttpData:self.grade withcategory:@"1"];
    
    [self getHttpData:self.grade withcategory:@"5"];
    
    [self getHttpData:self.grade withcategory:@"9"];
}


-(void)getHttpData:(NSString *)price_level withcategory:(NSString *)category{
    
    NSDictionary  *dict;
    self.data = [NSMutableArray array];
    if ([USER_DEFAULT objectForKey:@"id"]) {
        
        dict =  @{@"id":[USER_DEFAULT objectForKey:@"id"],@"route":@"Item_showMenuList",@"version":@"2",@"category":category,@"price_level":price_level,@"token":[USER_DEFAULT objectForKey:@"token"]};
        
    }else{
        
        dict  =  @{@"route":@"Item_showMenuList",@"version":@"2",@"category":category,@"price_level":price_level};
    }
    
    NSDictionary *signDict = [self encryptDict:(NSMutableDictionary *)dict];
    [WJFCollection getWithURLString:@"http://www.rempeach.com/rebirth/api/AppApi/receive" parameters:signDict success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        if ([category isEqualToString:@"1"]) {
            
            if ([responseObject[@"state"] isEqualToString:@"200"]) {
                
                self.dataSources1 = (NSMutableArray *)responseObject[@"data"][@"list"];

            }else if([responseObject[@"state"] isEqualToString:@"111"]){
                
            }
        }else if ([category isEqualToString:@"5"]) {
            if ([responseObject[@"state"] isEqualToString:@"200"]) {
                
                self.dataSources2 = (NSMutableArray *)responseObject[@"data"][@"list"];

            }else if([responseObject[@"state"] isEqualToString:@"111"]){
                
            }
        }else if ([category isEqualToString:@"9"]) {
            if ([responseObject[@"state"] isEqualToString:@"200"]) {
                
                self.dataSources3 = (NSMutableArray *)responseObject[@"data"][@"list"];
            }else if([responseObject[@"state"] isEqualToString:@"111"]){
                
            }
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
    
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    if ([[user objectForKey:@"car"] isEqualToString:@"car"] &&(self.food.count >0  && [[user objectForKey:@"hotel"] isEqualToString:@"hotel"] )) {
        
        OrderVC *vc = [[OrderVC alloc]init];
        vc.grade = self.grade;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        
        // NSLog(@"bu定制");
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"您还未完成您的定制" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
        }];
        
        [alert addAction:ok];//添加按钮
        //以modal的形式
        [self presentViewController:alert animated:YES completion:^{ }];
        
    }

}

#pragma mark UIScrollViewDelegate



@end
