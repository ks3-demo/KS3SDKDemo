//
//  KSS3ListObjectsResponse.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3ListObjectsResponse.h"
#import "KS3ListObjectsResult.h"
#import "KS3ListObjectsXMLPrarser.h"
#import "KS3ObjectSummary.h"
#import "KS3Owner.h"
@implementation KS3ListObjectsResponse
- (void)processBody {
  KS3ListObjectsXMLPrarser *xmlParser = [[KS3ListObjectsXMLPrarser alloc] init];
  [xmlParser kSS3XMLarse:body];
  _listBucketsResult = xmlParser.listBuctkResult;
}
@end
