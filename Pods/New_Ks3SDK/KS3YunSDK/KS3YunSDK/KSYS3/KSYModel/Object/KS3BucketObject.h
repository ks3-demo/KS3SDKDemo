//
//  KS3BucketObj.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020年 ks3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KS3BucketObject : NSObject
@property(strong, nonatomic, nonnull) NSString *bucketName;
@property(strong, nonatomic, nonnull) NSString *objKey;

- (instancetype _Nonnull)initWithBucketName:(NSString * _Nullable)strBucketName
                                    keyName:(NSString * _Nullable)strKeyName;

@end
