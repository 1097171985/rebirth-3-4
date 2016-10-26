//
//  UploadParam.h
//  WJFNetworking
//
//  Created by WJF on 16/4/19.
//  Copyright © 2016年 WJF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadParam : NSObject


//图片的二进制数据
@property(nonatomic,copy)NSData *data;

/**
 *  服务器对应的参数名称
 */
@property (nonatomic, copy) NSString *name;
//图片上传文件的名称
@property(nonatomic,copy)NSString *fileName;

//图片的MIME类型（image/png, image/jpg）等
@property(nonatomic,copy)NSString *mimeType;


@end
