//
//  KSS3AccessControlList.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, KingSoftYun_PermissionACLType) {
  KingSoftYun_Permission_Private,
  KingSoftYun_Permission_Public_Read,
  KingSoftYun_Permission_Public_Read_Write,
  KingSoftYun_Permission_Authenticated_Read,

};

@interface KS3AccessControlList : NSObject
@property(strong, nonatomic, nullable) NSString *accessACL;

- (NSString * _Nonnull)setContronAccess:(KingSoftYun_PermissionACLType)aclType;
@end
NS_ASSUME_NONNULL_END
