//
//  KSS3InitiateMultipartUploadResponse.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3InitiateMultipartUploadResponse.h"
#import "KS3InitiateMultipartUploadXMLParser.h"

@implementation KS3InitiateMultipartUploadResponse

- (void)processBody {
  KS3InitiateMultipartUploadXMLParser *xmlParser =
      [[KS3InitiateMultipartUploadXMLParser alloc] init];
  [xmlParser kSS3XMLarse:body];
  _multipartUpload = xmlParser.listBuctkResult.multipartUpload;
}

@end
