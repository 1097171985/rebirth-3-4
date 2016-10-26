//
//  HSbianjiGRZLViewController.m
//  rebirth
//
//  Created by 侯帅 on 16/10/8.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSbianjiGRZLViewController.h"
#import "DownList.h"
#import "TOCropViewController.h"
@interface HSbianjiGRZLViewController ()<DownlistDelegate,TOCropViewControllerDelegate>
@property (nonatomic, strong) UIImage *image;           // The image we'll be cropping
@property (nonatomic, strong) UIImageView *imageView;   // The image view to present the cropped image

@property (nonatomic, assign) TOCropViewCroppingStyle croppingStyle; //The cropping style
@property (nonatomic, assign) CGRect croppedFrame;
@property (nonatomic, assign) NSInteger angle;

@end

@implementation HSbianjiGRZLViewController
{
    UITextField *nameText;
    UITextField *xingbieText;
    DownList *downlist;
    NSString *men;
    UIButton *xingbiebtn;
    NSString *sstr;
    UIImageView *img;
    NSString *namestr;
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [nameText resignFirstResponder];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self httptouxiang];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    [self creatNavi];
    [self creatView];
    
    
}

-(void)httptouxiang{
    /*112 获取用户信息
     URL：http://www.rempeach.com/rebirth/api/user/get_userInfo
     接口描述：获取用户信息
     请求方式：GET
     上传参数：
     
     返回参数：state ：200 111 101 121 状态码（见附录）
     */
    NSString *transformId = [USER_DEFAULT objectForKey:@"id"];
    NSString *round = @"12345";
    NSString *token = [USER_DEFAULT objectForKey:@"token"];
    NSArray *nameList = @[@"id",vn(round),vn(token)];
    
    NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(transformId),sv(round),sv(token),nil];
    NSLog(@"%@",parameters1);
    NSString *str = sv(transformId);
    [YkxHttptools get:@"http://www.rempeach.com/rebirth/api/user/get_userInfo" params:parameters1 success:^(id responseObj) {
        NSString *finishStr = [[NSString alloc]initWithData:responseObj encoding:NSUTF8StringEncoding];
        finishStr = [YkxHttptools repTabStr:finishStr];
        NSDictionary *paramDic = [[[SBJsonParser alloc]init] objectWithString:finishStr];
        NSLog(@"%@",paramDic);
        if ([[paramDic objectForKey:@"state"] isEqualToString:@"200"]) {
            NSDictionary *dic = [paramDic objectForKey:@"data"];
            sstr= [dic objectForKey:@"head_img"];
            namestr = [dic objectForKey:@"nick"];
            nameText.text = namestr;
            [img sd_setImageWithURL:[NSString stringWithFormat:@"%@",sstr] placeholderImage:[UIImage imageNamed:@"headImg"]];
            
            
            
         
                
            }
    } failure:^(NSError *error) {
        
    }];
    
}




-(void)httpXGGRZL{
    
    /*111 修改用户信息
     URL：http://www.rempeach.com/rebirth/api/user/edit_userInfo
     接口描述：修改用户信息
     请求方式：POST
     上传参数：
     id
     nick
     sex
     token
     sign
     
     
     
     吴佳峰
     返回参数：state ：200 111 101 121 态码（见附录）
     a b c d e f g h i j k l m n o p q r s t u v w x y z
*/
    NSString *transformId=[USER_DEFAULT objectForKey:@"id"];
    NSString *nick = nameText.text;
    NSString *sex = men;
    NSString *token=[USER_DEFAULT objectForKey:@"token"];
    
    NSArray *nameList = @[@"id",vn(nick),vn(sex),vn(token)];
    NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(transformId),sv(nick),sv(sex),sv(token),nil];
    NSLog(@"%@",parameters1);
    NSString *str = sv(transformId);
    [YkxHttptools post:@"http://www.rempeach.com/rebirth/api/user/edit_userInfo" params:parameters1 success:^(id responseObj) {
        if ([[responseObj objectForKey:@"state"] isEqualToString:@"210"]) {
            [Common tipAlert:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
        }
        
    } failure:^(NSError *error) {
        
    }];
}
-(void)creatView{
    UIView *firstView = [[UIView alloc] init];
    firstView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:firstView];
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NAV_BAR_HEIGHT+12);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@64);
    }];

    img = [[UIImageView alloc] init];
    img.frame = CGRectMake(kScreenWidth-50, 15, 40, 40);
    [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",sstr]] placeholderImage:[UIImage imageNamed:@"headImg"]];
   // img.image = [UIImage imageNamed:@"headImg"];
    img.layer.cornerRadius = 20;
    img.layer.masksToBounds = YES;
    img.userInteractionEnabled = YES;
    [firstView addSubview:img];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    [firstView addGestureRecognizer:tap];
    UILabel *tislabel = [[UILabel alloc] init];
    tislabel.frame =CGRectMake(12, 56/2, kScreenWidth/2, 16);
    tislabel.text = @"更换头像";
    tislabel.textColor = [NSString colorWithHexString:@"27292b"];
    tislabel.textAlignment = NSTextAlignmentLeft;
    tislabel.font = [UIFont systemFontOfSize:16];
    [firstView addSubview:tislabel];
    
    UIView *secondView = [[UIView alloc] init];
    secondView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:secondView];
    [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstView.mas_bottom).offset(12);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@48);
    }];
    UILabel *namelabel = [[UILabel alloc] init];
    namelabel.frame =CGRectMake(12, 16, kScreenWidth/2, 16);
    namelabel.font = [UIFont systemFontOfSize:16];
    namelabel.textAlignment = NSTextAlignmentLeft;
    namelabel.textColor = [NSString colorWithHexString:@"27292b"];
    namelabel.text = @"昵称";
    [secondView addSubview:namelabel];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    line.frame =CGRectMake(0, 47.5, kScreenWidth, 0.5);
    [secondView addSubview:line];
    
//    UILabel *namee = [[UILabel alloc] init];
//    namee.frame =CGRectMake(kScreenWidth/2, 20, kScreenWidth/2-12, 16);
//    namee.textColor = [NSString colorWithHexString:@"6d7278"];
//    namee.text = @"鸡巴";
//    namee.textAlignment = NSTextAlignmentRight;
//    namee.font = [UIFont systemFontOfSize:16];
//    [secondView addSubview:namee];
    nameText = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth/2, 16, kScreenWidth/2-12, 16)];
    nameText.placeholder = @"昵称";
    nameText.text = namestr;
    nameText.textAlignment = NSTextAlignmentRight;
    nameText.font = [UIFont systemFontOfSize:16];
    nameText.textColor = [NSString colorWithHexString:@"6d7278"];
    [secondView addSubview:nameText];
    
    
    UIView *thirdView = [[UIView alloc] init];
    thirdView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:thirdView];
    [thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(secondView.mas_bottom).offset(0.5);
        make.height.equalTo(secondView);
        
    }];
   //    UILabel  *xingbiee = [[UILabel alloc] init];
//    xingbiee.frame =CGRectMake(kScreenWidth/2, 20, kScreenWidth/2-12, 16);
//    xingbiee.font = [UIFont systemFontOfSize:16];
//    xingbiee.textAlignment = NSTextAlignmentRight;
//    xingbiee.textColor = [NSString colorWithHexString:@"6d7278"];
//    xingbiee.text = @"男";
//    [thirdView addSubview:xingbiee];
//    nameText = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth/2, 20, kScreenWidth/2-12, 16)];
//    nameText.placeholder = @"性别";
//    nameText.textAlignment = NSTextAlignmentRight;
//    nameText.font = [UIFont systemFontOfSize:16];
//    nameText.textColor = [NSString colorWithHexString:@"6d7278"];
//    [thirdView addSubview:nameText];
    
    //    baseView.userInteractionEnabled = YES;
    
   
//    NSArray *arr = [[NSArray alloc] initWithObjects:@"男",@"女", nil];
//    downlist = [[DownList alloc] initWithFrame:CGRectMake(kScreenWidth/2, 20, kScreenWidth/2-50, 25) Nsarry:arr Delegate:self AndIdenty:@"性别"];
//    
//    downlist.baseView = thirdView;
//     [thirdView addSubview:downlist];
    
    
   
    UILabel *xingbielabel = [[UILabel alloc] init];
    xingbielabel.frame =CGRectMake(12, 16, kScreenWidth/2, 16);
    xingbielabel.text = @"性别";
    xingbielabel.textAlignment = NSTextAlignmentLeft;
    xingbielabel.textColor = [NSString colorWithHexString:@"27292b"];
    xingbielabel.font = [UIFont systemFontOfSize:16];
    [thirdView addSubview:xingbielabel];

   xingbiebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    xingbiebtn.frame =CGRectMake(kScreenWidth-60, 10, 50, 26);
    [xingbiebtn setTitle:@"请选择" forState:UIControlStateNormal];
    [xingbiebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    xingbiebtn.titleLabel.font = [UIFont systemFontOfSize:14];
   // xingbiebtn.backgroundColor = [UIColor redColor];
    xingbiebtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [thirdView addSubview:xingbiebtn];
    [xingbiebtn addTarget:self action:@selector(click_bnt:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)click_bnt:(UIButton *)sender{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        men = @"2";
        [xingbiebtn setTitle:@"女" forState:UIControlStateNormal];
        
        
        
    }];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
       men = @"1";
        [xingbiebtn setTitle:@"男" forState:UIControlStateNormal];
        
        
        
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)click:(UITapGestureRecognizer *)sender{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSMutableString *userid = [user objectForKey:@"id"];
    
    if (!userid) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"您需要登录,请先登录" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
            NSLog(@"确定");
            HSLoginViewController *login = [[HSLoginViewController alloc]init];
            login.source = @"ItineraryVC";
            
            [UIView transitionWithView: self.navigationController.view
                              duration: 0.35f
                               options: nil
                            animations: ^(void)
             {
                 
                 CATransition *transition = [CATransition animation];
                 transition.type = kCATransitionPush;
                 transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                 transition.fillMode = kCAFillModeForwards;
                 transition.duration = 0.6;
                 transition.subtype = kCATransitionFromBottom;
                 [[self.navigationController.view layer] addAnimation:transition forKey:@"NavigationControllerAnimationKey"];
                 
             }completion: ^(BOOL isFinished)
             {
                 /* TODO: Whatever you want here */
                 [self.navigationController.view.layer removeAnimationForKey:@"NavigationControllerAnimationKey"];
                 
             }];
            
            [self.navigationController pushViewController:login animated:NO];
            
            
            
        }];
        
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            NSLog(@"取消");
            
        }];
        
        [alert addAction:ok];//添加按钮
        [alert addAction:cancel];//添加按钮
        //以modal的形式
        [self presentViewController:alert animated:YES completion:^{ }];
        
        
    }else{
        
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSLog(@"确定");
            if (TARGET_IPHONE_SIMULATOR) {
                [Common tipAlert:@"模拟器无拍照功能"];
            }else{
                
                
                if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
                // 2. 创建图片选择控制器
                UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
                /**
                 typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
                 UIImagePickerControllerSourceTypePhotoLibrary, // 相册
                 UIImagePickerControllerSourceTypeCamera, // 用相机拍摄获取
                 UIImagePickerControllerSourceTypeSavedPhotosAlbum // 相簿
                 }
                 */
                // 3. 设置打开照片相册类型(显示所有相簿)
                ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
                // ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                // 照相机
                // ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
                // 4.设置代理
                ipc.delegate = self;
                // 5.modal出这个控制器
                [self presentViewController:ipc animated:YES completion:nil];
                
                
            }
            
            
        }];
        UIAlertAction *cancel1 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSLog(@"取消");
            NSLog(@"确定");
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
            // 2. 创建图片选择控制器
            UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
            /**
             typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
             UIImagePickerControllerSourceTypePhotoLibrary, // 相册
             UIImagePickerControllerSourceTypeCamera, // 用相机拍摄获取
             UIImagePickerControllerSourceTypeSavedPhotosAlbum // 相簿
             }
             */
            // 3. 设置打开照片相册类型(显示所有相簿)
            ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            // ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            // 照相机
            // ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
            // 4.设置代理
            ipc.delegate = self;
            // 5.modal出这个控制器
            [self presentViewController:ipc animated:YES completion:nil];
            
            
            
            
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            NSLog(@"取消");
            
        }];
        
        [alert addAction:ok];//添加按钮
        [alert addAction:cancel1];
        [alert addAction:cancel];//添加按钮
        //以modal的形式
        [self presentViewController:alert animated:YES completion:^{ }];
    }
    
                                   }
-(void)creatNavi{
    UIView *navi = [[UIView alloc] init];
    navi.frame =CGRectMake(0, 0,kScreenWidth , NAV_BAR_HEIGHT);
    navi.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navi];
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(50, kStatusBarHeight, kScreenWidth-100, NAV_BAR_HEIGHT-kStatusBarHeight)];
    titleLbl.textColor = [NSString colorWithHexString:heitizi];
    titleLbl.text = @"编辑资料";
    titleLbl.font = [UIFont systemFontOfSize:16];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    [navi addSubview:titleLbl];
    UIView *line = [[UIView alloc] init];
    line.frame =CGRectMake(0, NAV_BAR_HEIGHT-1, kScreenWidth, 0.5);
    line.backgroundColor = [UIColor grayColor];
    [navi addSubview:line];
    UIButton *backBtn=  [YkxHttptools initwithButton:[UIColor clearColor] Frame:CGRectMake(0, kStatusBarHeight, 50, NAV_BAR_HEIGHT-kStatusBarHeight) Image:[UIImage imageNamed:@"back_arrow@2x"] Title:nil Titlecolor:[NSString colorWithHexString:heitizi ] Titlefont:[UIFont systemFontOfSize:14] BaseView:navi];
    
    [backBtn addTarget:self action:@selector(click_back:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)click_back:(UIButton *)sender{
    if ([men isEqualToString:@""]&&nameText.text.length==0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
         [self httpXGGRZL];
    }
   
    
}


#pragma mark - Image Picker Delegate -
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    TOCropViewController *cropController = [[TOCropViewController alloc] initWithCroppingStyle:TOCropViewCroppingStyleCircular image:image];
    cropController.delegate = self;
    
    [picker pushViewController:cropController animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Cropper Delegate -
- (void)cropViewController:(TOCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle
{
    self.croppedFrame = cropRect;
    self.angle = angle;
    [self updateImageViewWithImage:image fromCropViewController:cropViewController];
}

- (void)cropViewController:(TOCropViewController *)cropViewController didCropToCircularImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle
{
    self.croppedFrame = cropRect;
    self.angle = angle;
    [self updateImageViewWithImage:image fromCropViewController:cropViewController];
}

- (void)updateImageViewWithImage:(UIImage *)image fromCropViewController:(TOCropViewController *)cropViewController
{
    NSLog(@"%@",image);
    self.image = image;
    
    [cropViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
    
    [self saveImage:[self scaleImage:image scaleFactor:0.3] withName:@"image.png"];
    
    
    
}
CGFloat    scaleFloat = 0.6;
-(UIImage *) scaleImage: (UIImage *)image scaleFactor:(float)scaleFloat
{
    CGSize size = CGSizeMake(image.size.width * 0.6, image.size.height * 0.6);
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    transform = CGAffineTransformScale(transform, 0.6, 0.6);
    CGContextConcatCTM(context, transform);
    
    // Draw the image into the transformed context and return the image
    [image drawAtPoint:CGPointMake(0.0f, 0.0f)];
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimg;
}

#pragma mark - 保存图片至沙盒
- (void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.00001);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
    
    [USER_DEFAULT setObject:@"fullPath" forKey:@"fullPath"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:fullPath];
    // NSData *data = UIImagePNGRepresentation(img);
    
    NSData *hightImageData= UIImageJPEGRepresentation(img, .2);
    
    NSString *hightImageName =[NSString stringWithFormat:@"image"];
    
    NSString *hightImageFileName =[NSString stringWithFormat:@"image.png"];
    NSString *transformId = [USER_DEFAULT objectForKey:@"id"];
    NSString *round = @"12345";
    NSString *token = [USER_DEFAULT objectForKey:@"token"];
    NSArray *nameList = @[@"id",vn(round),vn(token)];
    
    NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(transformId),sv(round),sv(token),nil];
    NSLog(@"%@",parameters1);
    NSString *str = sv(transformId);
    
    [manager POST:postIconIMG parameters:parameters1 constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //[formData appendPartWithFormData:data name:@"img"];r
        [formData appendPartWithFileData:hightImageData
                                    name:hightImageName
                                fileName:hightImageFileName
                                mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"进度:%f",uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([[json objectForKey:@"state"] isEqualToString:@"200"]) {
            
            NSDictionary *dic = [json objectForKey:@"data"];
           // leftmenu.arrow.image = img;
            [self httptouxiang];
            
        }else if ([[json objectForKey:@"state"] isEqualToString:@"111"]){
            
            
            
        }else if ([[json objectForKey:@"state"] isEqualToString:@"101"]){
            
        }else{
            
        }
        
        
        
    }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"上传错误%@",error);
          }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self httptouxiang];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
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
