//
//  GradePrerogativeVC.m
//  rebirth
//
//  Created by WJF on 16/10/8.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "GradePrerogativeVC.h"
#import "GradePrerogativeCell.h"

#define  TotalArr @[@"24小时贴心客服",@"免费使用60s视频拍摄功能",@"生日当天预定套餐享受8.9折并赠送哈根达斯蛋糕劵",@"享受优先预约，急速退款特权",@"预定套餐免意向金"]
#define  TotalDate @[@"5000",@"10000",@"30000",@"50000",@"80000",@"100000"]
@interface GradePrerogativeVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong)UITableView *gradePrerogativeTab;

@property(nonatomic, strong)NSMutableArray *data;

@property(nonatomic, strong)UILabel *consumptionLabel;

@property(nonatomic, strong)UIImageView *touXiangImage;

@property(nonatomic, strong)UIImageView *gradeImage;

@property(nonatomic, strong)UIView  *totalJifen;

@property(nonatomic, assign)CGFloat numBerInt;

@property(nonatomic, assign)CGFloat originY;

@end

@implementation GradePrerogativeVC
-(void)backClick:(UIButton *)btu{
    
    if ([self.stype isEqualToString:@"login"]) {
        
        NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
        
        for (UIViewController *vc in marr) {
            if ([vc isKindOfClass:[HSLoginViewController class]]) {
                [marr removeObject:vc];
                break;
            }
        }
        self.navigationController.viewControllers = marr;
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    self.menuView.text = @"等级特权";
    self.numBerInt = 81000;
    [self loadData];
    
    [self loadJiFenGrade];
    
    [self loadGradePrerogativeTab];
    // Do any additional setup after loading the view.
}


-(void)loadJiFenGrade{
    

    self.totalJifen = [[UIView alloc]initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, WIDTH, 390/2)];
     self.totalJifen.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: self.totalJifen];
   
    self.touXiangImage = [[UIImageView alloc]initWithFrame:CGRectMake( self.totalJifen.center.x-144/4, 20, 144/2, 144/2)];
    
    [ self.totalJifen addSubview:self.touXiangImage];
    
    self.touXiangImage.layer.masksToBounds = YES;
    self.touXiangImage.layer.cornerRadius = 144/4;
    self.touXiangImage.layer.borderWidth = 1;
    self.touXiangImage.layer.borderColor = [NSString colorWithHexString:@"27292b"].CGColor;
    
    self.gradeImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.touXiangImage.frame.origin.x+self.touXiangImage.frame.size.width-20,self.touXiangImage.frame.origin.y+self.touXiangImage.frame.size.height-20 , 20, 20)];
    self.gradeImage.image = [UIImage imageNamed:@"vip_round_1"];
    [ self.totalJifen addSubview:self.gradeImage];
    
    self.consumptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.touXiangImage.frame.origin.y+self.touXiangImage.frame.size.height+20, WIDTH,14)];
    self.consumptionLabel.textAlignment = NSTextAlignmentCenter;
    self.consumptionLabel.font = [UIFont systemFontOfSize:14];
    
    NSString *str = @"当前消费额：¥5600";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[NSString colorWithHexString:@"27292b"]
                    range:NSMakeRange(0, 6)];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[NSString colorWithHexString:@"e4c675"]
                    range:NSMakeRange(6, attrStr.length-6)];
    self.consumptionLabel.attributedText = attrStr;
    [ self.totalJifen addSubview:self.consumptionLabel];
    
    [ self.totalJifen sizeToFit];
    
    self.originY = self.consumptionLabel.frame.origin.y+self.consumptionLabel.frame.size.height+24;
    for(int i =0;i<6; i++){
        
        UIView *jifen = [[UIView alloc]initWithFrame:CGRectMake((17+i*114/2)*WIDTHRATIO, self.originY,112/2,4)];
        if (i == 0 ) {
            
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:jifen.bounds byRoundingCorners:UIRectCornerTopLeft  | UIRectCornerBottomLeft cornerRadii:CGSizeMake(2, 2)].CGPath;
            jifen.layer.mask = shapeLayer;

        }else if ( i == 5){
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:jifen.bounds byRoundingCorners:UIRectCornerBottomRight  | UIRectCornerTopRight cornerRadii:CGSizeMake(2, 2)].CGPath;
            jifen.layer.mask = shapeLayer;
            
        }
        jifen.backgroundColor = [NSString colorWithHexString:@"ceced0"];
        
        [ self.totalJifen addSubview:jifen];
    }
}



-(void)loadProgress{
    
    if(self.numBerInt <= [TotalDate[0] intValue] ){
        
        CGFloat proportion  = self.numBerInt/[TotalDate[0] floatValue];
        
        CGFloat width = proportion *56;
        
        UIView *backJifen = [[UIView alloc]initWithFrame:CGRectMake(17,  self.originY, width, 4)];
        
        backJifen.backgroundColor = [NSString colorWithHexString:@"27292b"];
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:backJifen.bounds byRoundingCorners:UIRectCornerBottomRight  | UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerTopLeft cornerRadii:CGSizeMake(2, 2)].CGPath;
        backJifen.layer.mask = shapeLayer;
        
        [ self.totalJifen addSubview:backJifen];
        
        
    }else if (self.numBerInt <[TotalDate[1] intValue]){
        
        
        UIView *backJifen1 = [[UIView alloc]initWithFrame:CGRectMake(17*WIDTHRATIO,  self.originY, 56, 4)];
        CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
        shapeLayer1.path = [UIBezierPath bezierPathWithRoundedRect:backJifen1.bounds byRoundingCorners:UIRectCornerTopLeft  | UIRectCornerBottomLeft cornerRadii:CGSizeMake(2, 2)].CGPath;
        backJifen1.layer.mask = shapeLayer1;
        
        backJifen1.backgroundColor = [NSString colorWithHexString:@"27292b"];
        [ self.totalJifen addSubview:backJifen1];
        
        CGFloat proportion  = (self.numBerInt-[TotalDate[0] floatValue])/([TotalDate[1] floatValue]-[TotalDate[0] floatValue]);
        
        CGFloat width = proportion *56;
        
        UIView *backJifen2 = [[UIView alloc]initWithFrame:CGRectMake((17+114/2)*WIDTHRATIO,  self.originY, width, 4)];
        
        backJifen2.backgroundColor = [NSString colorWithHexString:@"27292b"];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:backJifen2.bounds byRoundingCorners:UIRectCornerBottomRight  | UIRectCornerTopRight cornerRadii:CGSizeMake(2, 2)].CGPath;
        backJifen2.layer.mask = shapeLayer;
        [ self.totalJifen addSubview:backJifen2];
        
        
        
    }else if (self.numBerInt <[TotalDate[2] intValue]){
        
        for (int i = 0; i < 2; i++) {
            
            UIView *backJifen1 = [[UIView alloc]initWithFrame:CGRectMake((17+i*114/2)*WIDTHRATIO,  self.originY, 56, 4)];
            if (i == 0 ) {
                
                CAShapeLayer *shapeLayer = [CAShapeLayer layer];
                shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:backJifen1.bounds byRoundingCorners:UIRectCornerTopLeft  | UIRectCornerBottomLeft cornerRadii:CGSizeMake(2, 2)].CGPath;
                backJifen1.layer.mask = shapeLayer;
                
            }else if ( i == 5){
                CAShapeLayer *shapeLayer = [CAShapeLayer layer];
                shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:backJifen1.bounds byRoundingCorners:UIRectCornerBottomRight  | UIRectCornerTopRight cornerRadii:CGSizeMake(2, 2)].CGPath;
                backJifen1.layer.mask = shapeLayer;
                
            }
            
            backJifen1.backgroundColor = [NSString colorWithHexString:@"27292b"];
            
            [ self.totalJifen addSubview:backJifen1];
            
        }
        
        
        CGFloat proportion  = (self.numBerInt-[TotalDate[1] floatValue])/([TotalDate[2] floatValue]-[TotalDate[1] floatValue]);
        
        CGFloat width = proportion *56;
        
        UIView *backJifen2 = [[UIView alloc]initWithFrame:CGRectMake((17+2*114/2)*WIDTHRATIO,  self.originY, width, 4)];
        
        backJifen2.backgroundColor = [NSString colorWithHexString:@"27292b"];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:backJifen2.bounds byRoundingCorners:UIRectCornerBottomRight  | UIRectCornerTopRight cornerRadii:CGSizeMake(2, 2)].CGPath;
        backJifen2.layer.mask = shapeLayer;
        [ self.totalJifen addSubview:backJifen2];
        
        
        
    }else if (self.numBerInt <[TotalDate[3] intValue]){
        
        for (int i = 0; i < 3; i++) {
            
            UIView *backJifen1 = [[UIView alloc]initWithFrame:CGRectMake(17+i*114/2,  self.originY, 56, 4)];
            if (i == 0 ) {
                
                CAShapeLayer *shapeLayer = [CAShapeLayer layer];
                shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:backJifen1.bounds byRoundingCorners:UIRectCornerTopLeft  | UIRectCornerBottomLeft cornerRadii:CGSizeMake(2, 2)].CGPath;
                backJifen1.layer.mask = shapeLayer;
                
            }else if ( i == 5){
                CAShapeLayer *shapeLayer = [CAShapeLayer layer];
                shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:backJifen1.bounds byRoundingCorners:UIRectCornerBottomRight  | UIRectCornerTopRight cornerRadii:CGSizeMake(2, 2)].CGPath;
                backJifen1.layer.mask = shapeLayer;
                
            }
            
            backJifen1.backgroundColor = [NSString colorWithHexString:@"27292b"];
            
            [ self.totalJifen addSubview:backJifen1];
            
        }
        
        
        CGFloat proportion  = (self.numBerInt-[TotalDate[2] floatValue])/([TotalDate[3] floatValue]-[TotalDate[2] floatValue]);
        
        CGFloat width = proportion *56;
        
        UIView *backJifen2 = [[UIView alloc]initWithFrame:CGRectMake(17+3*114/2,  self.originY, width, 4)];
        
        backJifen2.backgroundColor = [NSString colorWithHexString:@"27292b"];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:backJifen2.bounds byRoundingCorners:UIRectCornerBottomRight  | UIRectCornerTopRight cornerRadii:CGSizeMake(2, 2)].CGPath;
        backJifen2.layer.mask = shapeLayer;
        [ self.totalJifen addSubview:backJifen2];
        
        
    }else if (self.numBerInt <[TotalDate[4] intValue]){
        
        for (int i = 0; i < 4; i++) {
            
            UIView *backJifen1 = [[UIView alloc]initWithFrame:CGRectMake(17+i*114/2,  self.originY, 56, 4)];
            if (i == 0 ) {
                
                CAShapeLayer *shapeLayer = [CAShapeLayer layer];
                shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:backJifen1.bounds byRoundingCorners:UIRectCornerTopLeft  | UIRectCornerBottomLeft cornerRadii:CGSizeMake(2, 2)].CGPath;
                backJifen1.layer.mask = shapeLayer;
                
            }else if ( i == 5){
                CAShapeLayer *shapeLayer = [CAShapeLayer layer];
                shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:backJifen1.bounds byRoundingCorners:UIRectCornerBottomRight  | UIRectCornerTopRight cornerRadii:CGSizeMake(2, 2)].CGPath;
                backJifen1.layer.mask = shapeLayer;
                
            }
            
            backJifen1.backgroundColor = [NSString colorWithHexString:@"27292b"];
            
            [ self.totalJifen addSubview:backJifen1];
            
        }
        
        
        CGFloat proportion  = (self.numBerInt-[TotalDate[3] floatValue])/([TotalDate[4] floatValue]-[TotalDate[3] floatValue]);
        
        CGFloat width = proportion *56;
        
        UIView *backJifen2 = [[UIView alloc]initWithFrame:CGRectMake(17+4*114/2,  self.originY, width, 4)];
        
        backJifen2.backgroundColor = [NSString colorWithHexString:@"27292b"];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:backJifen2.bounds byRoundingCorners:UIRectCornerBottomRight  | UIRectCornerTopRight cornerRadii:CGSizeMake(2, 2)].CGPath;
        backJifen2.layer.mask = shapeLayer;
        [ self.totalJifen addSubview:backJifen2];
        
        
    }else if (self.numBerInt <[TotalDate[5] intValue]){
        
        
        for (int i = 0; i < 5; i++) {
            
            UIView *backJifen1 = [[UIView alloc]initWithFrame:CGRectMake(17+i*114/2,  self.originY, 56, 4)];
            if (i == 0 ) {
                
                CAShapeLayer *shapeLayer = [CAShapeLayer layer];
                shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:backJifen1.bounds byRoundingCorners:UIRectCornerTopLeft  | UIRectCornerBottomLeft cornerRadii:CGSizeMake(2, 2)].CGPath;
                backJifen1.layer.mask = shapeLayer;
                
            }else if ( i == 5){
                CAShapeLayer *shapeLayer = [CAShapeLayer layer];
                shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:backJifen1.bounds byRoundingCorners:UIRectCornerBottomRight  | UIRectCornerTopRight cornerRadii:CGSizeMake(2, 2)].CGPath;
                backJifen1.layer.mask = shapeLayer;
                
            }
            
            backJifen1.backgroundColor = [NSString colorWithHexString:@"27292b"];
            
            [ self.totalJifen addSubview:backJifen1];
            
        }
        
        
        CGFloat proportion  = (self.numBerInt-[TotalDate[4] floatValue])/([TotalDate[5] floatValue]-[TotalDate[4] floatValue]);
        
        CGFloat width = proportion *56;
        
        UIView *backJifen2 = [[UIView alloc]initWithFrame:CGRectMake(17+5*114/2,  self.originY, width, 4)];
        
        backJifen2.backgroundColor = [NSString colorWithHexString:@"27292b"];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:backJifen2.bounds byRoundingCorners:UIRectCornerBottomRight  | UIRectCornerTopRight cornerRadii:CGSizeMake(2, 2)].CGPath;
        backJifen2.layer.mask = shapeLayer;
        [ self.totalJifen addSubview:backJifen2];
        
    }
    
    for (int i =0; i < 5; i++) {
        
        UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,390/2-56/2-12,100,12)];
        
        textLabel.center  = CGPointMake(17+(i+1)*113/2,390/2-56/2);
        textLabel.text = TotalDate[i];
        
        textLabel.textColor = [NSString colorWithHexString:@"27292b"];
        textLabel.font = [UIFont systemFontOfSize:12];
        textLabel.textAlignment = NSTextAlignmentCenter;
        [ self.totalJifen addSubview:textLabel];
        
    }

    
    
}

-(void)loadData{
    
    self.data = [NSMutableArray array];
    
    NSDictionary *dict = @{@"id":[USER_DEFAULT objectForKey:@"id"],@"route":@"User_userPage",@"version":@"1",@"token":[USER_DEFAULT objectForKey:@"token"]};
    
    NSDictionary *signDict = [self encryptDict:(NSMutableDictionary *)dict];
    
    [WJFCollection getWithURLString:@"http://www.rempeach.com/rebirth/api/AppApi/receive" parameters:signDict success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        
        [self.touXiangImage sd_setImageWithURL:[NSURL URLWithString:responseObject[@"data"][@"head_img"]] placeholderImage:nil];
        
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"当前消费额：%.0f",[responseObject[@"data"][@"total_cost"] floatValue]/100]];
        
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:[NSString colorWithHexString:@"27292b"]
                        range:NSMakeRange(0, 6)];
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:[NSString colorWithHexString:@"e4c675"]
                        range:NSMakeRange(6, attrStr.length-6)];
        self.consumptionLabel.attributedText = attrStr;
        
        self.numBerInt = [responseObject[@"data"][@"total_cost"] floatValue]/100;
        [self loadProgress];
        
        if ([responseObject[@"data"][@"user_level"] isEqualToString:@"0"]) {
            
            self.gradeImage.image = [UIImage imageNamed:@"vip_round_1"];
            
        }else if ([responseObject[@"data"][@"user_level"] isEqualToString:@"1"]){
            
            self.gradeImage.image = [UIImage imageNamed:@"vip_round_2"];
            
        }else if ([responseObject[@"data"][@"user_level"] isEqualToString:@"2"]){
            
            
            self.gradeImage.image = [UIImage imageNamed:@"vip_round_3"];
        }else if ([responseObject[@"data"][@"user_level"] isEqualToString:@"3"]){
            
            self.gradeImage.image = [UIImage imageNamed:@"vip_round_4"];
            
        }else if ([responseObject[@"data"][@"user_level"] isEqualToString:@"4"]){
            
            self.gradeImage.image = [UIImage imageNamed:@"vip_round_5"];
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    

}

-(void)loadGradePrerogativeTab{
    
    self.gradePrerogativeTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+390/2+8, WIDTH,HEIGHT-64-390/2-8) style:UITableViewStylePlain];
    
    self.gradePrerogativeTab.dataSource = self;
    
    self.gradePrerogativeTab.delegate = self;
    
    self.gradePrerogativeTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.gradePrerogativeTab];
    
}

#pragma mark UITableView协议
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.data  = [NSMutableArray array];
    NSRange range;
    if(indexPath.row == 0){
       range = NSMakeRange(0, 1);
       
    }else if (indexPath.row == 1){
       range = NSMakeRange(0, 3);
    
    }else if (indexPath.row == 2){
       range = NSMakeRange(0, 3);
        
    }else if (indexPath.row == 3){
       range = NSMakeRange(0, 4);
        
    }else if (indexPath.row == 4){
       range = NSMakeRange(0, 5);
        
    }
   
    NSArray *array =[TotalArr subarrayWithRange:range];
    self.data =  [NSMutableArray arrayWithArray:array];
    if(indexPath.row == 1){
        
        [self.data  replaceObjectAtIndex:2 withObject:@"生日当天预定套餐赠送哈根达斯蛋糕劵"];
    }
    GradePrerogativeCell * cell = [[GradePrerogativeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GradePrerogativeCell" withGradePrerogativeData:self.data];
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GradePrerogativeCell *cell = [self tableView:self.gradePrerogativeTab cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 5;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]init];
    
    view.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *label1 = [[UILabel alloc]init];
    
    [view addSubview:label1];
    
    label1.text = @"等级";
    
    
    
    label1.textColor = [NSString colorWithHexString:@"6d7278"];
    
    label1.font = [UIFont systemFontOfSize:14];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(view.mas_left).with.offset(20);
        
        make.top.equalTo(view.mas_top).with.offset(12);
        
        make.bottom.equalTo(view.mas_bottom).with.offset(-12);
    }];
    
    [label1 sizeToFit];
    
    UILabel *label2 = [[UILabel alloc]init];
    
    [view addSubview:label2];
    
    label2.text = @"特权";
    
    label2.textColor = [NSString colorWithHexString:@"6d7278"];
    
    label2.font = [UIFont systemFontOfSize:14];
    label2.textAlignment = NSTextAlignmentCenter;
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(label1.mas_right).with.offset(60);
        
        make.top.equalTo(view.mas_top).with.offset(12);
        
        make.bottom.equalTo(view.mas_bottom).with.offset(-12);
    }];

    
    UILabel *henxian = [[UILabel alloc]init];
    
    henxian.backgroundColor = [NSString colorWithHexString:@"27292b"];
    
    [view addSubview:henxian];
    [henxian mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(view.mas_left).with.offset(0);
        
        make.bottom.equalTo(view.mas_bottom).with.offset(-0.5);
        
        make.height.mas_equalTo(0.5);
        
        make.width.mas_equalTo(WIDTH);
    }];
    
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
