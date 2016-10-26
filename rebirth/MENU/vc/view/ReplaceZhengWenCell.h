//
//  ReplaceZhengWenCell.h
//  rebirth
//
//  Created by WJF on 16/10/13.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReplaceModel.h"
#import "ReplaceView.h"

@protocol reldelegatecell <NSObject>

-(void)clickbbb;

@end



@interface ReplaceZhengWenCell : UITableViewCell<replaceDelegate>
@property(nonatomic,weak)id<reldelegatecell>delegate;
@property(nonatomic, assign)CGFloat  replaceHeight;
@property(nonatomic, strong)UILabel *subOneContent;
@property(nonatomic, strong)UIButton *moreLabel;

@property(nonatomic, strong)UIView  *totalSunTwView;

@property(nonatomic, strong)UIButton *delectBtu;


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier  withbool:(BOOL)replaceBool withreplaceArr:(ReplaceModel *)replaceModel;
@end
