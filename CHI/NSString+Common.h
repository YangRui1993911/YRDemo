//
//  NSString+Common.h
//  IFreeIos
//
//  Created by qianfeng007 on 15/12/10.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Common)
NSString * URLEncodedString(NSString *str) ;

NSString * MD5Hash(NSString *aString);
@end
