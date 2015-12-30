//
//  HealthDetailModel.h
//  CHI
//
//  Created by qianfeng007 on 15/12/17.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface HealthDetailModel : JSONModel
@property (nonatomic,copy)NSString <Optional>*count;
@property (nonatomic,copy)NSString <Optional>*description;
@property (nonatomic,copy)NSString <Optional>*fcount;
@property (nonatomic,copy)NSString <Optional>*food;
@property (nonatomic,copy)NSString <Optional>*id;
@property (nonatomic,copy)NSString <Optional>*images;
@property (nonatomic,copy)NSString <Optional>*img;
@property (nonatomic,copy)NSString <Optional>*keywords;
@property (nonatomic,copy)NSString <Optional>*message;
@property (nonatomic,copy)NSString <Optional>*name;
@property (nonatomic,copy)NSString <Optional>*rcount;
@property (nonatomic,copy)NSString <Optional>*status;
@property (nonatomic,copy)NSString <Optional>*url;

@end
