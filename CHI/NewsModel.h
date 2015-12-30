//
//  NewsModel.h
//  MeiShi
//
//  Created by qianfeng007 on 15/12/16.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol ResultModel

@end
@interface ResultModel : JSONModel
@property (nonatomic,copy)NSString <Optional>*ID;
@property (nonatomic,copy)NSString <Optional>*tags;
@property (nonatomic,copy)NSString <Optional>*title;
@property (nonatomic,copy)NSString <Optional>*views;
@end
@interface NewsModel : JSONModel
@property (nonatomic,copy)NSString <Optional>*resultCount;
@property (nonatomic,strong)NSMutableArray <ResultModel,Optional>*results;
@property (nonatomic,copy)NSString <Optional>*totalCount;
@property (nonatomic,copy)NSString <Optional>*pagesize;
@property (nonatomic,copy)NSString <Optional>*totalpage;
@property (nonatomic,copy)NSString <Optional>*nowpage;
@end
