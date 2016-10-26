//
//  HSphotoViewController.h
//  rebirth
//
//  Created by 侯帅 on 16/9/23.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol fromDelegate <NSObject>

-(void)click:(NSString *)from;

@end
@interface HSphotoViewController : UIViewController
@property (nonatomic,weak)id<fromDelegate>delegate;
@property (nonatomic,strong)NSString *from;
@end
