//
//  JWCache.h
//  JWCache
//
//  Created by JackWong on 6/28/12.
//  Copyright (c) 2012 JackWong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface JWCache : NSObject

+ (NSString*) cacheDirectory ;

//清理缓存
+ (void) resetCache;

+ (void) setObject:(NSData*)data forKey:(NSString*)key;

+ (id) objectForKey:(NSString*)key;
+ (CGFloat)fileSize;
@end
