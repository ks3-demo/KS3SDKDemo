//
//  KSS3MultipartUpload.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3MultipartUpload.h"
#import "KS3AbortMultipartUploadRequest.h"
#import "KS3AbortMultipartUploadResponse.h"

@implementation KS3MultipartUpload

- (void)pause {
  _isPaused = YES;
}

- (void)proceed {
  _isPaused = NO;
  _isCanceled = NO;
}

- (void)cancel {
  _isCanceled = YES;
}

@end
