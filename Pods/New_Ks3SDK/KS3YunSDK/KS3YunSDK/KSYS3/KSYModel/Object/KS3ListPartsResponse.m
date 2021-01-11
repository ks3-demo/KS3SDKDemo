//
//  KSS3ListPartsResponse.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3ListPartsResponse.h"
#import "KS3ListPartsResultXMLParser.h"

@implementation KS3ListPartsResponse
- (void)processBody {
  NSLog(@"KS3ListPartsResponse  body: %@",
        [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding]);
  KS3ListPartsResultXMLParser *xmlParser =
      [[KS3ListPartsResultXMLParser alloc] init];
  [xmlParser kSS3XMLarse:body];
  _listResult = xmlParser.listPartsResult;
}
@end
