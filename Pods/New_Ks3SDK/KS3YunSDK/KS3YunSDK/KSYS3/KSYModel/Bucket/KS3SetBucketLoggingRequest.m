//
//  KSS3SetBucketLoggingRequest.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3SetBucketLoggingRequest.h"
#import "KS3Client.h"
#import "KS3Constants.h"
@implementation KS3SetBucketLoggingRequest
- (instancetype _Nullable)initWithName:(NSString * _Nullable)bucketName {
  self = [super init];
  if (self) {
    self.bucket = [self URLEncodedString:bucketName];
    self.httpMethod = kHttpMethodPut;
    self.contentMd5 = @"";
    self.contentType = @"";
    self.kSYResource = [NSString stringWithFormat:@"/%@/?logging", self.bucket];
    self.host = [NSString
        stringWithFormat:@"%@://%@.%@/?logging",
                         [[KS3Client initialize] requestProtocol], self.bucket,
                         [[KS3Client initialize] getBucketDomain]];
  }
  return self;
}
- (KS3URLRequest * _Nonnull)configureURLRequest {
  NSString *strBody = @"<BucketLoggingStatus "
                      @"xmlns=\"http://doc.s3.amazonaws.com/2006-03-01\" />";
  [self.urlRequest
      setHTTPBody:[strBody dataUsingEncoding:NSUTF8StringEncoding]];

  [super configureURLRequest];
  return self.urlRequest;
}
@end
