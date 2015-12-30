//
//  HealthViewController.m
//  CHI
//
//  Created by qianfeng007 on 15/12/17.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import "HealthViewController.h"
#import "HealthDetailViewController.h"
#import <MJRefresh/MJRefresh.h>
#import <AFNetworking/AFNetworking.h>
#import "HealthModel.h"
#import "HealthCell.h"
#import "JWCache.h"
#import "NSString+Common.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "HealthDetailModel.h"
#define HEALTHURL(page) @"http://www.tngou.net/api/cook/list?id=10&rows=10&page=%ld"
#define HEALTHDETAILURL @"http://www.tngou.net/api/cook/show?id=%@"
//图片拼接 http://tnfs.tngou.net/image  后加model 里面的img属性

#define VIEW_WIDTH  self.view.frame.size.width
#define VIEW_HEIGHT   self.view.frame.size.height

@interface HealthViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    NSMutableArray *_dataArray;
    NSString *_urlStr;

}
@end

@implementation HealthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [[NSMutableArray alloc]init];
    _urlStr = [[NSString alloc]init];
    //self.view.backgroundColor = [UIColor colorWithRed:207/256.0 green:133/256.0 blue:153/256.0 alpha:1.0];
    //self.view.backgroundColor = [UIColor orangeColor];
    self.view.userInteractionEnabled = YES;
    self.navigationItem.title = @"养生饮食";
    [self createCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    

}
- (UICollectionViewLayout *)createLatout
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 5;
    layout.itemSize = CGSizeMake(VIEW_WIDTH/2-10, 250);
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    return layout;
}
- (void)createCollectionView
{
    CGRect frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
    _collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:[self createLatout]];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor =[UIColor colorWithRed:174/256.0 green:238/256.0 blue:238/256.0 alpha:1.0];
    [_collectionView registerClass:[HealthCell class] forCellWithReuseIdentifier:@"cellID"];
    [self.view addSubview:_collectionView ];
    
    
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDataFromNet:NO];
    }];
    _collectionView.mj_header = header;
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadDataFromNet:YES];
    }];
    _collectionView.mj_footer = footer;
    [_collectionView.mj_header beginRefreshing];
    
    
}
- (void)loadDataFromNet:(BOOL)isMore
{
    
    NSInteger page = 1;
    NSString *urlString = nil;
    
    if (isMore) {
        if (_dataArray.count % 10 == 0) {
            
            page = _dataArray.count/10+1;
            // [_collectionView.mj_footer endRefreshing];
            
        }else{
            return;
        }
        
    }
    urlString = [NSString stringWithFormat:HEALTHURL(page), page];
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    //判断有没有缓存
    NSData *cacheData = [JWCache objectForKey:MD5Hash(urlString)];
    if (cacheData) {
       HealthModel *model = [[HealthModel alloc]initWithData:cacheData error:nil];
        if (isMore) {
            [_dataArray addObjectsFromArray:model.tngou];
        }else{
            [_dataArray removeAllObjects];
            [_collectionView reloadData];
            _dataArray = model.tngou;
            
        }
        [_collectionView reloadData];
        //隐藏Loading提示框
        [MBProgressHUD hideAllHUDsForView:self.view
                                 animated:YES];
        
        isMore?[_collectionView.mj_footer endRefreshing]:[_collectionView.mj_header endRefreshing];
        return;
    }

    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        HealthModel *model = [[HealthModel alloc]initWithData:responseObject error:nil];
        
        
        if (!isMore) {
            [_dataArray removeAllObjects];
            [_collectionView reloadData];
        }
        [_dataArray addObjectsFromArray:model.tngou];
        [_collectionView reloadData];

        //隐藏Loading提示框
        [MBProgressHUD hideAllHUDsForView:self.view
                                 animated:YES];
        
        isMore?[_collectionView.mj_footer endRefreshing]:[_collectionView.mj_header endRefreshing];
        //放入缓存
        [JWCache setObject:responseObject forKey:MD5Hash(urlString)];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //隐藏Loading提示框
        [MBProgressHUD hideAllHUDsForView:self.view
                                 animated:YES];
        
        isMore?[_collectionView.mj_footer endRefreshing]:[_collectionView.mj_header endRefreshing];
        
        
    }];
    
    
    
}
#pragma mark - 数据源代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //NSLog(@"%@",_dataArray);
    return _dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HealthCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    
    //    cell.backgroundColor = [UIColor redColor];
    
    [cell setModel:_dataArray[indexPath.item]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",_urlStr);

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:HEALTHDETAILURL,[_dataArray[indexPath.row] ID]];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        HealthDetailModel *model = [[HealthDetailModel alloc]initWithData:responseObject error:nil];
       
        _urlStr =[NSString stringWithFormat:@"%@",model.url];
        
        HealthDetailViewController *dv = [[HealthDetailViewController alloc]init];
        dv.hidesBottomBarWhenPushed = YES;
        [dv setUrlString:_urlStr];
        
        [self.navigationController pushViewController:dv animated:YES];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    
    
}
//#pragma mark-UICollectionViewDelegateFlowLayout
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    //该方法实现，则布局对象的itemSize属性无效
//    return CGSizeMake(100, 150);
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
