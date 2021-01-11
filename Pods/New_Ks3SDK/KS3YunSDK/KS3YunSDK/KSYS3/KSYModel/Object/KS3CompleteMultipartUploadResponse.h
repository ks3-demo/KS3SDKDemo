//
//  KSS3CompleteMultipartUploadResponse.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3CompleteMultipartUploadResult.h"
#import "KS3Response.h"
NS_ASSUME_NONNULL_BEGIN
@interface KS3CompleteMultipartUploadResponse : KS3Response
@property(nonatomic, readonly)
    KS3CompleteMultipartUploadResult *completeMultipartUploadResult;
@end
NS_ASSUME_NONNULL_END
