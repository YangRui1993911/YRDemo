//
//  HealthModel.h
//  CHI
//
//  Created by qianfeng007 on 15/12/17.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol TngouModel

@end
@interface TngouModel : JSONModel
@property (nonatomic,copy)NSString<Optional>*count;
@property (nonatomic,copy)NSString<Optional>*description;
@property (nonatomic,copy)NSString<Optional>*fcount;
@property (nonatomic,copy)NSString<Optional>*food;
@property (nonatomic,copy)NSString<Optional>*ID;
@property (nonatomic,copy)NSString<Optional>*images;
@property (nonatomic,copy)NSString<Optional>*img;
@property (nonatomic,copy)NSString<Optional>*keywords;
@property (nonatomic,copy)NSString<Optional>*name;
@property (nonatomic,copy)NSString<Optional>*rcount;
@end

@interface HealthModel : JSONModel
@property (nonatomic,copy)NSString<Optional>*status;
@property (nonatomic,copy)NSString<Optional>*total;
@property (nonatomic,strong)NSMutableArray<TngouModel,Optional>*tngou;
@end
