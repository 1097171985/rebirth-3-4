//
//  HSUploadJiazhaoViewController.m
//  rebirth
//
//  Created by 侯帅 on 16/7/23.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSUploadJiazhaoViewController.h"
#import "UploadParam.h"
#import "HYBNetworking.h"
#import "HSBindingJiazhaoViewController.h"
@interface HSUploadJiazhaoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,MBProgressHUDDelegate>

@property(nonatomic,strong)UIImageView *dirveimg;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)UIImage *img ;
@end

@implementation HSUploadJiazhaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatNavi];
    [self creatView];
    UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backpreviousClick:)];
    rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGestureRecognizer];
    
    //[self gainHttpTime];
    // Do any additional setup after loading the view.
}
-(void)backpreviousClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)creatNavi{
    UIView *navi = [[UIView alloc] init];
    navi.frame =CGRectMake(0, 0,kScreenWidth , NAV_BAR_HEIGHT);
    navi.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navi];
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(50, kStatusBarHeight, kScreenWidth-100, NAV_BAR_HEIGHT-kStatusBarHeight)];
    titleLbl.textColor = [NSString colorWithHexString:heitizi];
    titleLbl.text = @"上传驾驶证";
    titleLbl.font = [UIFont systemFontOfSize:16];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    [navi addSubview:titleLbl];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    [navi addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(NAV_BAR_HEIGHT-1);
        make.height.equalTo(@0.5);
        
    }];
    UIButton *backBtn=  [YkxHttptools initwithButton:[UIColor clearColor] Frame:CGRectMake(0, kStatusBarHeight, 50, NAV_BAR_HEIGHT-kStatusBarHeight) Image:[UIImage imageNamed:@"back_arrow@2x"] Title:nil Titlecolor:[NSString colorWithHexString:heitizi ] Titlefont:[UIFont systemFontOfSize:14] BaseView:navi];
    [backBtn addTarget:self action:@selector(click_back:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)creatView{
    self.dirveimg = [[UIImageView alloc] init];
    self.dirveimg.image = [UIImage imageNamed:@"driving_licence@2x"];
    [self.view addSubview:self.dirveimg];
    [self.dirveimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(174/2);
        make.right.equalTo(self.view).offset(-174/2);
        make.top.mas_equalTo(self.view).offset(NAV_BAR_HEIGHT+100);
        make.height.equalTo(@124);
    }];
    
    UILabel *lbl = [[UILabel alloc] init];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.text = @"请横向拍摄正面";
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textColor = [NSString colorWithHexString:@"#6d7278"];
    lbl.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:lbl];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.dirveimg.mas_bottom).offset(8);
        make.height.equalTo(@14);
    }];
    
    
    UILabel *lbl1 = [[UILabel alloc] init];
    lbl1.textAlignment = NSTextAlignmentCenter;
    lbl1.text = @"照片上不要有阴影和反光";
    lbl1.backgroundColor = [UIColor clearColor];
    lbl1.textColor = [NSString colorWithHexString:@"#6d7278"];
    lbl1.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:lbl1];
    [lbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbl);
        make.top.equalTo(lbl.mas_bottom).offset(8);
        make.height.equalTo(@14);
        
        
    }];
    
    UIButton *uploadbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [uploadbtn setBackgroundColor:[NSString colorWithHexString:heitizi]];
    [uploadbtn setTitle:@"上传本人驾驶证照片(正本)" forState:UIControlStateNormal];
    [uploadbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    uploadbtn.titleLabel.textAlignment = NSTextAlignmentCenter;

    [self.view addSubview:uploadbtn];
    [uploadbtn addTarget:self action:@selector(click_upjiazhao:) forControlEvents:UIControlEventTouchUpInside];
    [uploadbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(94/2);
        make.right.equalTo(self.view).offset(-94/2);
        make.top.equalTo(lbl1).offset(120);
        make.height.equalTo(@48);
    }];
    uploadbtn.layer.cornerRadius = 3;
    
    UIImageView *tubiaoiMG = [[UIImageView alloc] init];
    tubiaoiMG.image = [UIImage imageNamed:@"lock@2x"];
    [self.view addSubview:tubiaoiMG];
    [tubiaoiMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(90);
        make.width.height.equalTo(@14);
        make.top.equalTo(uploadbtn.mas_bottom).offset(8);
    }];
    UILabel *tipLbl = [[UILabel alloc] init];
    tipLbl.text = @"您的隐私信息仅用于验证";
    tipLbl.textAlignment=NSTextAlignmentLeft;
    tipLbl.textColor = [NSString colorWithHexString:@"#6d7278"];
    tipLbl.font = [UIFont systemFontOfSize:14];
    
    [self.view addSubview:tipLbl];
    [tipLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tubiaoiMG).offset(17);
        make.right.equalTo(@40);
        make.top.equalTo(uploadbtn.mas_bottom).offset(8);
        make.height.equalTo(@14);
    }];
    
    
    UILabel *phoneNumLbl = [[UILabel alloc] init];
    phoneNumLbl.textColor = [NSString colorWithHexString:@"#27292b"];
    phoneNumLbl.text = @"联系我们 400-668-0202";
    phoneNumLbl.textAlignment = NSTextAlignmentCenter;
    phoneNumLbl.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:phoneNumLbl];
    [phoneNumLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-35);
        make.height.equalTo(@12);
    }];
    
    

}
-(void)click_upjiazhao:(UIButton *)sender{
   
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    //
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (TARGET_IPHONE_SIMULATOR) {
            [Common tipAlert:@"模拟器无拍摄视频功能"];
        }else{
            // 照相机
            
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
            ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            
            // 4.设置代理
            ipc.delegate = self;
            // 5.modal出这个控制器
            [self presentViewController:ipc animated:YES completion:nil];
            NSLog(@"下一步");
            
            
            
            
        }
        
    }];
    UIAlertAction *hrchiveAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
        // 2. 创建图片选择控制器
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        
        // 3. 设置打开照片相册类型(显示所有相簿)
        ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //        [self presentViewController:alertController animated:YES completion:nil];
        //
        //        // ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        //
        //        // 4.设置代理
        //        ipc.delegate = self;
        //        // 5.modal出这个控制器
        //        [self presentViewController:ipc animated:YES completion:nil];
        //        NSLog(@"下一步");
        ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        // 4.设置代理
        ipc.delegate = self;
        // 5.modal出这个控制器
        [self presentViewController:ipc animated:YES completion:nil];
        NSLog(@"下一步");
        
        
        
    }];
    [self presentViewController:alertController animated:YES completion:nil];
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    //  [alertController addAction:archiveAction];
    [alertController addAction:hrchiveAction];


//    // 1.判断相册是否可以打开
//    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
//    // 2. 创建图片选择控制器
//    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
//    /**
//     typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
//     UIImagePickerControllerSourceTypePhotoLibrary, // 相册
//     UIImagePickerControllerSourceTypeCamera, // 用相机拍摄获取
//     UIImagePickerControllerSourceTypeSavedPhotosAlbum // 相簿
//     }
//     */
//    // 3. 设置打开照片相册类型(显示所有相簿)
//    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    // ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    // 照相机
//    // ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
//    // 4.设置代理
//    ipc.delegate = self;
//    // 5.modal出这个控制器
//    [self presentViewController:ipc animated:YES completion:nil];
//    NSLog(@"下一步");
}


#pragma mark -- <UIImagePickerControllerDelegate>--
//当选择一张图片后进入到这个协议方法里
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        NSData *data1;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data1 = UIImageJPEGRepresentation(image, 1);
        }
        else
        {
            data1 = UIImagePNGRepresentation(image);
        }
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
//        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//        //文件管理器
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
//        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
//        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data1 attributes:nil];
//        //得到选择后沙盒中图片的完整路径
//        NSString *filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
        self.dirveimg.image = image;

       // NSLog(@"%@",filePath);
       // //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{
            NSLog(@"关闭相册界面");
        }];
        
        [self saveImage:image withName:@"huoshuai.png"];
        //[self getGainHttpData];
    }
}
//判断文件的大小
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        NSLog(@"您取消了选择图片222");
    }];
}



-(void)click_back:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}



#pragma mark - 保存图片至沙盒
- (void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"fullPath" forKey:@"fullPath"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    self.img = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    
    // NSData *data = UIImagePNGRepresentation(img);
    
    NSData *hightImageData= UIImageJPEGRepresentation(self.img, .7);
    
    NSString *hightImageName =[NSString stringWithFormat:@"image"];
    
    NSString *hightImageFileName =[NSString stringWithFormat:@"huoshuai.jpg"];
    
    
    
    
  
   
    NSString *transformId = [USER_DEFAULT objectForKey:@"id"];
    
    NSString *token = [USER_DEFAULT objectForKey:@"token"];
    NSArray *nameList = @[@"id",vn(token)];
    
    NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(transformId),sv(token),nil];
    NSLog(@"%@",parameters1);
    NSString *str = sv(transformId);
    

    
 
    [LCProgressHUD showLoading:@"上传中"];
    [manager POST:@"http://www.rempeach.com/rebirth/api/user/checkDriCard" parameters:parameters1 constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //[formData appendPartWithFormData:data name:@"img"];
        [formData appendPartWithFileData:hightImageData
                                    name:hightImageName
                                fileName:hightImageFileName
                                mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"进度:%f",uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        
      //  NSLog(@"%@",json);
        NSLog(@"%@",[json objectForKey:@"tip"]);
        if ([[json objectForKey:@"state"] isEqualToString:@"200"]) {
             NSDictionary *dic = [json objectForKey:@"data"];
            [LCProgressHUD showLoading:@"上传成功"];
            HSBindingJiazhaoViewController *hsbd=[[HSBindingJiazhaoViewController alloc] init];
            hsbd.cardId = [dic objectForKey:@"cardId"];
            hsbd.end_date = [dic objectForKey:@"end_date"];
            hsbd.name = [dic objectForKey:@"name"];
            hsbd.start_date = [dic objectForKey:@"start_date"];
            hsbd.vehicle_type = [dic objectForKey:@"vehicle_type"];
            hsbd.selectImage = self.img;
            [self.navigationController pushViewController:hsbd animated:YES];
            [LCProgressHUD hide];
        }else if ([[json objectForKey:@"state"] isEqualToString:@"111"]){
            
                        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        hud.delegate = self;
                        hud.mode = MBProgressHUDModeText;
                        hud.labelText = @"请重新拍摄一张，注意照片的高光及污渍";
                        //当需要消失的时候:
            [hud hide:YES afterDelay:2];
            [LCProgressHUD hide];
            
        }else if ([[json objectForKey:@"state"] isEqualToString:@"101"]){
            
        }else{
            
        }
        
      
        
    }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"上传错误%@",error);
        }];
    
}


#pragma mark 传送数据
//-(void)getGainHttpData{
//    
//    
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSMutableString *userid = [user objectForKey:@"id"];
//    NSMutableString *token  = [user objectForKey:@"token"];
//    // 2==faa0688d0c2d8f8c224fed0ecd95ab29
//    NSLog(@"%@",userid);
//    if (!userid) {
//        
//        //NSLog(@"11111");
//        int a = arc4random() % 99999;
//        NSString *str = [NSString stringWithFormat:@"%05d", a];
//        token =  (NSMutableString *)[self md5:str];
//        userid = (NSMutableString *)@"10000";
//        
//    }else{
//        
//        
//    }
//
////    int a = arc4random() % 99999;
////    
////    NSString *str = [NSString stringWithFormat:@"%05d", a];
////    
////    NSString *strMD5 = [self md5:str];
//    
//    NSDictionary *dict = @{@"id":userid,@"token":token};
//    
//    NSString *str1 =  [self createMd5Sign:dict];
//    
//    NSString  *str2 = [self md5:@"miaotaoKJ"];
//    
//    NSString *sign = [self md5:[NSString stringWithFormat:@"%@%@",str1,str2]];
//    
//    NSDictionary *para = @{@"id":userid,@"token":token,@"sign":sign};
//    
//    NSLog(@"%@",[NSString stringWithFormat:@"%@",para]);
//  
//   
//
//    
//    [WJFCollection uploadImageWithURL:[NSString stringWithFormat:@"%@/api/user/checkDriCard",ROOTURL] parameters:para image:self.dirveimg.image success:^(id responseObject) {
//    
//        NSLog(@"responseObject%@%@",responseObject,responseObject[@"tip"]);
//       if ([responseObject[@"state"] isEqualToString:@"111"]) {
//           
//           MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//           hud.delegate = self;
//           hud.mode = MBProgressHUDModeText;
//           hud.labelText = @"请重新拍摄一张，注意照片的高光及污渍";
//           //当需要消失的时候:
//           [hud hide:YES afterDelay:2];
//
//       }else if ([responseObject[@"state"] isEqualToString:@"200"]){
//           
//           
//        
//       }else if ([responseObject[@"state"] isEqualToString:@"101"]){
//           
//           
//           
//       }
//
//       
//       
//   } failue:^(NSError *error) {
//       
//       NSLog(@"%@",error);
//   }];
//    
//
//    
//}



-(void)uploadImage{
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSMutableString *userid = [user objectForKey:@"id"];
    NSMutableString *token  = [user objectForKey:@"token"];
    // 2==faa0688d0c2d8f8c224fed0ecd95ab29
    NSLog(@"%@",userid);
    if (!userid) {
        
        //NSLog(@"11111");
        int a = arc4random() % 99999;
        NSString *str = [NSString stringWithFormat:@"%05d", a];
        token =  (NSMutableString *)[self md5:str];
        userid = (NSMutableString *)@"10000";
        
    }else{
        
        
    }

    
    NSDictionary *dict1 = @{@"id":userid,@"token":token,@"name":@"孙云娟",@"cardId":@"330123197908115229",@"end_date":@"2020-06-21", @"start_date":@"2104-07-21",@"vehicle_type":@"C1"};
    
    NSString *str1 =  [self createMd5Sign:dict1];
    
    NSString  *str2 = [self md5:@"miaotaoKJ"];
    
    NSString *sign = [self md5:[NSString stringWithFormat:@"%@%@",str1,str2]];
    
    
    NSDictionary *para = @{@"id":userid,@"token":token,@"name":@"孙云娟",@"cardld":@"330123197908115229",@"end_date":@"2020-06-21", @"start_date":@"2104-07-21",@"vehicle_type":@"C1",@"sign":sign,@"debug":@"true"};

     NSLog(@"%@",[NSString stringWithFormat:@"%@",para]);
//    [HYBNetworking uploadWithImage:[UIImage imageNamed:@"dibai_img.png"] url:[NSString stringWithFormat:@"http://www.rempeach.com/rebirth/api/user/saveDriCard"] filename:@"image" name:@"image" mimeType:@"image/png" parameters:para progress:^(int64_t bytesWritten, int64_t totalBytesWritten) {
//        
//        NSLog(@"%lld",bytesWritten);
//        
//    } success:^(id response) {
//        
//        NSLog(@"responseresponseresponse%@",response[@"tip"]);
//       NSLog(@"111");
//        
//    } fail:^(NSError *error) {
//        
//        NSLog(@"%@",error);
//        
//    }];
    
    
//    [WJFCollection uploadImageWithURL:[NSString stringWithFormat:@"%@/api/user/saveDriCard",ROOTURL] parameters:para image:self.dirveimg.image success:^(id responseObject) {
//        
//         NSLog(@"%@=%@=%@",responseObject,responseObject[@"tip"],responseObject[@"message"]);
//        
//    } failue:^(NSError *error) {
//        
//        NSLog(@"%@",error);
//        
//    }];
    
}


-(NSString*) createMd5Sign:(NSMutableDictionary*)dict
{
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        
        [contentString appendFormat:@"%@%@", categoryId, [dict objectForKey:categoryId]];
        
    }
    return contentString;
}


//md5加密
-(NSString *) md5:(NSString *)str
{
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
    
    
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
