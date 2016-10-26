//
//  OrderCell.h
//  rebirth
//
//  Created by boom on 16/7/20.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderView2.h"

#import "OrderView3.h"


#import "OrderSubView1.h"


@interface OrderCell : UITableViewCell

@property(nonatomic,strong)OrderSubView1  *subOrderView;

@property(nonatomic,strong)OrderView2  *sub2OrderView;//

@property(nonatomic,strong)OrderView3 *qucheTimeOrderView;


@property(nonatomic,strong)OrderView3 *hauancheTimeOrderView;

@property(nonatomic,strong)OrderSubView1  *addressView;

@property(nonatomic,strong)OrderSubView1  *insuranceView;

@property(nonatomic,strong)OrderSubView1  *postalView;

@property(nonatomic,strong)OrderSubView1  *insuranceOneView;

@property(nonatomic,strong)OrderSubView1  *insuranceTwoView;

@property(nonatomic,strong)OrderSubView1  *insuranceThreeView;
@end
