//
//  HSCDXQMapCell.h
//  rebirth
//
//  Created by 侯帅 on 16/7/20.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MAMapKit/MAMapKit.h>

@interface HSCDXQMapCell : UITableViewCell

@property(nonatomic,strong)MAMapView *mapView;


@property(nonatomic,strong)UILabel *addressLable;

@property(nonatomic,strong)UILabel *biaotiLbl;


@end
