//
//  KSS3GrantAccessControlList.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 Blues. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
typedef enum {
  KingSoftYun_Grant_Permission_Read,
  KingSoftYun_Grant_Permission_Write,
  KingSoftYun_Grant_Permission_Read_ACP,
  KingSoftYun_Grant_Permission_Write_ACP,
  KingSoftYun_Grant_Permission_Full_Control,
} KingSoftYun_GrantPermissionACLType;

@interface KS3GrantAccessControlList : NSObject

@property(strong, nonatomic, nullable) NSString *accessGrantACL;
@property(strong, nonatomic, nullable) NSString *identifier;
@property(strong, nonatomic, nullable) NSString *displayName;

- (NSString * _Nonnull)setGrantControlAccess:
    (KingSoftYun_GrantPermissionACLType)grantAclType;

@end
NS_ASSUME_NONNULL_END
