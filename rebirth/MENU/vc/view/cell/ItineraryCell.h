//
//  ItineraryCell.h
//  rebirth
//
//  Created by boom on 16/7/21.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OrderSubView1.h"
@interface ItineraryCell : UITableViewCell<UIScrollViewDelegate>

@property(nonatomic,strong)OrderSubView1 *timeFirstView;

@property(nonatomic,strong)UIView  *scrllTotalView;

@property(nonatomic,strong)UIScrollView  *scrllView;

@property(nonatomic,strong)UILabel  *moneyLable;

@property(nonatomic,strong)UIButton *leftBtu;

@property(nonatomic,strong)UIButton  *rightBtu;

-(void)getImageScrView:(NSArray *)images;
@end
