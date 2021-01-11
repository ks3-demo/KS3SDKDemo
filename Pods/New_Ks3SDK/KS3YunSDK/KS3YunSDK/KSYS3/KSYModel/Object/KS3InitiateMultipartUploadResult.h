//
//  KSS3InitiateMultipartUploadResult.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3MultipartUpload.h"
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface KS3InitiateMultipartUploadResult : NSObject
@property(strong, nonatomic, nullable) KS3MultipartUpload *multipartUpload;
@end
NS_ASSUME_NONNULL_END
