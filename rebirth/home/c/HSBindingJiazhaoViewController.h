//
//  HSBindingJiazhaoViewController.h
//  rebirth
//
//  Created by 侯帅 on 16/8/3.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSBindingJiazhaoViewController : UIViewController
@property (nonatomic,strong) NSString *cardId;
@property (nonatomic,strong) NSString *end_date;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *start_date;
@property (nonatomic,strong) NSString *vehicle_type;
@property(nonatomic,strong)UIImage *selectImage;
@property (nonatomic,strong)NSString *img;
@property (nonatomic,strong)NSString *from;
@property(nonatomic,strong)UIImageView *dirveimg;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)UIImage *img1 ;

@end
