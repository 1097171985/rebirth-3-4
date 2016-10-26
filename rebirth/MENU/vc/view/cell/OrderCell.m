//
//  OrderCell.m
//  rebirth
//
//  Created by boom on 16/7/20.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "OrderCell.h"

@implementation OrderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        
        self.subOrderView = [[OrderSubView1 alloc]init];
        self.subOrderView.backgroundColor = [UIColor whiteColor];

        [self.contentView addSubview:self.subOrderView];
        
        [self.subOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_left).with.offset(0);
            
            make.right.equalTo(self.mas_right).with.offset(0);
            
            make.height.mas_equalTo(32);
            
            
            
        }];
        
        
        [self.subOrderView.newsBtu mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.mas_right).with.offset(0);
            
            make.top.equalTo(self.mas_top).with.offset(12);
            
            make.width.mas_equalTo(0);
            
            make.height.mas_equalTo(12);
            
            
        }];
        
        
        
        
        self.sub2OrderView = [[OrderView2 alloc]init];
        
        //self.sub2OrderView.backgroundColor = [UIColor yellowColor];
        
        [self.contentView addSubview:self.sub2OrderView];
        
        [self.sub2OrderView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.left.equalTo(self.mas_left).with.offset(0);
            
            make.top.equalTo(self.subOrderView.mas_bottom).with.offset(1);
            
            make.right.equalTo(self.mas_right).with.offset(0);
            
            make.height.mas_equalTo(192/2);

            
        }];

        
        self.qucheTimeOrderView = [[OrderView3 alloc]init];
        self.qucheTimeOrderView.backgroundColor = [UIColor whiteColor];
        

        [self.contentView addSubview:self.qucheTimeOrderView];
        
        [self.qucheTimeOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.left.equalTo(self.mas_left).with.offset(0);
            
             make.top.equalTo(self.sub2OrderView.mas_bottom).with.offset(1);
            
            make.width.mas_equalTo(WIDTH/2);
            
            make.height.mas_equalTo(60);
            
            
        }];

        
        
        self.hauancheTimeOrderView = [[OrderView3 alloc]init];
        self.hauancheTimeOrderView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.hauancheTimeOrderView];
        
        [self.hauancheTimeOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.left.equalTo(self.qucheTimeOrderView.mas_right).with.offset(0);
            
            make.top.equalTo(self.sub2OrderView.mas_bottom).with.offset(1);
            
            make.width.mas_equalTo(WIDTH/2);
            
            make.height.mas_equalTo(60);
            
            
        }];

        self.addressView = [[OrderSubView1 alloc]init];
        self.addressView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.addressView];
        
        [self.addressView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.left.equalTo(self.mas_left).with.offset(0);
            
            make.top.equalTo(self.qucheTimeOrderView.mas_bottom).with.offset(1);
            
            make.width.mas_equalTo(WIDTH);
            
            make.height.mas_equalTo(44);
            
            
        }];

        
        self.insuranceView = [[OrderSubView1 alloc]init];
        self.insuranceView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.insuranceView];
        
        [self.insuranceView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.left.equalTo(self.mas_left).with.offset(0);
            
            make.top.equalTo(self.addressView.mas_bottom).with.offset(1);
            
            make.width.mas_equalTo(WIDTH);
            
            make.height.mas_equalTo(44);
            
            
        }];
       
        

        self.postalView = [[OrderSubView1 alloc]init];
        
        self.postalView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.postalView];

        [self.postalView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.left.equalTo(self.mas_left).with.offset(0);
            
            make.top.equalTo(self.insuranceView.mas_bottom).with.offset(1);
            
            make.width.mas_equalTo(WIDTH);
            
            make.height.mas_equalTo(44);
            
            
        }];
        [self.postalView.newsBtu mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.mas_right).with.offset(0);
            
            make.top.equalTo(self.mas_top).with.offset(12);
            
            make.width.mas_equalTo(0);
            
            make.height.mas_equalTo(12);
            
            
        }];
        
        
        self.insuranceOneView = [[OrderSubView1 alloc]init];
        
        self.insuranceOneView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.insuranceOneView];
        
        [self.insuranceOneView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.left.equalTo(self.mas_left).with.offset(0);
            
            make.top.equalTo(self.postalView.mas_bottom).with.offset(1);
            
            make.width.mas_equalTo(WIDTH);
            
            make.height.mas_equalTo(44);
            
            
        }];
        [self.insuranceOneView.newsBtu mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.mas_right).with.offset(0);
            
            make.top.equalTo(self.mas_top).with.offset(12);
            
            make.width.mas_equalTo(0);
            
            make.height.mas_equalTo(12);
            
            
        }];
        
        self.insuranceTwoView = [[OrderSubView1 alloc]init];
        
        self.insuranceTwoView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.insuranceTwoView];
        
        [self.insuranceTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.left.equalTo(self.mas_left).with.offset(0);
            
            make.top.equalTo(self.insuranceOneView.mas_bottom).with.offset(1);
            
            make.width.mas_equalTo(WIDTH);
            
            make.height.mas_equalTo(44);
            
            
        }];
        
        [self.insuranceTwoView.newsBtu mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.mas_right).with.offset(0);
            
            make.top.equalTo(self.mas_top).with.offset(12);
            
            make.width.mas_equalTo(0);
            
            make.height.mas_equalTo(12);
            
            
        }];
        
        
        self.insuranceThreeView = [[OrderSubView1 alloc]init];
        
        self.insuranceThreeView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.insuranceThreeView];
        
        [self.insuranceThreeView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.left.equalTo(self.mas_left).with.offset(0);
            
            make.top.equalTo(self.insuranceTwoView.mas_bottom).with.offset(1);
            
            make.width.mas_equalTo(WIDTH);
            
            make.height.mas_equalTo(44);
            
            
        }];
        
        [self.insuranceThreeView.newsBtu mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.mas_right).with.offset(0);
            
            make.top.equalTo(self.mas_top).with.offset(12);
            
            make.width.mas_equalTo(0);
            
            make.height.mas_equalTo(12);
            
            
        }];
        


        

    }
    
    return self;
}
@end
