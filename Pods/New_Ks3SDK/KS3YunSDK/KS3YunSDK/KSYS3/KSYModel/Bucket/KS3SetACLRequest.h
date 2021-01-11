//
//  KSS3SetACLRequest.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3Request.h"

@class KS3AccessControlList;
@interface KS3SetACLRequest : KS3Request

@property(strong, nonatomic, nullable) KS3AccessControlList *acl;

- (instancetype _Nullable)initWithName:(NSString * _Nullable)bucketName
                   accessACL:(KS3AccessControlList *)accessACL;

@end
