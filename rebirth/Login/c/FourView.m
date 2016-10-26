//
//  FourView.m
//  DPLaunchIntro
//
//  Created by WJF on 16/10/24.
//  Copyright © 2016年 yxw. All rights reserved.
//

#import "FourView.h"


#import "DPMoviePlayerView.h"


//
@interface FourView()
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *itemImageView;
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UIImageView *textImageView;
@property (nonatomic, strong) DPMoviePlayerView *playView;

@end

@implementation FourView
@synthesize joinDuopaiBlock;
@synthesize bgImageView;
@synthesize itemImageView;
@synthesize coverImageView;
@synthesize titleImageView;
@synthesize textImageView;
@synthesize playView;
@synthesize animating;
@synthesize enterBtu;

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        BOOL isIphone4 = iPhone4;
        animating = NO;
        
        bgImageView = [[UIImageView alloc] init];
        [bgImageView setContentMode:UIViewContentModeScaleAspectFill];
        [bgImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"welcome_bg_ip%@", isIphone4? @"4":@"6p"]]];
        [self addSubview:bgImageView];
        
        itemImageView = [[UIImageView alloc] init];
        [itemImageView setContentMode:UIViewContentModeScaleAspectFill];
        [itemImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"welcome_item1_ip%@", isIphone4? @"4":@"6p"]]];
        itemImageView.transform = CGAffineTransformMakeScale(0.75f, 0.75f);
        [self addSubview:itemImageView];
        
        coverImageView = [[UIImageView alloc] init];
        [coverImageView setContentMode:UIViewContentModeScaleAspectFill];
        [coverImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"welcome_cover_ip%@", isIphone4? @"4":@"6p"]]];
        [self addSubview:coverImageView];
        
        titleImageView = [[UIImageView alloc] init];
        [titleImageView setContentMode:UIViewContentModeScaleAspectFill];
        [titleImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"welcome_title1_ip%@", isIphone4? @"4":@"6p"]]];
        [self addSubview:titleImageView];
        
        textImageView = [[UIImageView alloc] init];
        [textImageView setContentMode:UIViewContentModeScaleAspectFill];
        [textImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"welcome_text1_ip%@", isIphone4? @"4":@"6p"]]];
        [self addSubview:textImageView];
        
        enterBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        enterBtu.backgroundColor = [[NSString colorWithHexString:@"#ffffff"]colorWithAlphaComponent:0.2];
        enterBtu.layer.masksToBounds = YES;
        enterBtu.layer.borderWidth = 1;
        enterBtu.layer.cornerRadius = 4;
        enterBtu.layer.borderColor = [NSString colorWithHexString:@"cccccc"].CGColor;
        [enterBtu setTitle:@"点击进入" forState:UIControlStateNormal];
        [enterBtu setTitleColor:[NSString colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
        enterBtu.titleLabel.font = [UIFont systemFontOfSize:20];
        [enterBtu addTarget:self action:@selector(enterBtuClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:enterBtu];
        
        
        
        __weak typeof(self) weakSelf = self;
        [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf);
        }];
        
        if (isIphone4) {
            [itemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.mas_top).offset(22);
                make.centerX.equalTo(weakSelf.mas_centerX);
                make.width.equalTo(@(304*640.f/717.f));
                make.height.equalTo(@(304));
            }];
            
            [coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.mas_top).offset(112/480.f*kScreenHeight);
                make.left.equalTo(weakSelf.mas_left).offset(24);
                make.right.equalTo(weakSelf.mas_right).offset(-24);
                make.height.equalTo(@((kScreenWidth - 24*2)*300.f/640.f));
            }];
            
            [titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakSelf.mas_centerX).offset(-(kScreenWidth + 115)/2.f);
                make.top.equalTo(weakSelf.mas_bottom).offset(-114);
                make.width.equalTo(@(115));
                make.height.equalTo(@(24));
            }];
            
            [textImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakSelf.mas_centerX).offset((kScreenWidth + 136)/2.f);
                make.top.equalTo(weakSelf.mas_bottom).offset(-66);
                make.width.equalTo(@(136));
                make.height.equalTo(@(29));
            }];
        }else {
            [itemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.mas_top).offset(32/667.f*kScreenHeight);
                make.left.equalTo(weakSelf.mas_left);
                make.right.equalTo(weakSelf.mas_right);
                make.height.equalTo(@(kScreenWidth*1210.f/1080.f));
            }];
            
            [coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.mas_top).offset(156/667.f*kScreenHeight);
                make.left.equalTo(weakSelf.mas_left);
                make.right.equalTo(weakSelf.mas_right);
                make.height.equalTo(@(kScreenWidth*300.f/640.f));
            }];
            
            [titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakSelf.mas_centerX).offset(-(kScreenWidth + 130)/2.f);
                make.top.equalTo(weakSelf.mas_bottom).offset(-155/667.f*kScreenHeight);
                make.width.equalTo(@(130));
                make.height.equalTo(@(30));
            }];
            
            [textImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakSelf.mas_centerX).offset((kScreenWidth + 190)/2.f);
                make.top.equalTo(weakSelf.mas_bottom).offset(-94/667.f*kScreenHeight);
                make.width.equalTo(@(190));
                make.height.equalTo(@(38));
            }];
        }
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"4" withExtension:@"mp4"];
        NSDictionary *opts = [[NSDictionary alloc] initWithObjectsAndKeys:@YES, AVURLAssetPreferPreciseDurationAndTimingKey, nil];
        AVURLAsset *urlAsset = [[AVURLAsset alloc] initWithURL:url options:opts];
        if (isIphone4) {
            playView = [[DPMoviePlayerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) asset:urlAsset];
            playView.repeats = YES;
        }else {
            playView = [[DPMoviePlayerView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) asset:urlAsset];
            playView.repeats = YES;
        }
        
        [self addSubview:playView];
        
        [self bringSubviewToFront:enterBtu];
    }
    return self;
}

#pragma mark - methods
- (void)enterBtuClicked
{
    if (joinDuopaiBlock) {
        joinDuopaiBlock();
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)didMoveToWindow
{
    [self layoutIfNeeded];
}

- (void)dealloc
{
    [playView stop];
    playView = nil;
    bgImageView = nil;
    itemImageView = nil;
    coverImageView = nil;
    titleImageView = nil;
    textImageView = nil;
}

#pragma mark - methods
- (void)viewDidShow
{
    [self subviewsAnimation];
    [self playIntroduceVideo];
}

- (void)viewDidDismiss
{
    [self stopIntroduceVideo];
    [self subviewsRecover];
}

- (void)subviewsAnimation
{
    if (!animating) {
        animating = YES;
        itemImageView.transform = CGAffineTransformMakeScale(0.75f, 0.75f);
        [titleImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
        }];
        [textImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
        }];
        
        [UIView animateWithDuration:1.f animations:^{
            itemImageView.transform = CGAffineTransformMakeScale(1.f, 1.f);
            [titleImageView layoutIfNeeded];
            [textImageView layoutIfNeeded];
            [self layoutIfNeeded];
        }completion:^(BOOL finish){
            animating = NO;
            itemImageView.transform = CGAffineTransformIdentity;
        }];
    }
}

- (void)subviewsRecover
{
    [titleImageView setNeedsLayout];
    [textImageView setNeedsLayout];
    
    if (IOS_VERSION_8_OR_ABOVE) {
        itemImageView.transform = CGAffineTransformMakeScale(0.75f, 0.75f);
    }
    __weak typeof(self) weakSelf = self;
    if (iPhone4) {
        [titleImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.mas_centerX).offset(-(kScreenWidth + 115)/2.f);
        }];
        [textImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.mas_centerX).offset((kScreenWidth + 136)/2.f);
        }];
    }else {
        [titleImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.mas_centerX).offset(-(kScreenWidth + 130)/2.f);
        }];
        [textImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.mas_centerX).offset((kScreenWidth + 190)/2.f);
        }];
    }
    
    [titleImageView layoutIfNeeded];
    [textImageView layoutIfNeeded];
    [self layoutIfNeeded];
}

- (void)playIntroduceVideo
{
    [playView playOrResume];
}

- (void)stopIntroduceVideo
{
    [playView pause];
}

@end


