//
//  KSS3BucketACLResponse.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3GetACLResponse.h"
#import "KS3BucketACLResult.h"
#import "KS3BucketACLXMLParser.h"
@implementation KS3GetACLResponse

- (void)processBody {
  KS3BucketACLXMLParser *xmlParser = [[KS3BucketACLXMLParser alloc] init];
  [xmlParser kSS3XMLarse:body];
  _listBucketsResult = xmlParser.listBuctkResult;
}
@end
