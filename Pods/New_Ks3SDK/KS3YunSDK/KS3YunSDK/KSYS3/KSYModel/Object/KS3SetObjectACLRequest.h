//
//  KSS3SetObjectACLRequest.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3Request.h"
NS_ASSUME_NONNULL_BEGIN
@class KS3AccessControlList;
@interface KS3SetObjectACLRequest : KS3Request

@property(strong, nonatomic, nullable) NSString *key;

@property(strong, nonatomic, nullable) KS3AccessControlList *acl;

- (instancetype _Nullable)initWithName:(NSString * _Nonnull)bucketName
                 withKeyName:(NSString * _Nonnull)strKeyName
                         acl:(KS3AccessControlList *_Nullable)acl;

@end
NS_ASSUME_NONNULL_END
