//
//  MenuRootVC.h
//  WJF-Drawer
//
//  Created by boom on 16/7/11.
//  Copyright © 2016年 boom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"

@interface MenuRootVC : UIViewController

@property(nonatomic,strong)UIButton  *totalBtu;

@property(nonatomic,strong)UIButton  *subBtu1;

@property(nonatomic,strong)UIButton  *subBtu2;


@property(nonatomic,strong)UIButton  *leftBtu;


@property(nonatomic,strong)UIButton  *rightBtu;


@property(nonatomic,strong)UILabel  *menuView;

@property(nonatomic,strong)UIView  *naviView;

-(void)backClick:(UIButton *)btu;

-(NSString*) createMd5Sign:(NSMutableDictionary*)dict;

-(NSString *) md5:(NSString *)str;


-(NSDictionary *)encryptDict:(NSMutableDictionary *)dict;
@end
