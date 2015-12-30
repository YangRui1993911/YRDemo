//
//  NewsViewController.m
//  CHI
//
//  Created by qianfeng007 on 15/12/17.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsModel.h"
#import "NewsCell.h"
#import "NewsDetailViewController.h"
#import <MJRefresh/MJRefresh.h>
#import <AFNetworking/AFNetworking.h>

#import "NSString+Common.h"
#import "JWCache.h"
#import <MBProgressHUD/MBProgressHUD.h>

//小知识页面
//#define NEWSURL(page) @"http://ibaby.ipadown.com/api/food/food.tips.list.php?keywords=%E7%B3%95&p=%ld&pagesize=20&from=com.ipadown.mwgd&version=3.0"
#define NEWSURL @"http://ibaby.ipadown.com/api/food/food.tips.list.php"
//小知识详情
#define NEWSDETAILURL @"http://ibaby.ipadown.com/api/food/food.tips.detail.php?id=%@"

@interface NewsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;

}
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"趣味知识";
    
    //    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background"]];
    //    self.view = imageView;
    _dataArray = [[NSMutableArray alloc]init];
    [self createTabelView];
}
- (void)createTabelView
{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDataFromNet:NO];
    }];
    _tableView.mj_header = header;
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadDataFromNet:YES];
    }];
    _tableView.mj_footer = footer;
    [_tableView.mj_header beginRefreshing];
    
}
- (void)loadDataFromNet:(BOOL)isMore
{
    NSInteger page = 1;
    NSString *urlString = nil;
    if (isMore) {
        if (_dataArray.count%20==0) {
            page = _dataArray.count/20+1;
            
        }else{
            return;
        }
    }
    urlString = [NSString stringWithFormat:@"%@",NEWSURL];
    NSString *pageString = [NSString stringWithFormat:@"%ld",page];
    NSDictionary *dict = @{@"keywords":@"糕",@"p":pageString,@"pagesize":@"20",@"from":@"com.ipadown.mwgd",@"version":@"3.0"};
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    //判断有没有缓存
    NSData *cacheData = [JWCache objectForKey:MD5Hash(urlString)];
    if (cacheData) {
        NewsModel *model = [[NewsModel alloc]initWithData:cacheData error:nil];
        if (isMore) {
            [_dataArray addObjectsFromArray:model.results];
        }else{
            [_dataArray removeAllObjects];
            [_tableView reloadData];
            _dataArray = model.results;
            
        }
        [_tableView reloadData];
        //隐藏Loading提示框
        [MBProgressHUD hideAllHUDsForView:self.view
                                 animated:YES];
        
        isMore?[_tableView.mj_footer endRefreshing]:[_tableView.mj_header endRefreshing];
        return;
    }
    
    
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NewsModel *newsModel = [[NewsModel alloc]initWithData:responseObject error:nil];
        
        if (!isMore) {
            [_dataArray removeAllObjects];
            [_tableView reloadData];
        }
        [_dataArray addObjectsFromArray:newsModel.results];
        
        
        [_tableView reloadData];
        
        //隐藏Loading提示框
        [MBProgressHUD hideAllHUDsForView:self.view
                                 animated:YES];
        isMore?[_tableView.mj_footer endRefreshing]:[_tableView.mj_header endRefreshing];
        //放入缓存
        [JWCache setObject:responseObject forKey:MD5Hash(urlString)];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //隐藏Loading提示框
        [MBProgressHUD hideAllHUDsForView:self.view
                                 animated:YES];
        
        isMore?[_tableView.mj_footer endRefreshing]:[_tableView.mj_header endRefreshing];
        
        
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellIdentifier";
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    [cell updateModel:_dataArray[indexPath.row] index:indexPath.row];
//    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Newscellbackground"]];
//    imageView.alpha = 0.6;
//    cell.backgroundView = imageView;
    cell.backgroundColor = [UIColor colorWithRed:255/256.0 green:250/256.0 blue:240/256.0 alpha:1.0];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsDetailViewController *dvc = [[NewsDetailViewController alloc]init];
    ResultModel *model = _dataArray[indexPath.row];
    NSString *url = [NSString stringWithFormat:NEWSDETAILURL,model.ID];
    [dvc setUrlString:url];
    [self.navigationController pushViewController:dvc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
