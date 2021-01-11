//
//  KS3PutObjectCopyRequest.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3BucketObject.h"
#import "KS3Request.h"
NS_ASSUME_NONNULL_BEGIN
@interface KS3PutObjectCopyRequest : KS3Request

@property(strong, nonatomic, nonnull) NSString *strSourceBucket;
@property(strong, nonatomic, nonnull) NSString *strSourceObject;
@property(strong, nonatomic, nullable) NSString *xkssMetaDataDirective;
@property(strong, nonatomic, nullable) NSString *xkssCopySourceIfMatch;
@property(strong, nonatomic, nullable) NSString *xkssCopySourceIfNoneMatch;
@property(strong, nonatomic, nullable) NSString *xkssCopySourceIfUnmodifiedSince;
@property(strong, nonatomic, nullable) NSString *xkssCopySourceIfModifiedSince;
@property(strong, nonatomic, nullable) NSString *xkssMeta;
@property(strong, nonatomic, nullable) NSString *xkssStorageClass;
@property(strong, nonatomic, nullable) NSString *xkssWebsiteRedirectLocation;

@property(strong, nonatomic, nullable) NSString *xkssServerSideEncryption;
@property(strong, nonatomic, nullable) NSString *xkssServerSideEncryptionCustomerKey;
@property(strong, nonatomic, nullable)
    NSString *xkssServerSideEncryptionCustomerAlgorithm;
@property(strong, nonatomic, nullable) NSString *xkssServerSideEncryptionCustomerKeyMD5;
@property(strong, nonatomic, nullable)
    NSString *xkssCopySourceServerSideEncryptionCustomerKey;
@property(strong, nonatomic, nullable)
    NSString *xkssCopySourceServerSideEncryptionCustomerAlgorithm;
@property(strong, nonatomic, nullable)
    NSString *xkssCopySourceServerSideEncryptionCustomerMD5;
@property(strong, nonatomic, nullable) NSString *xkssAcl;

@property(strong, nonatomic, nonnull) NSString *key;

//- (instancetype _Nullable)initWithName:(NSString * _Nullable)bucketName;
- (instancetype _Nonnull)initWithName:(KS3BucketObject * _Nonnull)destBucketObj
             sourceBucketObj:(KS3BucketObject * _Nonnull)sourBucketObj;

@end
NS_ASSUME_NONNULL_END
