//
//  KS3UploadRequest.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//
//

#import "KS3UploadRequest.h"

@implementation KS3UploadRequest

- (instancetype _Nonnull)initWithKey:(NSString * _Nonnull)aKey
         inBucket:(NSString * _Nonnull)aBucket
              acl:(KS3AccessControlList *_Nullable)acl
         grantAcl:(NSArray *_Nullable)arrGrantAcl
{
    if (self = [super initWithKey:aKey inBucket:aBucket acl:acl grantAcl:arrGrantAcl]){
        
    }
    return self;
}

@end
