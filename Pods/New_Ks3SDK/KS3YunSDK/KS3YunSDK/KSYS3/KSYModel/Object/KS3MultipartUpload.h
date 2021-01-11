//
//  KSS3MultipartUpload.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3Owner.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//上传类型
typedef enum {
  kUploadAlasset = 0, //相册中
  kUploadNormal,      //沙盒里或工程里
} UploadType;

@interface KS3MultipartUpload : NSObject

@property(nonatomic, strong, nonnull) NSString *key;

@property(nonatomic, strong, nonnull) NSString *bucket;

@property(nonatomic, strong, nonnull) NSString *uploadId;

@property(nonatomic, strong, nonnull) NSString *storageClass;

@property(nonatomic, strong, nullable) KS3Owner *initiator;

@property(nonatomic, strong, nullable) KS3Owner *owner;

@property(nonatomic, strong, nullable) NSDate *initiated;

@property(assign, readonly) BOOL isCanceled;

@property(assign, nonatomic, readonly) BOOL isPaused;

@property(assign, nonatomic) UploadType uploadType;

//暂停
- (void)pause;
//继续
- (void)proceed;
//取消
- (void)cancel;

@end
NS_ASSUME_NONNULL_END
