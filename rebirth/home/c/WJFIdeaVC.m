//
//  WJFIdeaVC.m
//  rebirth
//
//  Created by boom on 16/8/16.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "WJFIdeaVC.h"
#import "UIPlaceHolderTextView.h"
#import "HSLoginViewController.h"
@interface WJFIdeaVC ()<UITextViewDelegate>
{
    UIPlaceHolderTextView *textView;
    UILabel *shengyulabel;
}


@property(nonatomic,strong)UITextView *ideaTextView;

@property(nonatomic,strong)UIButton  *tijiaoBTU;

@end

@implementation WJFIdeaVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    
    [self.leftBtu setImage:[UIImage imageNamed:@"back_arrow@2x"] forState:UIControlStateNormal];
   
     self.menuView.text = @"意见反馈";
    
     [self createEvaluate];
    
    // Do any additional setup after loading the view.
}

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


-(void)postUserAdvise{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userid = [defaults stringForKey:@"id"];
    NSString *token =  [defaults stringForKey:@"token"];
   
    NSDictionary *strDict =@{@"id":userid,@"token":token,@"idea":textView.text};
    
    NSDictionary *para = [self encryptDict:(NSMutableDictionary *)strDict];
   
    [WJFCollection postWithUrlString:[NSString stringWithFormat:@"%@/api/user/feedback",ROOTURL] Parameter:para success:^(id responseObject) {
      
        NSLog(@"%@",responseObject);
        if ([responseObject[@"state"] isEqualToString:@"210"]) {
            
            NSLog(@"%@",responseObject[@"message"]);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:responseObject[@"message"] preferredStyle:UIAlertControllerStyleAlert];
            
            [textView resignFirstResponder];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                
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

                
                
            }];
            
            [alert addAction:ok];//添加按钮
            //以modal的形式
            [self presentViewController:alert animated:YES completion:^{ }];
            
        }else if ([responseObject[@"state"] isEqualToString:@"200"]) {
            NSLog(@"%@",responseObject[@"message"]);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:responseObject[@"message"] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                
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

                
            }];
            
            [alert addAction:ok];//添加按钮
           
            //以modal的形式
            [self presentViewController:alert animated:YES completion:^{ }];
            
        }else if ([responseObject[@"state"] isEqualToString:@"111"]) {
            
            
            
        }else if ([responseObject[@"state"] isEqualToString:@"101"]) {
            
            
            
        }else if ([responseObject[@"state"] isEqualToString:@"121"]) {
            
            
            
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
    
}
-(void)createEvaluate{
    
   
    
    //[self.view addSubview:evaluateview];
    
    textView = [[UIPlaceHolderTextView alloc]initWithFrame:CGRectMake(0,12+NAV_BAR_HEIGHT, WIDTH,200)];
    textView.delegate = self;
    textView.backgroundColor = [UIColor whiteColor];
    textView.placeholder = @"请输入需要反馈的意见或建议...";
    textView.placeholderColor = [NSString colorWithHexString:@"#6d7278"];
    textView.font = [UIFont systemFontOfSize:14];
    textView.textColor = [NSString colorWithHexString:@"949494"];
    [self.view addSubview:textView];
    
    
    shengyulabel = [[UILabel alloc]init];
    shengyulabel.font = [UIFont systemFontOfSize:16];
    
    shengyulabel.textColor = [NSString colorWithHexString:@"#6d7278"];
    
    
    [self.view addSubview:shengyulabel];
    
    [shengyulabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(textView.mas_bottom).with.offset(-12);
        
        make.right.equalTo(textView.mas_right).with.offset(-12);
        
        make.height.mas_equalTo(16);
        
        
    }];
    
    
    UIButton *sureBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtu.frame = CGRectMake((WIDTH-320)/2,textView.frame.origin.y+textView.frame.size.height+40,320, 40);
    sureBtu.layer.masksToBounds = YES;
    sureBtu.layer.cornerRadius = 3;
    sureBtu.backgroundColor = [NSString colorWithHexString:@"#27292b"];
    
    [sureBtu setTitle:@"提交" forState:UIControlStateNormal];
    [sureBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtu addTarget:self action:@selector(sureBtu:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:sureBtu];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    NSLog(@"%lu",(unsigned long)range.location);
    if (range.location>400)
    {
        //控制输入文本的长度
        return  NO;
    }
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    shengyulabel.text = [NSString stringWithFormat:@"%lu",400-range.location];
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    
    BOOL contains1 = CGRectContainsPoint(textView.frame,point);
    
    if (!contains1) {
        
        if (textView.text.length == 0) {
            shengyulabel.text = @"";
        }
        [textView resignFirstResponder];
    }

    
    
}




#pragma mark  提交
-(void)sureBtu:(UIButton *)btu{
    
    NSLog(@"提交");
    [self postUserAdvise];
    
    
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
