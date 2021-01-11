//
//  KSS3SetObjectGrantACLRequest.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 Blues. All rights reserved.
//

#import "KS3Request.h"
NS_ASSUME_NONNULL_BEGIN
@class KS3GrantAccessControlList;

@interface KS3SetObjectGrantACLRequest : KS3Request

@property(strong, nonatomic, nonnull) KS3GrantAccessControlList *acl;
@property(strong, nonatomic, nonnull) NSString *key;

- (instancetype _Nonnull)initWithName:(NSString * _Nonnull)bucketName
                 withKeyName:(NSString * _Nonnull)strKeyName
                    grantAcl:(KS3GrantAccessControlList *_Nonnull)grantAcl;

@end
NS_ASSUME_NONNULL_END
