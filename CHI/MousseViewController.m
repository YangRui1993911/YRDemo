//
//  MousseViewController.m
//  CHI
//
//  Created by qianfeng007 on 15/12/17.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import "MousseViewController.h"
#import "CakeDetailViewController.h"
#import "CakeCell.h"
#import "CakeModel.h"
#import <AFNetworking/AFNetworking.h>
#import <MJRefresh/MJRefresh.h>
#import "NSString+Common.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "JWCache.h"


//慕斯
#define MOUSSEURL(page) @"http://shang.e9china.net/api/?json=get_category_posts&id=18&page=%ld"

@interface MousseViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}
@end

@implementation MousseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"美味西饼";
    //    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MousseBackground"]];
    //    self.view = imageView;
    self.view.userInteractionEnabled = YES;
    _dataArray = [[NSMutableArray alloc]init];
    [self createTableView];
}
- (void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
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
        if (_dataArray.count%10==0) {
            page = _dataArray.count/10+1;
            
        }else{
            return;
        }
    }
    urlString = [NSString stringWithFormat:MOUSSEURL(page),page];
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    //判断有没有缓存
    NSData *cacheData = [JWCache objectForKey:MD5Hash(urlString)];
    if (cacheData) {
        CakeModel *model = [[CakeModel alloc]initWithData:cacheData error:nil];
        if (isMore) {
            [_dataArray addObjectsFromArray:model.posts];
        }else{
            [_dataArray removeAllObjects];
            [_tableView reloadData];
            _dataArray = model.posts;
            
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
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        CakeModel *cakeModel = [[CakeModel alloc]initWithData:responseObject error:nil];
        if (!isMore) {
            [_dataArray removeAllObjects];
            [_tableView reloadData];
        }
        [_dataArray addObjectsFromArray:cakeModel.posts];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellIdentifier";
    CakeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[CakeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"moussecellbackground"]];
    imageView.alpha = 0.5;
    cell.backgroundView = imageView;
    cell.model = _dataArray[indexPath.row];
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    imageView.image = [UIImage imageNamed:@"mousseheadview"];
    return imageView;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 150;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CakeDetailViewController *dvc = [[CakeDetailViewController alloc]init];
    PostsModel *postModel = _dataArray[indexPath.row];
    NSString *url = postModel.url;
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
