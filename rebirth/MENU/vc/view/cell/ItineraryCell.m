//
//  ItineraryCell.m
//  rebirth
//
//  Created by boom on 16/7/21.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "ItineraryCell.h"

//设置宽度
#define zScrollViewSize (self.scrllView.frame.size)

@implementation ItineraryCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.timeFirstView = [[OrderSubView1 alloc]init];
        self.timeFirstView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.timeFirstView];
        
        [self.timeFirstView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_top).with.offset(0);
            
            make.left.equalTo(self.mas_left).with.offset(0);
            
            make.right.equalTo(self.mas_right).with.offset(0);
            
            make.height.mas_equalTo(32);
            
            
            
        }];
        
        
        [self.timeFirstView.newsBtu mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.mas_right).with.offset(0);
            
            make.top.equalTo(self.mas_top).with.offset(12);
            
            make.width.mas_equalTo(0);
            
            make.height.mas_equalTo(12);
            
            
        }];
        
        
        self.scrllTotalView = [[UIView alloc]init];
        
        
        
        self.scrllTotalView.backgroundColor = [NSString colorWithHexString:@"#f2f2f2"];
        
        [self.contentView addSubview:self.scrllTotalView];
        
        [self.scrllTotalView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.top.equalTo(self.timeFirstView.mas_bottom).with.offset(0);
            
            make.left.equalTo(self.mas_left).with.offset(0);
            
            make.right.equalTo(self.mas_right).with.offset(0);
            
            make.height.mas_equalTo(192/2);
            
        }];
        
        self.scrllView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 12, WIDTH, 72)];
        
        self.scrllView.backgroundColor = [NSString colorWithHexString:@"#f2f2f2"];
        
        [self.scrllTotalView addSubview:self.scrllView];


        UIView  *moenyView = [[UIView alloc]init];

        moenyView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:moenyView];
        
        [moenyView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.top.equalTo(self.scrllTotalView.mas_bottom).with.offset(0);
            
            make.left.equalTo(self.mas_left).with.offset(0);
            
            make.right.equalTo(self.mas_right).with.offset(0);

            make.height.mas_equalTo(32);
            
        }];
        
        self.moneyLable = [[UILabel alloc]init];
        
        self.moneyLable.text = @"dnajsdadadalas";
        
        [moenyView addSubview:self.moneyLable];
        
        [self.moneyLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(moenyView.mas_top).with.offset(0);
            
            make.right.equalTo(self.mas_right).with.offset(-12);
            
            make.height.mas_equalTo(32);
            
            
            
        }];
        
        
        
        UIView  *btuView = [[UIView alloc]init];
        
        btuView.layer.masksToBounds = YES;
        btuView.layer.borderWidth = 0.5;
        btuView.layer.borderColor = [NSString colorWithHexString:@"f2f2f2"].CGColor;
        [self.contentView addSubview:btuView];
        
        [btuView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(moenyView.mas_bottom).with.offset(0);
            
            make.left.equalTo(self.mas_left).with.offset(0);
            
            make.right.equalTo(self.mas_right).with.offset(0);
            
            make.height.mas_equalTo(32);
            
            
        }];
        
        
        self.rightBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        
       [self.rightBtu setTitleColor:[NSString colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
       
        self.rightBtu.backgroundColor = [NSString colorWithHexString:@"#27292b"];
        [btuView addSubview:self.rightBtu];
        
        self.rightBtu.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [self.rightBtu mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(btuView.mas_right).with.offset(-12);
           
            make.centerY.equalTo(btuView.mas_centerY);
            
            make.height.mas_equalTo(24);
            
            make.width.mas_equalTo(60);
            
            
            
        }];
        
        
        
        
        self.leftBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        
        self.leftBtu.layer.borderWidth = 0.5;
        
        self.leftBtu.layer.borderColor = [NSString colorWithHexString:@"#f2f2f2"].CGColor;
        self.leftBtu.titleLabel.font = [UIFont systemFontOfSize:12];
         //[self.leftBtu setTitle:@"进行中" forState:UIControlStateNormal];
        
        [self.leftBtu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        
        [btuView addSubview:self.leftBtu];
        

        [self.leftBtu mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.right.equalTo(self.rightBtu.mas_left).with.offset(-12);
            
            make.centerY.equalTo(btuView.mas_centerY);
            
            make.height.mas_equalTo(24);
            
             make.width.mas_equalTo(60);
            
        }];
        
        
    }
    return self;
    
}

-(void)getImageScrView:(NSArray *)images{
    
  
    NSLog(@"%lu",(unsigned long)images.count);
    for (int i=0; i < images.count; i++) {
        
        CGFloat imageViewX =i * 72+12*(i+1);
        
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(imageViewX, 0, 72, 72)];
        
        //imageView.backgroundColor = [UIColor redColor];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:images[i][@"head_img"]] placeholderImage:nil];
        
        
        [self.scrllView addSubview:imageView];
    }
    
    CGFloat imageViewW=images.count * 84;
    
    self.scrllView.contentSize=CGSizeMake(imageViewW, 0);
    
    
    self.scrllView.showsHorizontalScrollIndicator=NO;
    
    self.scrllView.pagingEnabled=YES;
    
    self.scrllView.delegate=self;
    
}
@end
