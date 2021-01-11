//
//  KSS3GetObjectACLResponse.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3GetObjectACLResponse.h"
#import "KS3BucketACLResult.h"
#import "KS3ObjectACLXMLParser.h"
@implementation KS3GetObjectACLResponse

- (void)processBody {
  KS3ObjectACLXMLParser *xmlParser = [[KS3ObjectACLXMLParser alloc] init];
  [xmlParser kSS3XMLarse:body];
  _listBucketsResult = xmlParser.listBuctkResult;
}
@end
