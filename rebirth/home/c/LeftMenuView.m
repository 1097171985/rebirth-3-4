//
//  LeftMenuView.m
//  rebirth
//
//  Created by 侯帅 on 16/7/18.
//  Copyright © 2016年 侯帅. All rights reserved.
//
#define ImageviewWidth    18
#define Frame_Width       self.frame.size.width//200
#import "LeftMenuView.h"
#import "HSLoginViewController.h"
@interface LeftMenuView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView          *contentTableView;

@end
@implementation LeftMenuView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}
-(void)loginStateChange:(NSNotification *)notification{
    LeftMenuView *lll = [[LeftMenuView alloc] init];
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSString *idd = [userdefaults objectForKey:@"token"];
    NSString *iddd = [NSString stringWithFormat:@"%@",idd];
    if (iddd.length<7) {
        [lll.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [lll.NameLabel setText:@"登录/注册"];
    }else{
        [lll.loginBtn setTitle:@"注销" forState:UIControlStateNormal];
        [lll.NameLabel setText:[USER_DEFAULT objectForKey:@"phone"]];
    }
    
}

-(void)initView{
   

    self.backgroundColor = [NSString colorWithHexString:@"000000"];
    //添加头部
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Frame_Width, 187)];
    [headerView setBackgroundColor:[UIColor clearColor]];
    
    
    CGFloat width          = 90/2;
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(12*WIDTHRATIO, (90 - width) / 2, width, width)];
    //imageview.backgroundColor = [UIColor whiteColor];
    //    [imageview setBackgroundColor:[UIColor redColor]];
    imageview.layer.cornerRadius = imageview.frame.size.width / 2;
    imageview.layer.masksToBounds = YES;
    [imageview setImage:[UIImage imageNamed:@"HeadIcon"]];
    imageview.tag = 1001;
    
    [headerView addSubview:imageview];
    
    imageview.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage:)];
    [imageview addGestureRecognizer:singleTap];
    
    
    width                  = 15;
    self.arrow     = [[UIImageView alloc]initWithFrame:CGRectMake(80*WIDTHRATIO, 60, 80*WIDTHRATIO, 80*HEIGHTRATIO)];
  //  self.arrow.backgroundColor = [UIColor redColor];
  //  self.arrow.contentMode      = UIViewContentModeScaleAspectFit;
    self.arrow.layer.cornerRadius = 40*WIDTHRATIO;
     self.arrow.layer.masksToBounds = YES;
     NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"image.png"];
    
    UIImage *img ;
    NSUserDefaults *user= [NSUserDefaults standardUserDefaults];
    
//    if (fullPath && [user objectForKey:@"id"]) {
//        
//        img = [[UIImage alloc] initWithContentsOfFile:fullPath];
//        
//        
//    }else{
    
        img = [UIImage imageNamed:@"default_avatar@2x"];
        
//    }
   
    [_arrow setImage:img];
    [headerView addSubview:_arrow];
    _arrow.userInteractionEnabled =YES;
    UITapGestureRecognizer *singleTap1 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage:)];
    [_arrow addGestureRecognizer:singleTap1];
    _NameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _NameBtn.frame =CGRectMake(0, 60+_arrow.frame.size.height+20, Frame_Width, 14);
    _NameBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_NameBtn setTitleColor:[NSString colorWithHexString:@"e4c675"] forState:UIControlStateNormal];
    _NameBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:_NameBtn];
    _NameBtn.tag = 1000;
    [_NameBtn addTarget:self action:@selector(zhuxiao1:) forControlEvents:UIControlEventTouchUpInside];
    UIView *viewline = [[UIView alloc] init];
    viewline.frame= CGRectMake(5, 60+_arrow.frame.size.height+20+_NameBtn.frame.size.height+10, [[UIScreen mainScreen] bounds].size.width * 0.64-10, 0.5);
    viewline.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:viewline];

    
//    _NameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,60+_arrow.frame.size.height+20,Frame_Width,14)];
//    
//   
//    _NameLabel.font = [UIFont systemFontOfSize:14];
//    _NameLabel.textColor = [NSString colorWithHexString:@"e4c675"];
//    [headerView addSubview:_NameLabel];
//    _NameLabel.textAlignment = NSTextAlignmentCenter;
//    
    [self addSubview:headerView];
    
    
    //中间tableview
    UITableView *contentTableView        = [[UITableView alloc]initWithFrame:CGRectMake(0, headerView.frame.size.height, Frame_Width, self.frame.size.height - headerView.frame.size.height - 50)
                                                                       style:UITableViewStylePlain];
    contentTableView.scrollEnabled = NO;
//        [contentTableView setBackgroundColor:[NSString colorWithHexString:@"000000"]];
    [contentTableView setBackgroundColor:[UIColor clearColor]];
//    [contentTableView setBackgroundColor:[UIColor colorWithRed:33 green:33 blue:33 alpha:0.5]];
    contentTableView.dataSource          = self;
    contentTableView.delegate            = self;
    contentTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    //    [contentTableView setBackgroundColor:[UIColor whiteColor]];
    
    contentTableView.separatorStyle      = UITableViewCellSeparatorStyleNone;
    contentTableView.tableFooterView = [UIView new];
    self.contentTableView = contentTableView;
    [self addSubview:contentTableView];
    
    //添加尾部
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 60, Frame_Width, 40)];
    [footerView setBackgroundColor:[UIColor clearColor]];
   _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.frame =CGRectMake(0, 0, Frame_Width, 40);
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSString *idd = [userdefaults objectForKey:@"token"];
    NSString *iddd = [NSString stringWithFormat:@"%@",idd];
    if (iddd.length<7) {
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_NameBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
        // [_NameLabel setText:@"登录/注册"];
    }else{
        [_loginBtn setTitle:@"注销" forState:UIControlStateNormal];
        // [_NameLabel setText:[USER_DEFAULT objectForKey:@"phone"]];
        [_NameBtn setTitle:[USER_DEFAULT objectForKey:@"phone"] forState:UIControlStateNormal];
        
    }
    
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _loginBtn.tag =1000;
    [footerView addSubview:_loginBtn];
    [_loginBtn addTarget:self action:@selector(zhuxiao:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self addSubview:footerView];
    
}
-(void)onClickImage:(UITapGestureRecognizer *)sender{
    NSLog(@"点击图片");
    if([self.customDelegate respondsToSelector:@selector(LeftMenuViewClick:)]){
        [self.customDelegate LeftMenuViewClick:1001];
    }

}

-(void)zhuxiao1:(UIButton *)sender{
    if([self.customDelegate respondsToSelector:@selector(LeftMenuViewClick:)]){
        [self.customDelegate LeftMenuViewClick:1111];
    }
}
-(void)zhuxiao:(UIButton *)sender{
    NSLog(@"login");
    if([self.customDelegate respondsToSelector:@selector(LeftMenuViewClick:)]){
        [self.customDelegate LeftMenuViewClick:1000];
    }

    
   
}
#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = [NSString stringWithFormat:@"LeftView%li",indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    
    //    [cell setCellModel:nil indexPath:indexPath];
    //    [cell setBackgroundColor:[UIColor colorWithHexString:ColorBackGround]];
    cell.hidden = NO;
    switch (indexPath.row) {
        case 0:
        {
            [cell.imageView setImage:[UIImage imageNamed:@"person-icon1"]];
            [cell.textLabel setText:@"账户绑定"];
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
            break;
            
        case 1:
        {
            
            [cell.imageView setImage:[UIImage imageNamed:@"person-icon2"]];
            [cell.textLabel setText:@"帮助"];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
             cell.textLabel.font = [UIFont systemFontOfSize:16];
        }
            break;
            
            
        case 2:
        {
            
            [cell.imageView setImage:[UIImage imageNamed:@"person-icon4"]];
            [cell.textLabel setText:@"关于UP！"];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
             cell.textLabel.font = [UIFont systemFontOfSize:16];
        }
            break;
//            
        case 3:
        {
            
            [cell.imageView setImage:[UIImage imageNamed:@"person-icon5"]];
            [cell.textLabel setText:@"优惠券"];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
             cell.textLabel.font = [UIFont systemFontOfSize:16];
        }
            break;
//            //新增 整车调度
//        case 4:{
//            
//            [cell.imageView setImage:[UIImage imageNamed:@"person-icon10"]];
//            [cell.textLabel setText:@"关于rebirth"];
//            cell.textLabel.textAlignment = NSTextAlignmentCenter;
//             cell.textLabel.font = [UIFont systemFontOfSize:16];
//        }
//            break;
            
            
            
            
        default:
            break;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if([self.customDelegate respondsToSelector:@selector(LeftMenuViewClick:)]){
        [self.customDelegate LeftMenuViewClick:indexPath.row];
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
