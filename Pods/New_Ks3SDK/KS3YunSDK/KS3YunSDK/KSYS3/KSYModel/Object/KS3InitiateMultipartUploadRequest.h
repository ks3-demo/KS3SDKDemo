//
//  KSS3InitiateMultipartUploadRequest.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3AbstractPutRequest.h"

NS_ASSUME_NONNULL_BEGIN

@class KS3AccessControlList;
@class KS3GrantAccessControlList;

@interface KS3InitiateMultipartUploadRequest : KS3AbstractPutRequest

- (instancetype _Nonnull)initWithKey:(NSString * _Nonnull)aKey
         inBucket:(NSString * _Nonnull)aBucket
              acl:(KS3AccessControlList * _Nullable)acl
         grantAcl:(NSArray * _Nullable)arrGrantAcl;

@property(nonatomic, strong, nonnull) NSString *key;
@property(nonatomic, strong, nullable) NSString *cacheControl;
@property(nonatomic, strong, nullable) NSString *contentDisposition;
@property(nonatomic, strong, nullable) NSString *contentEncoding;
@property(nonatomic, strong, nullable) NSString *expires;
@property(nonatomic, strong, nullable) NSString *xkssMeta;
@property(nonatomic, strong, nullable) NSString *xkssStorageClass;
@property(nonatomic, strong, nullable) NSString *xkssWebSiteRedirectLocation;
@property(nonatomic, strong, nullable) NSString *xkssAcl;
@property(nonatomic, strong, nullable) KS3AccessControlList *acl;
@property(nonatomic, strong, nullable) NSArray *arrGrantAcl;

@end
NS_ASSUME_NONNULL_END
