//
//  S3ListBucketsRequest.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3ListBucketsRequest.h"
#import "KS3Client.h"
#import "KS3Constants.h"
@implementation KS3ListBucketsRequest

- (instancetype _Nullable)init {
  self = [super init];
  if (self) {
    self.httpMethod = kHttpMethodGet;
    self.contentMd5 = @"";
    self.contentType = @"";
    self.kSYResource = @"/";
    self.host = [NSString
        stringWithFormat:@"%@://%@", [[KS3Client initialize] requestProtocol],
                         [[KS3Client initialize] getBucketDomain]];
  }
  return self;
}

@end
