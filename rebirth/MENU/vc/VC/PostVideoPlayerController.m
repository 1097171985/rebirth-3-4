//
//  PostVideoPlayerController.m
//  MKCustomCamera
//
//  Created by ykh on 16/1/6.
//  Copyright © 2016年 MK. All rights reserved.
//

//获取屏幕 宽度、高度
#define WIDTH ([UIScreen mainScreen].bounds.size.width)
#define HEIGHT ([UIScreen mainScreen].bounds.size.height)

#import "PostVideoPlayerController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

#import "UIPlaceHolderTextView.h"
#import "HSSementViewController.h"
@interface PostVideoPlayerController()<UITextViewDelegate>
{

    AVPlayer *_player;
    AVPlayerItem *_playItem;
    AVPlayerLayer *_playerLayer;
    AVPlayerLayer *_fullPlayer;
    BOOL _isPlaying;
}
@property (strong, nonatomic) UIButton *saveBtn;

@property(nonatomic, strong)UIPlaceHolderTextView *placeHTextView;
@end

@implementation PostVideoPlayerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self create];
    
    NSString* path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"jjjjjjjj.mov"];
    
//    NSString *url =[NSString stringWithFormat:@"file://%@",[[NSBundle mainBundle]
//                     pathForResource:@"hhhhhhhh"
//                     ofType:@"mov"]];

    NSURL *url = [[NSBundle mainBundle]URLForResource:@"hhhhhhhh" withExtension:@"mov"];
    
//    NSLog(@"%@==---%@",url,[NSURL URLWithString:@"/var/containers/Bundle/Application/20EC6BDE-A0DE-41DB-8895-E287CC8D06EC/UP.app/hhhhhhhh.mov"]);
   // [self loadVideoByPath:url andSavePath:path];
    [self loadNaviRight];
    UIImageView  *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,300, WIDTH,400)];
    imageView.image  = [self imageForVideo:self.videoUrl size:CGSizeMake(WIDTH, 400)];

    //[self.view addSubview:imageView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:)name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    //时间差
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.saveBtn.enabled = YES;
//    });
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_player pause];
    _player = nil;
}

-(void)loadNaviRight{
    
    UIButton *sendBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtu.backgroundColor = [UIColor blackColor];
    [sendBtu setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtu setTitleColor:[NSString colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    
    sendBtu.layer.masksToBounds = YES;
    
    sendBtu.layer.cornerRadius = 3;
    sendBtu.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.naviView addSubview:sendBtu];
    
    [sendBtu addTarget:self action:@selector(compressVideo:) forControlEvents:UIControlEventTouchUpInside];
    
    [sendBtu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.naviView.mas_right).with.offset(-8);
        
        make.centerY.equalTo(self.naviView.mas_centerY).with.offset(kStatusBarHeight/2);
        
        make.height.mas_equalTo(56/2);
        
        make.width.mas_equalTo(112/2);
        
    }];
    
    
}



- (void)create
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.placeHTextView = [[UIPlaceHolderTextView alloc]initWithFrame:CGRectMake(12,12+64, 200,107)];
    
    [self.placeHTextView setEditable:YES];
    [self.placeHTextView becomeFirstResponder];
    self.placeHTextView.delegate = self;
    self.placeHTextView.backgroundColor = [UIColor whiteColor];
    self.placeHTextView.placeholder = @"说点什么吧...";
    self.placeHTextView.placeholderColor = [NSString colorWithHexString:@"#6d7278"];
    self.placeHTextView.font = [UIFont systemFontOfSize:14];
    self.placeHTextView.textColor = [NSString colorWithHexString:@"949494"];
    [self.view addSubview:self.placeHTextView];
    
    
    
    
    
    
    _playItem = [AVPlayerItem playerItemWithURL:self.videoUrl];
    _player = [AVPlayer playerWithPlayerItem:_playItem];
    _playerLayer =[AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.frame = CGRectMake(self.placeHTextView.frame.origin.x+self.placeHTextView.frame.size.width+20, 12+64, 120, 90);
    _playerLayer.videoGravity=AVLayerVideoGravityResizeAspectFill;//视频填充模式
    [self.view.layer addSublayer:_playerLayer];
    [_player play];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    
    BOOL contains1 = CGRectContainsPoint(self.placeHTextView.frame,point);
    
    if (!contains1) {
        
        if (self.placeHTextView.text.length == 0) {
          //  shengyulabel.text = @"";
        }
        [self.placeHTextView resignFirstResponder];
    }

    
    if (!_isPlaying) {
        BOOL contains2 = CGRectContainsPoint(_playerLayer.frame,point);
        
        if (contains2) {
         _isPlaying = !_isPlaying;
         _playerLayer.frame = [UIScreen mainScreen].bounds;
        }
        
    }else{
        _playerLayer.frame = CGRectMake(self.placeHTextView.frame.origin.x+self.placeHTextView.frame.size.width+20, 12+64, 120, 90);
         _isPlaying = !_isPlaying;
    }
   
}

-(void)playbackFinished:(NSNotification *)notification
{
    [_player seekToTime:CMTimeMake(0, 1)];
    [_player play];
}


///
-(UIImage *)imageForVideo:(NSURL *)videoUrl size:(CGSize)size{
    
    // 获取视频第一帧
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:videoUrl options:opts];
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    generator.appliesPreferredTrackTransform = YES;
    generator.maximumSize = CGSizeMake(size.width, size.height);
    NSError *error = nil;
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(0, 10) actualTime:NULL error:&error];
    if (error == nil)
    {
        return [UIImage imageWithCGImage:img];
    }
    return nil;
    
}





-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    NSLog(@"%lu",(unsigned long)range.location);
    if (range.location>400)
    {
        //控制输入文本的长度
        return  NO;
    }
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    //shengyulabel.text = [NSString stringWithFormat:@"%lu",400-range.location];
    return YES;
}


- (void) loadVideoByPath:(NSURL*) v_strVideoPath andSavePath:(NSString*) v_strSavePath {
    NSLog(@"\nv_strVideoPath = %@ \nv_strSavePath = %@\n ",v_strVideoPath,v_strSavePath);
    AVAsset *avAsset = [AVAsset assetWithURL:v_strVideoPath];
    CMTime assetTime = [avAsset duration];
    Float64 duration = CMTimeGetSeconds(assetTime);
    NSLog(@"视频时长 %f\n",duration);
    
    AVMutableComposition *avMutableComposition = [AVMutableComposition composition];
    
    AVMutableCompositionTrack *avMutableCompositionTrack = [avMutableComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    
    AVAssetTrack *avAssetTrack = [[avAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
    
    NSError *error = nil;
    // 这块是裁剪,rangtime .前面的是开始时间,后面是裁剪多长 (我这裁剪的是从第二秒开始裁剪，裁剪2.55秒时长.)
    [avMutableCompositionTrack insertTimeRange:CMTimeRangeMake(CMTimeMakeWithSeconds(0, 30), CMTimeMakeWithSeconds(duration, 30))
                                       ofTrack:avAssetTrack
                                        atTime:kCMTimeZero
                                         error:&error];
    
    AVMutableVideoComposition *avMutableVideoComposition = [AVMutableVideoComposition videoComposition];
    // 这个视频大小可以由你自己设置。比如源视频640*480.而你这320*480.最后出来的是320*480这么大的，640多出来的部分就没有了。并非是把图片压缩成那么大了。
    avMutableVideoComposition.renderSize = CGSizeMake(640.0f, 480.0f);
    avMutableVideoComposition.frameDuration = CMTimeMake(1, 30);
    AVMutableVideoCompositionInstruction *avMutableVideoCompositionInstruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    
    [avMutableVideoCompositionInstruction setTimeRange:CMTimeRangeMake(kCMTimeZero, [avMutableComposition duration])];
    
    AVMutableVideoCompositionLayerInstruction *avMutableVideoCompositionLayerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:avAssetTrack];
    [avMutableVideoCompositionLayerInstruction setTransform:avAssetTrack.preferredTransform atTime:kCMTimeZero];
    
    avMutableVideoCompositionInstruction.layerInstructions = [NSArray arrayWithObject:avMutableVideoCompositionLayerInstruction];
    
    avMutableVideoComposition.instructions = [NSArray arrayWithObject:avMutableVideoCompositionInstruction];
    
    NSFileManager *fm = [[NSFileManager alloc] init];
    if ([fm fileExistsAtPath:v_strSavePath]) {
        NSLog(@"video is have. then delete that");
        if ([fm removeItemAtPath:v_strSavePath error:&error]) {
            NSLog(@"delete is ok");
        }else {
            NSLog(@"delete is no error = %@",error.description);
        }
    }
    
    AVAssetExportSession *avAssetExportSession = [[AVAssetExportSession alloc] initWithAsset:avMutableComposition presetName:AVAssetExportPreset640x480];
    [avAssetExportSession setVideoComposition:avMutableVideoComposition];
    [avAssetExportSession setOutputURL:[NSURL fileURLWithPath:v_strSavePath]];
    [avAssetExportSession setOutputFileType:AVFileTypeQuickTimeMovie];
    [avAssetExportSession setShouldOptimizeForNetworkUse:YES];
    [avAssetExportSession exportAsynchronouslyWithCompletionHandler:^(void){
        switch (avAssetExportSession.status) {
            case AVAssetExportSessionStatusFailed:
                NSLog(@"exporting failed %@",[avAssetExportSession error]);
                break;
            case AVAssetExportSessionStatusCompleted:
            {NSLog(@"exporting completed");
                // 想做什么事情在这个做
                    AVAsset *avAsset2222 = [AVAsset assetWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"file://%@",v_strSavePath]]];
                    CMTime assetTime22 = [avAsset2222 duration];
                    Float64 duration222 = CMTimeGetSeconds(assetTime22);
                    NSLog(@"视频时长??????? %f\n",duration222);
                
                self.videoUrl = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@",v_strSavePath]];
                break;
            }
            case AVAssetExportSessionStatusCancelled:
                NSLog(@"export cancelled");
                break;
        }
    }];
    if (avAssetExportSession.status != AVAssetExportSessionStatusCompleted){
        NSLog(@"Retry export");
    }
    
}

#pragma mark 保存压缩
- (NSURL *)compressedURL
{
    return [NSURL fileURLWithPath:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"compressed.mp4"]]];
}

- (CGFloat)fileSize:(NSURL *)path
{
    return [[NSData dataWithContentsOfURL:path] length]/1024.00 /1024.00;
}



// 压缩视频
- (void)compressVideo:(UIButton *)sender
{
    NSLog(@"压缩前大小 %f MB",[self fileSize:_videoUrl]);
    
    //    创建AVAsset对象
    AVAsset* asset = [AVAsset assetWithURL:_videoUrl];
    
    
    /*   创建AVAssetExportSession对象
     压缩的质量
     AVAssetExportPresetLowQuality   最low的画质最好不要选择实在是看不清楚
     AVAssetExportPresetMediumQuality  使用到压缩的话都说用这个
     AVAssetExportPresetHighestQuality  最清晰的画质
     
     */
    AVAssetExportSession * session = [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetMediumQuality];
    //优化网络
    session.shouldOptimizeForNetworkUse = YES;
    //转换后的格式
    
    //拼接输出文件路径 为了防止同名 可以根据日期拼接名字 或者对名字进行MD5加密
    
    NSString* path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"hello.mp4"];
    //判断文件是否存在，如果已经存在删除
    [[NSFileManager defaultManager]removeItemAtPath:path error:nil];
    //设置输出路径
    session.outputURL = [NSURL fileURLWithPath:path];
    
    //设置输出类型  这里可以更改输出的类型 具体可以看文档描述
    session.outputFileType = AVFileTypeMPEG4;
    
    [session exportAsynchronouslyWithCompletionHandler:^{
        NSLog(@"%@",[NSThread currentThread]);
        
        //压缩完成
        if (session.status==AVAssetExportSessionStatusCompleted) {
            //在主线程中刷新UI界面，弹出控制器通知用户压缩完成
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"导出完成");
                NSURL *CompressURL = session.outputURL;
                NSLog(@"压缩完毕,压缩后大小 %f MB",[self fileSize:CompressURL]);
                
                [self upLoad:CompressURL];
                [self saveVideo:session.outputURL];
            });
            
        }
        
    }];
}


-(void)upLoad:(NSURL *)compressUrl{

    NSDictionary *dict = @{@"id":[USER_DEFAULT objectForKey:@"id"],@"route":@"News_submitNews",@"version":@"1",@"textContent":self.placeHTextView.text,@"category":@"2",@"token":[USER_DEFAULT objectForKey:@"token"]};
    
    NSDictionary *signDict = [self encryptDict:(NSMutableDictionary *)dict];
    
    [WJFCollection uploadWithUrlString:@"http://www.rempeach.com/rebirth/api/AppApi/receive" withImage:[self imageForVideo:self.videoUrl size:CGSizeMake(WIDTH, 400)] withVideo:compressUrl parameters:signDict uploadParam:nil success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        if ([responseObject[@"state"] isEqualToString:@"210"]) {
           
            HSSementViewController *vc = [[HSSementViewController alloc]init];
            vc.frrr = @"shipin";
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }
        
    } failue:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
    
}


- (void)saveVideo:(NSURL *)outputFileURL
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library writeVideoAtPathToSavedPhotosAlbum:outputFileURL
                                completionBlock:^(NSURL *assetURL, NSError *error) {
                                    if (error) {
                                        NSLog(@"保存视频失败:%@",error);
                                    } else {
                                        NSLog(@"保存视频到相册成功");
                                    }
                                }];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
