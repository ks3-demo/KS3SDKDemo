//
//  KSS3ListObjectsRequest.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3ListObjectsRequest.h"
#import "KS3Client.h"
#import "KS3Constants.h"
#import "KS3SDKUtil.h"
@implementation KS3ListObjectsRequest
- (instancetype _Nullable)initWithName:(NSString * _Nullable)bucketName {
  self = [super init];
  if (self) {
    self.bucket = [self URLEncodedString:bucketName];
    self.httpMethod = kHttpMethodGet;
    self.contentMd5 = @"";
    self.contentType = @"";
    self.kSYResource = [NSString stringWithFormat:@"/%@/", self.bucket];
    self.host = [NSString
        stringWithFormat:@"%@://%@.%@",
                         [[KS3Client initialize] requestProtocol], self.bucket,
                         [[KS3Client initialize] getBucketDomain]];
  }
  return self;
}

- (KS3URLRequest * _Nonnull)configureURLRequest {
  NSMutableString *queryString = [NSMutableString stringWithCapacity:512];
  if (nil != self.prefix) {
    [queryString appendFormat:@"%@=%@", kKS3QueryParamPrefix,
                              [KS3SDKUtil urlEncode:self.prefix]];
  }
  if (nil != self.marker) {
    if ([queryString length] > 0) {
      [queryString appendFormat:@"&"];
    }
    [queryString appendFormat:@"%@=%@", kKS3QueryParamMarker,
                              [KS3SDKUtil urlEncode:self.marker]];
  }
  if (nil != self.delimiter) {
    if ([queryString length] > 0) {
      [queryString appendFormat:@"&"];
    }
    [queryString appendFormat:@"%@=%@", kKS3QueryParamDelimiter,
                              [KS3SDKUtil urlEncode:self.delimiter]];
  }
  if (nil != self.encodingType) {
    if (queryString.length > 0) {
      [queryString appendFormat:@"&"];
    }
    [queryString appendFormat:@"%@=%@", kKS3QueryParamEncodingType,
                              [KS3SDKUtil urlEncode:self.encodingType]];
  }
  if (self.maxKeys > 0) {
    if ([queryString length] > 0) {
      [queryString appendFormat:@"&"];
    }
    [queryString appendFormat:@"%@=%d", kKS3QueryParamMaxKeys, self.maxKeys];
  }
  if ([queryString length] > 0) {
    self.host = [NSString stringWithFormat:@"%@/?%@", self.host, queryString];
  }
  [super configureURLRequest];
  return self.urlRequest;
}
@end
