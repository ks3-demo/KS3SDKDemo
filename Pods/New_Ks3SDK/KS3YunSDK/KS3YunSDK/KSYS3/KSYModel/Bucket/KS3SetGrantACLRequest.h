//
//  KSS3SetGrantACLRequest.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 Blues. All rights reserved.
//

#import "KS3Request.h"

@class KS3GrantAccessControlList;

@interface KS3SetGrantACLRequest : KS3Request

@property(strong, nonatomic, nullable) KS3GrantAccessControlList *acl;

- (instancetype _Nullable)initWithName:(NSString * _Nullable)bucketName
                   accessACL:(KS3GrantAccessControlList *)accessACL;

@end
