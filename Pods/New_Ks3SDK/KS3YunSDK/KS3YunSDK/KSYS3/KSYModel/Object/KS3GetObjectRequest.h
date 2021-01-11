//
//  KSS3GetObjectRequest.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3Request.h"
NS_ASSUME_NONNULL_BEGIN
@interface KS3GetObjectRequest : KS3Request

@property(strong, nonatomic, nullable) NSString *responseContentType;
@property(strong, nonatomic, nullable) NSString *responseContentLanguage;
@property(strong, nonatomic, nullable) NSString *responseExpires;
@property(strong, nonatomic, nullable) NSString *responseCacheControl;
@property(strong, nonatomic, nullable) NSString *responseContentDisposition;
@property(strong, nonatomic, nullable) NSString *responseContentEncoding;

@property(strong, nonatomic, nullable) NSString *range;
@property(strong, nonatomic, nullable) NSString *ifModifiedSince;
@property(strong, nonatomic, nullable) NSString *ifUnmodifiedSince;
@property(strong, nonatomic, nullable) NSString *ifMatch;
@property(strong, nonatomic, nullable) NSString *ifNoneMatch;
@property(strong, nonatomic, nullable) NSString *versionId;
@property(strong, nonatomic, nonnull) NSString *key;

- (instancetype _Nonnull)initWithName:(NSString * _Nonnull)bucketName;

@end
NS_ASSUME_NONNULL_END
