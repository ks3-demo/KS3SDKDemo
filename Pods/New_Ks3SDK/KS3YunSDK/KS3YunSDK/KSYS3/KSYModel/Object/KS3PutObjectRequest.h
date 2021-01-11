//
//  KSS3PutObjectRequest.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3Request.h"

NS_ASSUME_NONNULL_BEGIN

@class KS3AccessControlList;
@class KS3GrantAccessControlList;

@interface KS3PutObjectRequest : KS3Request

@property(nonatomic, strong, nullable) NSString *cacheControl;
@property(nonatomic, strong, nullable) NSString *contentDisposition;
@property(nonatomic, strong, nullable) NSString *contentEncoding;
@property(nonatomic, assign) BOOL generateMD5;
@property(nonatomic, strong, nullable) NSString *expect;
@property(nonatomic, strong, nonnull) NSData *data;
@property(nonatomic, assign, readonly) int64_t expires;
@property(nonatomic, strong, nonnull) NSString *filename;
@property(nonatomic, strong, nullable) NSString *redirectLocation;
@property(nonatomic, strong, nullable) NSString *callbackUrl;
@property(nonatomic, strong, nullable) NSString *callbackBody;
@property(nonatomic, strong, nullable) NSDictionary *callbackParams;
@property(strong, nonatomic, nullable) KS3AccessControlList *acl;
@property(nonatomic, strong, nullable) NSArray *arrGrantAcl;

- (instancetype _Nonnull)initWithName:(NSString * _Nonnull)bucketName
                     withAcl:(KS3AccessControlList * _Nullable)acl
                    grantAcl:(NSArray * _Nullable)arrGrantAcl;

@end
NS_ASSUME_NONNULL_END
