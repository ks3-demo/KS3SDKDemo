//
//  KingSoftURLRequest.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3Credentials.h"
#import <Foundation/Foundation.h>

@interface KS3URLRequest : NSMutableURLRequest
@property(weak, nonatomic) KS3Credentials *credentials;
@end
