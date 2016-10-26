//
//  JudgeViewVC.m
//  rebirth
//
//  Created by boom on 16/8/30.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "JudgeViewVC.h"
#import "HCSStarRatingView.h"
#import "UIPlaceHolderTextView.h"
@interface JudgeViewVC ()<UITextViewDelegate>

@property(nonatomic,strong)UIPlaceHolderTextView *tf;

@property(nonatomic,strong)HCSStarRatingView *starRatingView;

@property(nonatomic,strong)UIButton *Judgebtu;

@end

@implementation JudgeViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.leftBtu setImage:[UIImage imageNamed:@"back_arrow@2x"] forState:UIControlStateNormal];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.menuView.text = @"评价行程";
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, WIDTH, 1)];
    label.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    [self.view addSubview:label];
    
   
    [self createJudgeView];
    
  
    // Do any additional setup after loading the view.
}


-(void)backClick:(UIButton *)btu{
    
    if (self.starRatingView.value == 0 || self.tf.text.length == 0) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }else{
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"您尚未完成评价,确认离开吗?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            
        }];
        
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            NSLog(@"取消");
            
        }];
        
        [alert addAction:ok];//添加按钮
        [alert addAction:cancel];//添加按钮
        //以modal的形式
        [self presentViewController:alert animated:YES completion:^{ }];

    }
    
    
}

-(void)createJudgeView{
    
    
    self.starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(95/2,72/2, WIDTH-95,68/2)];
    
    self.starRatingView.maximumValue = 5;
    self.starRatingView.minimumValue = 0;
    self.starRatingView.value = 0;
    //starRatingView.tintColor = [UIColor grayColor];
    
    self.starRatingView.emptyStarImage = [UIImage imageNamed:@"star_0@2x"];
    
    self.starRatingView.filledStarImage = [UIImage imageNamed:@"star_1@2x"];
    
    [self.starRatingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.starRatingView];
    
    [self.starRatingView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.view.mas_left).with.offset(95/2);
        
        make.right.equalTo(self.view.mas_right).with.offset(-95/2);
        
        make.top.equalTo(self.view.mas_top).with.offset(72/2+NAV_BAR_HEIGHT+1);
        
        make.height.mas_equalTo(68/2);
        
    }];

    
    
    self.tf = [[UIPlaceHolderTextView alloc]initWithFrame:CGRectMake(12, 0,702/2, 320/2)];
    
    self.tf.placeholder = @"我对本次行程感到很满意!";
    
    self.tf.font = [UIFont systemFontOfSize:15];
    
    self.tf.textColor = [NSString colorWithHexString:@"#6d7278"];
    
    self.tf.layer.masksToBounds = YES;
    
    self.tf.delegate = self;
    
    self.tf.layer.borderWidth = 0.5;
    
    [self.view addSubview:self.tf];
    
    [self.tf mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
         make.left.equalTo(self.view.mas_left).with.offset(12);
        
         make.right.equalTo(self.view.mas_right).with.offset(-12);
        
         make.top.equalTo(self.starRatingView.mas_bottom).with.offset(72/2);
        
         make.height.mas_equalTo(320/2);
    }];
    
    
    self.Judgebtu =[UIButton buttonWithType:UIButtonTypeCustom];
    
    self.Judgebtu.layer.masksToBounds = YES;
    
    self.Judgebtu.layer.cornerRadius = 3;
    
    self.Judgebtu.backgroundColor = [NSString colorWithHexString:@"838a92"];
    
    [self.Judgebtu setTitle:@"提交评价" forState:UIControlStateNormal];
    
    [self.Judgebtu setTitleColor:[NSString colorWithHexString:@"#fefefe"] forState:UIControlStateNormal];
    
    [self.Judgebtu addTarget:self action:@selector(Judgebtu:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.Judgebtu];
    
    [self.Judgebtu mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.view.mas_left).with.offset((WIDTH-702/2)/2);
        
        make.right.equalTo(self.view.mas_right).with.offset(-12);
        
        make.top.equalTo(self.tf.mas_bottom).with.offset(40);
        
        make.height.mas_equalTo(96/2);
    }];
    
    
}

-(void)Judgebtu:(UIButton *)btu{
    
    NSDictionary * dict = @{@"id":[NSString stringWithFormat:@"%@",[USER_DEFAULT objectForKey:@"id"]],@"content":self.tf.text,@"score":[NSString stringWithFormat:@"%f",self.starRatingView.value],@"token":[NSString stringWithFormat:@"%@",[USER_DEFAULT objectForKey:@"token"]],@"oid":self.oid};
    
    NSDictionary *para =  [self encryptDict:(NSMutableDictionary *)dict];
    
    [WJFCollection postWithUrlString:[NSString stringWithFormat:@"%@/api/order/setItemScore",ROOTURL] Parameter:para success:^(id responseObject) {
        
        NSLog(@"%@===%@",responseObject,responseObject[@"message"]);
        if ([responseObject[@"state"] isEqualToString:@"200"]) {
            
            [Common tipAlert:@"评价成功"];
            
        }else if ([responseObject[@"state"] isEqualToString:@"111"]){
            
             [Common tipAlert:@"您已经评价过该订单,无需再次评价!"];
            
        }else if ([responseObject[@"state"] isEqualToString:@"210"]){
            
            [Common tipAlert:@"评价成功"];
            
        }
        
    } failure:^(NSError *error) {
        
        
        NSLog(@"%@",error);
        
    }];
    
}



-(void)didChangeValue:(HCSStarRatingView *)view{
    
    
    self.Judgebtu.backgroundColor = [UIColor blackColor];
    
    if (view.value == 1) {
      
        self.tf.text= @"我对本次行程感到很失望!";
        
    }else if (view.value == 2){
        
        self.tf.text= @"我对本次行程感到不满意!";
        
    }else if (view.value == 3){
        
          self.tf.text= @"我对本次行程感到一般!";
    }else if (view.value == 4){
        
          self.tf.text= @"我对本次行程感到很满意!";
        
    }else if (view.value == 5){
        
          self.tf.text= @"我对本次行程感到超级赞!";
    }
    
}

static int lastRangLocation = 0;

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if (range.location >= lastRangLocation) {
        
        self.Judgebtu.backgroundColor = [UIColor blackColor];
        
    }else{
        
        self.Judgebtu.backgroundColor = [NSString colorWithHexString:@"838a92"];
    }
    
    lastRangLocation = (int)range.location;
    NSLog(@"%lu",(unsigned long)range.location);
//    if (range.location>400)
//    {
//        //控制输入文本的长度
//        return  NO;
//    }
//    if ([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//        return NO;
//    }
    
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    
    BOOL contains1 = CGRectContainsPoint(self.tf.frame,point);
    
    if (!contains1) {
        
        if (self.tf.text.length == 0) {
            //shengyulabel.text = @"";
        }
        [self.tf resignFirstResponder];
    }
    
    
    
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
