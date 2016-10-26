//
//  FirstViewController.h
//  rebirth
//
//  Created by boom on 16/7/27.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol backDelegate <NSObject>

-(void)back:(NSString *)stt;

@end




@interface FirstViewController : UIViewController
@property (nonatomic,weak)id<backDelegate>delegate;
@property(nonatomic,strong)NSMutableArray *firstArray;

@property(nonatomic,assign)int  selecteIndex;

@end
