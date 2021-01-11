//
//  KSS3BucketACLResult.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3Grant.h"
#import "KS3Owner.h"
#import <Foundation/Foundation.h>

@interface KS3BucketACLResult : NSObject
@property(strong, nonatomic, nullable) KS3Owner *owner;
@property(strong, nonatomic, nullable) NSMutableArray *accessControlList;
@end
