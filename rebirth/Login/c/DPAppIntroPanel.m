//
//  DPAppIntroPanel.m
//  DPLaunchIntro
//
//  Created by yxw on 15-7-27.
//  Copyright (c) 2013年 yxw. All rights reserved.
//

#import "DPAppIntroPanel.h"
#import "AppDelegate.h"
#import "DPIntroFirstView.h"
#import "DPIntroSecondView.h"
#import "DPIntroThirdView.h"
#import "ThirdView.h"
#import "FourView.h"
#define kGapX 10
#define kNumberOfAppIntroPages 4

static NSString * const DPAppIntroPage = @"DPAppIntroPage";
static NSString * const DPAppIntroDisplayedPage = @"DPAppIntroDisplayedPage";
static DPAppIntroPanel *_appIntroPanel = nil;

@interface DPAppIntroPanel () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *mScrollView;
@property (nonatomic, strong) UIView *mContentView;
@property (nonatomic, strong) UIPageControl *mPageControl;
@property (nonatomic, assign) NSInteger mCurrentPage;
@property (nonatomic, strong) DPIntroFirstView *firstView;
@property (nonatomic, strong) DPIntroSecondView *secondView;
@property (nonatomic, strong) ThirdView *thirdView;
@property (nonatomic, strong)FourView *fourView;
@end

@implementation DPAppIntroPanel
@synthesize mScrollView;
@synthesize mContentView;
@synthesize mPageControl;
@synthesize mCurrentPage;
@synthesize firstView;
@synthesize secondView;
@synthesize thirdView;
@synthesize fourView;


#pragma mark - public
+ (BOOL)displayIfNeeded
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    BOOL show = ![[userDefaults objectForKey:[NSString stringWithFormat:@"%@-%@", DPAppIntroPage, version]] boolValue];
    if (show) {
        
      DPAppIntroPanel *panel =  [[DPAppIntroPanel alloc]init];
     [panel httpfirst];
        
        const NSInteger currentPage = [userDefaults integerForKey:DPAppIntroDisplayedPage];
        if (0 <= currentPage && currentPage < kNumberOfAppIntroPages) {
            if (nil == _appIntroPanel) {
                _appIntroPanel = [[DPAppIntroPanel alloc] initWithCurrentPage:currentPage];
            }
        }else {
            if (nil == _appIntroPanel) {
                _appIntroPanel = [[DPAppIntroPanel alloc] initWithCurrentPage:0];
            }
        }
        _appIntroPanel.rootViewController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
        [_appIntroPanel show];
    }
    return show;
}


-(void)httpfirst{
    NSString *appVersion = @"2.0.0";
    NSString *deviceID = [YkxHttptools randomUUID];
    NSString *deviceInfo = [[UIDevice currentDevice] model];
    NSString *route = @"Index_firstLaunch";
    NSString *system = @"IOS";[[UIDevice currentDevice] systemName];
    NSString *version = @"1";
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    
    NSDictionary *dict = @{@"appVersion":@"2.0.0",@"deviceID":[YkxHttptools randomUUID],@"deviceInfo":[[UIDevice currentDevice] model],@"route":route,@"system":system,@"version":version,@"systemVersion":systemVersion};
    
    NSDictionary *signDict = [self encryptDict:(NSMutableDictionary *)dict];
    
    [WJFCollection postWithUrlString:@"http://www.rempeach.com/rebirth/api/AppApi/receive" Parameter:signDict success:^(id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


-(NSString*) createMd5Sign:(NSMutableDictionary*)dict
{
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        
        [contentString appendFormat:@"%@%@", categoryId, [dict objectForKey:categoryId]];
        
    }
    return contentString;
}


//md5加密
-(NSString *) md5:(NSString *)str
{
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
    
    
}


-(NSDictionary *)encryptDict:(NSMutableDictionary *)dict{
    
    
    NSString *str1  =   [self createMd5Sign:dict];
    
    NSString  *str2 = [self md5:@"miaotaoKJ"];
    
    
    NSString *sign  = [self md5:[NSString stringWithFormat:@"%@%@",str1,str2]];
    
    NSMutableDictionary  *total = [[NSMutableDictionary alloc]init];
    
    [total addEntriesFromDictionary:dict];
    
    [total setObject:sign forKey:@"sign"];
    
    [total setObject:@"true" forKey:@"debug"];
    
    return (NSDictionary *)total;
}

#pragma mark - life cycle
- (id)initWithCurrentPage:(NSInteger)currentPage
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setWindowLevel:(UIWindowLevelStatusBar + 1)];
        
        mCurrentPage = currentPage;
        
        mScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width , [[UIScreen mainScreen] bounds].size.height)];
        [mScrollView setDelegate:self];
        [mScrollView setBackgroundColor:[UIColor lightGrayColor]];
        [mScrollView setDecelerationRate:UIScrollViewDecelerationRateNormal];
        [mScrollView setShowsVerticalScrollIndicator:NO];
        [mScrollView setShowsHorizontalScrollIndicator:NO];
        [mScrollView setScrollEnabled:YES];
        [mScrollView setPagingEnabled:YES];
        [mScrollView setDirectionalLockEnabled:YES];
        [mScrollView setBounces:NO];
        [mScrollView setAlwaysBounceHorizontal:YES];
        [mScrollView setAlwaysBounceVertical:NO];
        [mScrollView setBouncesZoom:NO];
        
        const CGSize contentSize = { ([[UIScreen mainScreen] bounds].size.width ) * kNumberOfAppIntroPages, [[UIScreen mainScreen] bounds].size.height };
        
        mContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contentSize.width, contentSize.height)];
        [mContentView setBackgroundColor:[UIColor lightGrayColor]];
        
        for (int i = 0; i < kNumberOfAppIntroPages; ++ i) {
            switch (i) {
                case 0:{
                    firstView = [[DPIntroFirstView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
                    [mContentView addSubview:firstView];
                }
                    break;
                case 1:{
                    secondView = [[DPIntroSecondView alloc] initWithFrame:CGRectMake( [[UIScreen mainScreen] bounds].size.width, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
                    [mContentView addSubview:secondView];
                }
                    break;
                case 2:{
                    thirdView = [[ThirdView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width * 2, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
                    
                    [mContentView addSubview:thirdView];
                }
                     break;
                case 3:{
                    fourView = [[FourView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width *3, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
                    __weak typeof(self) weakSelf = self;
                    
                    fourView.joinDuopaiBlock = ^(){
                        
                        [weakSelf onEnterApp];
                    };
                    [mContentView addSubview:fourView];
                }
             
                    break;
            }
        }
        
        [mScrollView setContentSize:contentSize];
        [mScrollView setContentOffset:CGPointMake([[UIScreen mainScreen] bounds].size.width * currentPage, 0)];
        [mScrollView addSubview:mContentView];
        [self addSubview:mScrollView];
        
        mPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 30, [[UIScreen mainScreen] bounds].size.width, 20)];
        [mPageControl setNumberOfPages:kNumberOfAppIntroPages];
        [mPageControl setCurrentPage:currentPage];
        [mPageControl setPageIndicatorTintColor:[UIColor grayColor]];
        [mPageControl setCurrentPageIndicatorTintColor:[UIColor whiteColor]];
        [mPageControl addTarget:self action:@selector(changePage:)forControlEvents:UIControlEventValueChanged];
        [self addSubview:mPageControl];
        
        [fourView.enterBtu mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(120);
            
            make.height.mas_equalTo(48);
            
            make.centerX.equalTo(self.mas_centerX);
            
            make.bottom.equalTo(mPageControl.mas_top).with.offset(-50);
            
        }];
    }
    return self;
}

- (void)dealloc
{
    mScrollView = nil;
    mContentView = nil;
    mPageControl = nil;
    firstView = nil;
    secondView = nil;
    thirdView = nil;
    fourView = nil;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self calculateCurrentPage];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self calculateCurrentPage];
}

- (void)calculateCurrentPage
{
    const CGPoint contentOffset = [mScrollView contentOffset];
    
    NSInteger currentPage = (contentOffset.x / ( self.bounds.size.width));
    if (mCurrentPage != currentPage) {
        mCurrentPage = currentPage;
        [mPageControl setCurrentPage:mCurrentPage];
        [self reloadPageViews];
        
    }
}

- (void)reloadPageViews
{
    if (mCurrentPage == 0) {
        [firstView viewDidShow];
        [secondView viewDidDismiss];
        [thirdView viewDidDismiss];
        [fourView viewDidDismiss];
        
    }else if (mCurrentPage == 1) {
        [secondView viewDidShow];
        [firstView viewDidDismiss];
        [thirdView viewDidDismiss];
        [fourView viewDidDismiss];
    }else if (mCurrentPage == 2) {
        [thirdView viewDidShow];
        [firstView viewDidDismiss];
        [secondView viewDidDismiss];
        [fourView viewDidDismiss];
    }else if (mCurrentPage == 3) {
        [fourView viewDidShow];
        [firstView viewDidDismiss];
        [secondView viewDidDismiss];
        [thirdView viewDidDismiss];
    }
}

#pragma mark - UIPageControl
-(void)changePage:(id)sender
{
    NSInteger page = mPageControl.currentPage;
    
    [UIView animateWithDuration:0.2 animations:^{
        [mScrollView setContentOffset:CGPointMake(([[UIScreen mainScreen] bounds].size.width) * page, 0)];
    } completion:^(BOOL finished) {
        [self calculateCurrentPage];
    }];
}

#pragma mark - methods
- (void)show {
    [self setHidden:NO];
    self.rootViewController = nil;
    [self reloadPageViews];
}

- (void)dismiss {
    [UIView animateWithDuration:0.25 animations:^{
        [self setAlpha:0];
    } completion:^(BOOL finished){
        [self setHidden:YES];
        if (_appIntroPanel) {
            _appIntroPanel = nil;
        }
    }];
}

- (void)onEnterApp {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [userDefaults setObject:@(1) forKey:[NSString stringWithFormat:@"%@-%@", DPAppIntroPage, version]];
    [userDefaults setInteger:0 forKey:DPAppIntroDisplayedPage];
    [userDefaults synchronize];
    [self dismiss];
}

@end
