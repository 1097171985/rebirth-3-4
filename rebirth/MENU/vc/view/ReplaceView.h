//
//  ReplaceView.h
//  rebirth
//
//  Created by WJF on 16/10/13.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReplaceBlock)();
@protocol replaceDelegate <NSObject>

-(void)clickBtn;

@end
@interface ReplaceView : UIView

@property(nonatomic, strong)UIImageView *replaceTouXiang;

@property(nonatomic, strong)UILabel  *replaceName;

@property(nonatomic, strong)UILabel  *replaceTime;

@property(nonatomic, strong)UILabel  *replaceContext;

@property(nonatomic, strong)UIButton *delectReplaceImage;

@property(nonatomic, strong)NSDictionary *replaceDict;

@property(nonatomic, assign)ReplaceBlock replaceBlock;
@property(nonatomic,weak)id<replaceDelegate>repdelegate;

-(instancetype)initWithFrame:(CGRect)frame withReplace:(NSDictionary *)replace;

@end
