//
//  KSS3ListPartsRequest.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3MultipartUpload.h"
#import "KS3Request.h"
NS_ASSUME_NONNULL_BEGIN
@interface KS3ListPartsRequest : KS3Request

@property(strong, nonatomic ,nonnull) NSString *key;
@property(nonatomic, strong, nonnull) NSString *uploadId;
@property(nonatomic, assign) int32_t maxParts;
@property(nonatomic, assign) int32_t partNumberMarker;
@property(nonatomic, strong, nullable) NSString *encodingType;

- (instancetype _Nonnull)initWithMultipartUpload:(KS3MultipartUpload * _Nonnull)multipartUpload;

@end
NS_ASSUME_NONNULL_END
