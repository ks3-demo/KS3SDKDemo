//
//  S3ListBucketsResponse.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3ListBucketsResponse.h"
#import "KS3Bucket.h"
#import "KS3ListBucketsXMLParser.h"
@implementation KS3ListBucketsResponse

- (void)processBody {
  KS3ListBucketsXMLParser *xmlParser = [[KS3ListBucketsXMLParser alloc] init];
  [xmlParser kSS3XMLarse:body];
  _listBucketsResult = xmlParser.listBuctkResult;
}
@end
