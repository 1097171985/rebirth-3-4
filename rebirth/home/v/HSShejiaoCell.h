//
//  HSShejiaoCell.h
//  rebirth
//
//  Created by 侯帅 on 16/9/22.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSShejiaoModel.h"
#import "MyModel.h"

@protocol backaa <NSObject>

-(void)backdele:(NSString *)stf;

@end


typedef void (^publishReiseOrPraise)(NSString*);

//图片点击
@protocol ImageDelegate <NSObject>

-(void)checkImage:(NSString*)imgname;

@end

//评论--点赞
@protocol ReviseDelegate <NSObject>

-(void)publishReiseOrPraise:(NSString*)method cellTag:(NSInteger)tag;

@end

@interface HSShejiaoCell : UITableViewCell
@property (strong,nonatomic) UIImageView *headerImageView;
@property (strong,nonatomic) UILabel *contentLabel;
@property (strong,nonatomic) UILabel *timeLabel;

@property (strong,nonatomic) UILabel *nameLabel;


@property (strong,nonatomic)UIImageView *videoImage;

@property (strong,nonatomic) HSShejiaoModel *hsshejiaomodel;
-(void)setmodel:(HSShejiaoModel *)model;
-(CGFloat )getHeight;
@property (copy ,nonatomic) publishReiseOrPraise myBlock;

@property (weak, nonatomic) id<ImageDelegate>myDelegate;

@property (weak, nonatomic) id<ReviseDelegate> delegate;


@property (strong, nonatomic) MyModel *myModel;
@property (strong, nonatomic) HSShejiaoModel *myModel1;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDisProArray:(NSMutableArray *)disProArray;

@end
