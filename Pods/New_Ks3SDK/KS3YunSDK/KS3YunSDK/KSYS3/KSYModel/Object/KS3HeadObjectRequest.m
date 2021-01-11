//
//  KSS3HeadObjectRequest.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3HeadObjectRequest.h"
#import "KS3Client.h"
#import "KS3Constants.h"
@implementation KS3HeadObjectRequest

- (instancetype _Nonnull)initWithName:(NSString * _Nonnull)bucketName
                 withKeyName:(NSString * _Nonnull)strKey {
  self = [super init];
  if (self) {
    self.bucket = [self URLEncodedString:bucketName];
    self.key = [self URLEncodedString:strKey];
    self.httpMethod = kHttpMethodHead;
    self.contentMd5 = @"";
    self.contentType = @"";
    self.kSYResource = [NSString stringWithFormat:@"/%@", self.bucket];
    self.host = [NSString
        stringWithFormat:@"%@://%@.%@",
                         [[KS3Client initialize] requestProtocol], self.bucket,
                         [[KS3Client initialize] getBucketDomain]];

    //
    self.host = [NSString stringWithFormat:@"%@/%@", self.host, _key];
    self.kSYResource =
        [NSString stringWithFormat:@"%@/%@", self.kSYResource, _key];
  }
  return self;
}

- (KS3URLRequest * _Nonnull)configureURLRequest {
  [super configureURLRequest];

  // **** http header
  if (nil != _range) {
    [self.urlRequest setValue:_range forHTTPHeaderField:kKSHttpHdrRange];
  }
  if (nil != _ifModifiedSince) {
    [self.urlRequest setValue:_ifModifiedSince
           forHTTPHeaderField:kKSHttpHdrIfModifiedSince];
  }
  if (nil != _ifUnmodifiedSince) {
    [self.urlRequest setValue:_ifUnmodifiedSince
           forHTTPHeaderField:kKSHttpHdrIfUnmodifiedSince];
  }
  if (nil != _ifMatch) {
    [self.urlRequest setValue:_ifMatch forHTTPHeaderField:kKSHttpHdrIfMatch];
  }
  if (nil != _ifNoneMatch) {
    [self.urlRequest setValue:_ifNoneMatch
           forHTTPHeaderField:kKSHttpHdrIfNoneMatch];
  }
  return self.urlRequest;
}

@end
