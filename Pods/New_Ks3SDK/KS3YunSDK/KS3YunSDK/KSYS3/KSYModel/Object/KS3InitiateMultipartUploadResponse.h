//
//  KSS3InitiateMultipartUploadResponse.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3MultipartUpload.h"
#import "KS3Response.h"
NS_ASSUME_NONNULL_BEGIN
@interface KS3InitiateMultipartUploadResponse : KS3Response
@property(strong, nonatomic, nullable) KS3MultipartUpload *multipartUpload;
@end
NS_ASSUME_NONNULL_END
