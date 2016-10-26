//
//  HSPlayer.h
//  rebirth
//
//  Created by 侯帅 on 16/8/12.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MediaPlayer/MPMoviePlayerController.h>
@interface HSPlayer : UIView
+(HSPlayer *)shareVido;

- (MPMoviePlayerController *)vidoByShare;
@end
