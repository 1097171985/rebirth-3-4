//
//  HSXQCaipuCell.h
//  rebirth
//
//  Created by 侯帅 on 16/7/19.
//  Copyright © 2016年 侯帅. All rights reserved.
//

@protocol HSXQCaipuCellDelegate <NSObject>

- (void)moreBtDelegate;

@end
#import <UIKit/UIKit.h>

@interface HSXQCaipuCell : UITableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithArray :(NSMutableArray *)array withCaipu:(NSString *)caipu withArrayCount:(int)count;
@property (nonatomic, weak)id<HSXQCaipuCellDelegate>delegate;

@property(nonatomic,strong)UIButton *myBt;
@end
