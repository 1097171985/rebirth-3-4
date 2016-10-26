//
//  HSBindingJiazhaoViewController.m
//  rebirth
//
//  Created by 侯帅 on 16/8/3.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSBindingJiazhaoViewController.h"
#import "HomeViewController.h"
@interface HSBindingJiazhaoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,MBProgressHUDDelegate>

@end

@implementation HSBindingJiazhaoViewController
{
    UITextField *textname;
    UITextField *textnum;
    UITextField *textriqi;
    UITextField *textchexing;
    UITextField *textyouxiaoqi;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [textname resignFirstResponder];
    [textnum resignFirstResponder];
    [textriqi resignFirstResponder];
    [textchexing resignFirstResponder];
    [textyouxiaoqi resignFirstResponder];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatNavi];
    [self creatView];
    
    // Do any additional setup after loading the view.
}
-(void)creatView{
    UIView *line = [[UIView alloc] init];
    line.frame  =CGRectMake(0, NAV_BAR_HEIGHT, kScreenWidth, 0.5);
    line.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    [self.view addSubview:line];
    UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(174/2,NAV_BAR_HEIGHT+ 10, kScreenWidth-174, 120*HEIGHTRATIO)];
    if ([self.from isEqualToString:@"bangding"]) {
    
        [imgview sd_setImageWithURL:[NSURL URLWithString:_img] placeholderImage:nil];
    }else{
        // 获取沙盒目录
        NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"huoshuai.png"];
        // 将图片写入文件
        
        UIImage *img = [[UIImage alloc] initWithContentsOfFile:fullPath];
        imgview.image  = img;
        

    }
    [self.view addSubview:imgview];
    UILabel *querenlbl = [[UILabel alloc] init];
    querenlbl.text = @"请确认您的驾驶证信息";
    querenlbl.textAlignment = NSTextAlignmentCenter;
    querenlbl.textColor = [NSString colorWithHexString:@"#6d7278"];
    querenlbl.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:querenlbl];
    [querenlbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(line).offset(155);
        make.height.equalTo(@12);
        
        
    }];
    UIView *content = [[UIView alloc] init];
    content.backgroundColor = [NSString colorWithHexString:@"#f2f2f2"];
    [self.view addSubview:content];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(querenlbl.mas_bottom).offset(10);
        make.height.equalTo(@12);
        
    }];
    UIView *contentview = [[UIView alloc] init];
    contentview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentview];
    [contentview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(content.mas_bottom);
        make.height.mas_equalTo(200*HEIGHTRATIO);
    }];
    UIView *contentView1 = [[UIView alloc] init];
    contentView1.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    [self.view addSubview:contentView1];
    [contentView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(contentview.mas_bottom);
        make.bottom.equalTo(self.view);
    }];
   
    if (iPhone6plus) {
        for (int i =0; i<4; i++) {
            UIView *linee = [[UIView alloc] init];
            linee.frame = CGRectMake(0, (39.55+40.5*i)*HEIGHTRATIO, kScreenWidth, 0.5);
            linee.backgroundColor = [NSString colorWithHexString:@"#6d7278"];
            [contentview addSubview:linee];
        }

    }else{
    for (int i =0; i<4; i++) {
        UIView *linee = [[UIView alloc] init];
        linee.frame = CGRectMake(0, (40+40*i)*HEIGHTRATIO, kScreenWidth, 0.5);
        linee.backgroundColor = [NSString colorWithHexString:@"e5e5e5"];
        [contentview addSubview:linee];
    }
    }
    NSArray *arr = [[NSArray alloc] initWithObjects:@"姓名",@"证号",@"初次领证日期",@"准驾车型",@"有效期", nil];
    for (int a =0; a<5; a++) {
        UILabel *lbl = [[UILabel alloc] init];
        lbl.frame =CGRectMake(20*WIDTHRATIO, (14+a*40)*HEIGHTRATIO, kScreenWidth/2-20, 14*HEIGHTRATIO);
        lbl.text = arr[a];
        lbl.textAlignment = NSTextAlignmentLeft;
        lbl.textColor = [NSString colorWithHexString:@"#27292b"];
        lbl.font = [UIFont systemFontOfSize:14];
        [contentview addSubview:lbl];
    }
    textname = [[UITextField alloc] init];
    textname.frame =CGRectMake(kScreenWidth/2, 14*HEIGHTRATIO, kScreenWidth/2-20, 14*HEIGHTRATIO);
    textname.font = [UIFont systemFontOfSize:14];
    textname.text = self.name;
    [contentview addSubview:textname];
    textnum  = [[UITextField alloc] init];
    textnum.font = [UIFont systemFontOfSize:14];
    textnum.frame =CGRectMake(kScreenWidth/2, 54*HEIGHTRATIO, kScreenWidth/2-20, 14*HEIGHTRATIO);
    textnum.text = self.cardId;
    [contentview addSubview:textnum];
    textriqi = [[UITextField alloc] init];
    textriqi.frame =CGRectMake(kScreenWidth/2, 94*HEIGHTRATIO, kScreenWidth/2-20, 14*HEIGHTRATIO);
    textriqi.font = [UIFont systemFontOfSize:14];
    textriqi.text = self.start_date;
    [contentview addSubview:textriqi];
    textchexing = [[UITextField alloc] init];
    textchexing.frame =CGRectMake(kScreenWidth/2, 134*HEIGHTRATIO, kScreenWidth/2-20, 14*HEIGHTRATIO);
    textchexing.font = [UIFont systemFontOfSize:14];
    textchexing.text = self.vehicle_type;
    [contentview addSubview:textchexing];
    textyouxiaoqi = [[UITextField alloc] init];
    textyouxiaoqi.frame =CGRectMake(kScreenWidth/2, 174*HEIGHTRATIO, kScreenWidth/2-20, 14*HEIGHTRATIO);
    textyouxiaoqi.font = [UIFont systemFontOfSize:14];
    textyouxiaoqi.text = self.end_date;
    [contentview addSubview:textyouxiaoqi];
    
    
    
    UILabel *tiplbl = [[UILabel alloc] init];
    tiplbl.textColor = [NSString colorWithHexString:@"#6d7278"];
    tiplbl.textAlignment = NSTextAlignmentLeft;
    tiplbl.text = @"信息有误？请修改以上信息或";
    tiplbl.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:tiplbl];
    if (iPhone6plus) {
        [tiplbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view);
            make.left.equalTo(self.view).offset(kScreenWidth/4);
            make.top.equalTo(contentview.mas_bottom).offset(25*HEIGHTRATIO);
            make.height.equalTo(@12);
        }];
        
    }else{
    [tiplbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.equalTo(self.view).offset(kScreenWidth/4-15);
        make.top.equalTo(contentview.mas_bottom).offset(25*HEIGHTRATIO);
        make.height.equalTo(@12);
    }];
    }
    UIButton *congxinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [congxinBtn setTitle:@"重新上传照片" forState:UIControlStateNormal];
    [congxinBtn setTitleColor:[NSString colorWithHexString:heitizi] forState:UIControlStateNormal];
    congxinBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:congxinBtn];
    [congxinBtn addTarget:self action:@selector(chongxinUpdate:) forControlEvents:UIControlEventTouchUpInside];
    [congxinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(170*WIDTHRATIO);
        make.right.equalTo(self.view);
        make.top.equalTo(contentview.mas_bottom).offset(25*HEIGHTRATIO);
        make.height.equalTo(@12);
    }];
    
    UIButton *tijiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tijiaoBtn.backgroundColor = [NSString colorWithHexString:heitizi];
    [tijiaoBtn setTitle:@"提交信息" forState:UIControlStateNormal];
    [tijiaoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tijiaoBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:tijiaoBtn];
    [tijiaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(37);
        make.right.equalTo(self.view).offset(-37);
        make.top.equalTo(tiplbl.mas_bottom).offset(20);
        make.height.equalTo(@40);
    }];
    tijiaoBtn.layer.cornerRadius =3;
    [tijiaoBtn addTarget:self action:@selector(click_tijiao:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)chongxinUpdate:(UIButton *)sender{
    NSLog(@"重新提交");
    
    
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
    
    
    //    [alertController addAction:cancelAction];
    //    [alertController addAction:deleteAction];
    //    //  [alertController addAction:archiveAction];
    //    [alertController addAction:hrchiveAction];
    
    
    
    
    
    
    
    
    
    
    
    
    
   
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
//    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
////    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle: UIAlertControllerStyleActionSheet];
////    
////    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
////    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
////        if (TARGET_IPHONE_SIMULATOR) {
////            [Common tipAlert:@"模拟器无拍摄视频功能"];
////        }else{
////            // 照相机
////            
////         
////            
////        }
////        
////    }];
////    //    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
////    //        if (TARGET_IPHONE_SIMULATOR) {
////    //            [Common tipAlert:@"模拟器无拍照功能"];
////    //        }else{
////    //        [self selectImageFromCamera];
////    //        }
////    //    }];
////    UIAlertAction *hrchiveAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
////        
////        // 3. 设置打开照片相册类型(显示所有相簿)
////        ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//////        [self presentViewController:alertController animated:YES completion:nil];
//////        
//////        // ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//////        
//////        // 4.设置代理
//////        ipc.delegate = self;
//////        // 5.modal出这个控制器
//////        [self presentViewController:ipc animated:YES completion:nil];
//////        NSLog(@"下一步");
////
////
////        
////    }];
//  //  [self presentViewController:alertController animated:YES completion:nil];
//    
//    // ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    
//    // 4.设置代理
//    ipc.delegate = self;
//    // 5.modal出这个控制器
//    [self presentViewController:ipc animated:YES completion:nil];
//    NSLog(@"下一步");

    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    //  [alertController addAction:archiveAction];
    [alertController addAction:hrchiveAction];
    
  
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
      //  self.dirveimg.image = image;
        
        // NSLog(@"%@",filePath);
        // //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{
            NSLog(@"关闭相册界面");
        }];
        
        [self saveImage1:image withName:@"huoshuai.png"];
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
#pragma mark - 保存图片至沙盒
- (void)saveImage1:(UIImage *)currentImage withName:(NSString *)imageName
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
    
    self.img1 = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    
    // NSData *data = UIImagePNGRepresentation(img);
    
    NSData *hightImageData= UIImageJPEGRepresentation(self.img1, .7);
    
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
            hsbd.selectImage = self.img1;
            [self.navigationController pushViewController:hsbd animated:YES];
            [LCProgressHUD hide];
        }else if ([[json objectForKey:@"state"] isEqualToString:@"111"]){
            [LCProgressHUD hide];
            NSLog(@"%@",[json objectForKey:@"message"]);
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.delegate = self;
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"请重新拍摄一张，注意照片的高光及污渍";
            //当需要消失的时候:
            [hud hide:YES afterDelay:2];
           
            
        }else if ([[json objectForKey:@"state"] isEqualToString:@"101"]){
            
        }else{
            
        }
        
        
        
    }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"上传错误%@",error);
          }];
    
}

-(void)click_tijiao:(UIButton *)sender{
    NSLog(@"提交审核");
    
    [self http];
    
}
-(void)http{
   /*
    402 绑定驾驶证
    URL：http://www.rempeach.com/rebirth/api/user/saveDriCard
    接口描述：上传图片信息，绑定
    请求方式：POST
    上传参数：
    id
    name
    cardld                  330123197908115229
    end_date                2020-06-21
    start_date              2014-06-21
    vehicle_type            C1
    token
    sign
    image
    
    
    
     a b c d e f g h i g k l m n o p q r s t u v w x y z
    返回参数：state ：200 100 111 101 121 状态码（见附录）
    */
    
   
    
//   
//    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    // 获取沙盒目录
//    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"huoshuai.png"];
//    // 将图片写入文件
//    
//    UIImage *img = [[UIImage alloc] initWithContentsOfFile:fullPath];
//    // NSData *data = UIImagePNGRepresentation(img);
//    
//    NSData *hightImageData= UIImageJPEGRepresentation(img, .7);
//    
//    NSString *hightImageName =[NSString stringWithFormat:@"image"];
//    
//    NSString *hightImageFileName =[NSString stringWithFormat:@"huoshuai.jpg"];
//    NSString *cardld = textnum.text;
//    NSString *end_date = textyouxiaoqi.text;
//    NSString *idd = [USER_DEFAULT objectForKey:@"id"];
//    NSString *name = textname.text;
//    NSString *start_date =textriqi.text;
//    NSString *token = [USER_DEFAULT objectForKey:@"token"];
//    NSString *vehicle_type = textchexing.text;
//    NSArray *nameList = @[vn(cardld),vn(end_date),@"id",vn(name),vn(start_date),vn(token),vn(vehicle_type)];
//    
//    NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(cardld),sv(end_date),sv(idd),sv(name),sv(start_date),sv(token),sv(vehicle_type),nil];
//    NSLog(@"%@",parameters1);
//    NSString *str = sv(idd);
//    [manager POST:@"http://www.rempeach.com/rebirth/api/user/saveDriCard" parameters:parameters1 constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        //[formData appendPartWithFormData:data name:@"img"];
//        [formData appendPartWithFileData:hightImageData
//                                    name:hightImageName
//                                fileName:hightImageFileName
//                                mimeType:@"image/jpeg"];
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        NSLog(@"进度:%f",uploadProgress.fractionCompleted);
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        
//        
//        //  NSLog(@"%@",json);
//        NSLog(@"%@",[json objectForKey:@"tip"]);
//        if ([[json objectForKey:@"state"] isEqualToString:@"200"]) {
//            NSDictionary *dic = [json objectForKey:@"data"];
//            HomeViewController *home = [[HomeViewController alloc] init];
//            [self.navigationController pushViewController:home animated:YES];
//            
//        }else if ([[json objectForKey:@"state"] isEqualToString:@"111"]){
//            
//            
//        }else if ([[json objectForKey:@"state"] isEqualToString:@"101"]){
//            
//        }else{
//            
//        }
//        
//        
//        
//    }
//          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//              NSLog(@"上传错误%@",error);
//          }];
    if ([self.from isEqualToString:@"bangding"]) {
        [Common tipAlert:@"已上传过信息"];
    }
   
    else{
    [self saveImage:self.selectImage withName:@"houshuai"];
    
    }
}
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"fullPath" forKey:@"fullPath"];
    NSLog(@"%@11111",fullPath);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:fullPath];
    // NSData *data = UIImagePNGRepresentation(img);
    
    NSData *hightImageData= UIImageJPEGRepresentation(img, .7);
    
    NSString *hightImageName =[NSString stringWithFormat:@"image"];
    
    NSString *hightImageFileName =[NSString stringWithFormat:@"houshuai.jpg"];
    NSString *cardId = textnum.text;
    NSString *end_date = textyouxiaoqi.text;
    NSString *idd = [USER_DEFAULT objectForKey:@"id"];
    NSString *name = textname.text;
    NSString *start_date =textriqi.text;
    NSString *token = [USER_DEFAULT objectForKey:@"token"];
    NSString *vehicle_type = textchexing.text;
    NSArray *nameList = @[vn(cardId),vn(end_date),@"id",vn(name),vn(start_date),vn(token),vn(vehicle_type)];
    
    NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(cardId),sv(end_date),sv(idd),sv(name),sv(start_date),sv(token),sv(vehicle_type),nil];
    NSLog(@"%@",parameters1);
    NSString *str = sv(idd);
    
//     NSDictionary *parDic =@{@"id":[USER_DEFAULT objectForKey:@"id"],@"name":@"孙玉娟",@"cardId":@"330123197908115229",@"end_date":@"2020-06-21",@"start_date":@"2014-06-21",@"vehicle_type":@"C1",@"token":[USER_DEFAULT objectForKey:@"token"],@"sign":@"2382dfa06e9c3570f9ac8c858cfa9e92",@"debug":@"true"};

       [manager POST:@"http://www.rempeach.com/rebirth/api/user/saveDriCard" parameters:parameters1 constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //[formData appendPartWithFormData:data name:@"img"];
        [formData appendPartWithFileData:hightImageData
                                    name:hightImageName
                                fileName:hightImageFileName
                                mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"进度:%f",uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@message",[json objectForKey:@"message"]);
        NSLog(@"%@",json);
        NSLog(@"%@",[json objectForKey:@"tip"]);
       // NSDictionary *dic = [json objectForKey:@"data"];
        
        //        [_meImageView sd_setImageWithURL:[dic objectForKey:@"pic_url"] placeholderImage:[UIImage imageWithContentsOfFile:fullPath]];
        if ([[json objectForKey:@"state"] isEqualToString:@"210"]) {
            [LCProgressHUD showSuccess:@"上传成功"];
            HomeViewController *hone = [[HomeViewController alloc] init];
            [self.navigationController pushViewController:hone animated:YES];
        }else{
            [Common tipAlert:@"上传失败"];
            NSLog(@"%@",[json objectForKey:@"message"]);
            NSLog(@"%@",[json objectForKey:@"tip"]);
            HomeViewController *hone = [[HomeViewController alloc] init];
            [self.navigationController pushViewController:hone animated:YES];
        }
       
    }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"上传错误%@",error);
              
          }];
    
    
}

-(void)creatNavi{
    UIView *navi = [[UIView alloc] init];
    navi.frame =CGRectMake(0, 0,kScreenWidth , NAV_BAR_HEIGHT);
    navi.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navi];
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(50, kStatusBarHeight, kScreenWidth-100, NAV_BAR_HEIGHT-kStatusBarHeight)];
    titleLbl.textColor = [NSString colorWithHexString:heitizi];
    titleLbl.text = @"验证驾驶证";
    titleLbl.font = [UIFont systemFontOfSize:16];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    [navi addSubview:titleLbl];
    UIButton *backBtn=  [YkxHttptools initwithButton:[UIColor clearColor] Frame:CGRectMake(0, kStatusBarHeight, 50, NAV_BAR_HEIGHT-kStatusBarHeight) Image:[UIImage imageNamed:@"back_arrow@2x"] Title:nil Titlecolor:[NSString colorWithHexString:heitizi ] Titlefont:[UIFont systemFontOfSize:14] BaseView:navi];
    [backBtn addTarget:self action:@selector(click_back:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)click_back:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
