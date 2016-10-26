//
//  HSPlayer.m
//  rebirth
//
//  Created by 侯帅 on 16/8/12.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
@interface HSPlayer ()

@property (nonatomic, strong) MPMoviePlayerController * rootPlayer;

@end

@implementation HSPlayer
{
    AVPlayer * rootPlayer;
    AVPlayerLayer *rootlayerPlayer;
}
+(HSPlayer *)shareVido
{
    static HSPlayer *vieoH = nil;
    static dispatch_once_t predited;
    dispatch_once(&predited, ^{
        vieoH = [[self alloc]init];
    });
    return vieoH;
}

- (AVPlayer *)vidoByShare
{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"];
    //
    NSURL *url=[[NSURL alloc] initFileURLWithPath:path];
     AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    if (!rootPlayer) {
         //rootPlayer=[[AVPlayer alloc] init];
        //初始化player对象
        rootPlayer = [[AVPlayer alloc] initWithPlayerItem:item];
        //设置播放页面
        rootlayerPlayer = [AVPlayerLayer playerLayerWithPlayer:rootPlayer];
        //设置播放页面的大小
        rootlayerPlayer.frame = CGRectMake(0, 0,kScreenWidth, 510/2-20);
        // layer.backgroundColor = [UIColor blueColor].CGColor;
        //设置播放窗口和当前视图之间的比例显示内容
        rootlayerPlayer.videoGravity = AVLayerVideoGravityResizeAspect;
        
        [self.layer addSublayer:rootlayerPlayer];
        
        [rootPlayer play];

    }
    
    //设置播放的默认音量值
    //self.player.volume = 100;

//
//     [rootPlayer setContentURL:url];
//    rootPlayer.scalingMode = MPMovieScalingModeAspectFill;
//    rootPlayer.view.frame=CGRectMake(0, 0, kScreenWidth, 510/2-20);
//    rootPlayer.repeatMode = MPMovieRepeatModeOne;
//   
//    
//    rootPlayer.movieSourceType=MPMovieSourceTypeFile;//本地文件播放要设置视频资源为文件类型资源，若设置为stream 则会错误
//    [rootPlayer setControlStyle:MPMovieControlStyleNone];
//    [rootPlayer play];
//    
//    self.rootPlayer.initialPlaybackTime = -1.0;
    
    return rootPlayer;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
