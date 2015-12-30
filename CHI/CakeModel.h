//
//  CakeModel.h
//  MeiShi
//
//  Created by qianfeng007 on 15/12/15.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface Post_thumbnailModel : JSONModel
@property (nonatomic,copy)NSString<Optional>*url;
@property (nonatomic,copy)NSString<Optional>*width;
@property (nonatomic,copy)NSString<Optional>*height;
@end

@interface LargeModel : JSONModel
@property (nonatomic,copy)NSString<Optional>*url;
@property (nonatomic,copy)NSString<Optional>*width;
@property (nonatomic,copy)NSString<Optional>*height;
@end
@interface MediumModel : JSONModel
@property (nonatomic,copy)NSString<Optional>*url;
@property (nonatomic,copy)NSString<Optional>*width;
@property (nonatomic,copy)NSString<Optional>*height;
@end
@interface ThumbnailModel : JSONModel
@property (nonatomic,copy)NSString<Optional>*url;
@property (nonatomic,copy)NSString<Optional>*width;
@property (nonatomic,copy)NSString<Optional>*height;
@end
@interface FullModel : JSONModel
@property (nonatomic,copy)NSString<Optional>*url;
@property (nonatomic,copy)NSString<Optional>*width;
@property (nonatomic,copy)NSString<Optional>*height;
@end

@interface Thumbnail_imagesModel : JSONModel
@property (nonatomic,strong)FullModel<Optional>*full;
@property (nonatomic,strong)ThumbnailModel<Optional>*thumbnail;
@property (nonatomic,strong)MediumModel<Optional>*medium;
@property (nonatomic,strong)LargeModel<Optional>*large;
@property(nonatomic,strong)Post_thumbnailModel<Optional>*post_thumbnail;
@end

@interface Custom_fieldsModel : JSONModel

@end

@interface AuthorModel : JSONModel
@property (nonatomic,copy)NSString<Optional>*id;
@property (nonatomic,copy)NSString<Optional>*slug;
@property (nonatomic,copy)NSString<Optional>*name;
@property (nonatomic,copy)NSString<Optional>*first_name;
@property (nonatomic,copy)NSString<Optional>*last_name;
@property (nonatomic,copy)NSString<Optional>*nickname;
@property (nonatomic,copy)NSString<Optional>*url;
@property (nonatomic,copy)NSString<Optional>*description;
@end

@protocol CategoriesModel

@end
@interface CategoriesModel : JSONModel
@property (nonatomic,copy)NSString<Optional>*id;
@property (nonatomic,copy)NSString<Optional>*slug;
@property (nonatomic,copy)NSString<Optional>*title;
@property (nonatomic,copy)NSString<Optional>*description;
@property (nonatomic,copy)NSString<Optional>*parent;
@property (nonatomic,copy)NSString<Optional>*post_count;


@end

@interface TagsModel : JSONModel

@end
@protocol TagsModel


@end


@protocol AttachmentsModel

@end
@interface AttachmentsModel : JSONModel

@end

@protocol CommentsModel


@end

@interface CommentsModel : JSONModel

@end

@protocol PostsModel

@end
@interface PostsModel : JSONModel
@property (nonatomic,copy)NSString<Optional>*id;
@property (nonatomic,copy)NSString<Optional>*type;
@property (nonatomic,copy)NSString<Optional>*slug;
@property (nonatomic,copy)NSString<Optional>*url;
@property (nonatomic,copy)NSString<Optional>*status;
@property (nonatomic,copy)NSString<Optional>*title;
@property (nonatomic,copy)NSString<Optional>*title_plain;
@property (nonatomic,copy)NSString<Optional>*content;
@property (nonatomic,copy)NSString<Optional>*excerpt;
@property (nonatomic,copy)NSString<Optional>*date;
@property (nonatomic,copy)NSString<Optional>*modified;
@property (nonatomic,strong)NSMutableArray<TagsModel,Optional>*tags;
@property (nonatomic,strong)NSMutableArray<CommentsModel,Optional>*comments;
@property (nonatomic,strong)NSMutableArray<AttachmentsModel,Optional>*attachments;
@property (nonatomic,copy)NSString<Optional>*comment_count;
@property (nonatomic,copy)NSString<Optional>*comment_status;
@property (nonatomic,copy)NSString<Optional>*thumbnail;
@property (nonatomic,copy)NSString<Optional>*thumbnail_size;
@property (nonatomic,strong)NSMutableArray<CategoriesModel,Optional>*categories;
@property (nonatomic,strong)AuthorModel<Optional>*author;
@property (nonatomic,strong)Custom_fieldsModel<Optional>*custom_fields;

@property (nonatomic,strong)Thumbnail_imagesModel<Optional>*thumbnail_images;

@end

@interface CateagoryModel : JSONModel
@property (nonatomic,copy)NSString<Optional>*id;
@property (nonatomic,copy)NSString<Optional>*slug;
@property (nonatomic,copy)NSString<Optional>*title;
@property (nonatomic,copy)NSString<Optional>*description;
@property (nonatomic,copy)NSString<Optional>*parent;
@property (nonatomic,copy)NSString<Optional>*post_count;
@end
@interface CakeModel : JSONModel
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *count;
@property (nonatomic,copy)NSString *pages;
@property (nonatomic,strong)CateagoryModel *category;
@property (nonatomic,strong)NSMutableArray<PostsModel> *posts;
@end
