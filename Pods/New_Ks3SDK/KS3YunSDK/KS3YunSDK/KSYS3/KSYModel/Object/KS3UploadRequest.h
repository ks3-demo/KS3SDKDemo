//
//  KS3UploadRequest.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//
//

#import "KS3InitiateMultipartUploadRequest.h"
NS_ASSUME_NONNULL_BEGIN
@interface KS3UploadRequest : KS3InitiateMultipartUploadRequest

- (instancetype _Nonnull)initWithKey:(NSString * _Nonnull)aKey
         inBucket:(NSString * _Nonnull)aBucket
              acl:(KS3AccessControlList *_Nullable)acl
         grantAcl:(NSArray *_Nullable)arrGrantAcl;

@end
NS_ASSUME_NONNULL_END
