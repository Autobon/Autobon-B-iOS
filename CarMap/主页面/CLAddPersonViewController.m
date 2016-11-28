//
//  CLAddPersonViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/25.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLAddPersonViewController.h"
#import "GFNavigationView.h"
#import "CLPersonTableViewCell.h"
#import "GFHttpTool.h"
#import "CLAddPersonModel.h"
#import "UIImageView+WebCache.h"
#import "GFTipView.h"
#import "MJRefresh.h"
#import "GFDetailPeoViewController.h"



//@interface UITableView (touch)
//
//@end
//
//@implementation UITableView (touch)
//
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    [[self superview] endEditing:YES];
//}
//
//@end


@interface CLAddPersonViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UISearchBar *_searchbar;
    NSMutableArray *_addPersonArray;
    UITableView *_tableView;
    
    BOOL _isAdd;
    
    
    NSInteger _page;
    NSInteger _pageSize;
    
    NSInteger _flage;
}

@property (nonatomic, strong) NSMutableArray *modelArr;

@end

@implementation CLAddPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _page = 1;
    _pageSize = 10;
    _flage = 0;
    
    self.modelArr = [[NSMutableArray alloc] init];
    
    _addPersonArray = [[NSMutableArray alloc]init];
    
    [self setNavigation];
    
    [self setViewForAdd];
    
    self.view.backgroundColor = [UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1.0];
}

- (void)setViewForAdd{
    _searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(20, 84, self.view.frame.size.width-100, 40)];
//    searchbar.backgroundColor = [UIColor whiteColor];
    _searchbar.barTintColor = [UIColor whiteColor];
//    searchbar.barStyle = UIBarStyleDefault;
    _searchbar.layer.cornerRadius = 20;
    _searchbar.layer.borderWidth = 1.0;
    _searchbar.layer.borderColor = [[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]CGColor];
    
    [self.view addSubview:_searchbar];
    _searchbar.delegate = self;
    _searchbar.clipsToBounds = YES;
    
    
    UIButton *searchButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-80, 84, 60, 40)];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [searchButton addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchButton];
    
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.frame = CGRectMake(0, 124, self.view.frame.size.width, self.view.frame.size.height-124);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 添加刷新
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefreshDo)];
    _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefreshDo)];
    [self.view addSubview:_tableView];
    
    [_tableView.header beginRefreshing];
}

- (void)httpWork {
    
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    mDic[@"page"] = @(_page);
    mDic[@"pageSize"] = @(_pageSize);
    
    [GFHttpTool jishiListGetWithParameters:mDic success:^(id responseObject) {
        
        NSLog(@"====技师列表数据====%@", responseObject);
        if([responseObject[@"status"] integerValue] == 1) {
            
            NSDictionary *dic = responseObject[@"message"];
            NSArray *arr = dic[@"content"];
            NSLog(@"===%@", arr);
            for(int i=0; i<arr.count; i++) {
            
                CLAddPersonModel *model = [[CLAddPersonModel alloc] initWithDictionary:arr[i]];
                [self.modelArr addObject:model];
                model.orderID = _orderId;
                
                NSLog(@"-每个模型--%@", model.orderCount);
            }
            
            [_tableView reloadData];
        }
        
        
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
        
    } failure:^(NSError *error) {
        
        
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
    }];
}
- (void)httpWork2 {
    
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    mDic[@"query"] = _searchbar.text;
    mDic[@"page"] = @(_page);
    mDic[@"pageSize"] = @(_pageSize);
    
    [GFHttpTool jishiMohuGetWithParameters:mDic success:^(id responseObject) {
        
        NSLog(@"====++++%@", responseObject);
        if([responseObject[@"status"] integerValue] ==1) {
            NSDictionary *dic = responseObject[@"message"];
            NSArray *arr = dic[@"content"];
            NSLog(@"===%@", arr);
            for(int i=0; i<arr.count; i++) {
                
                CLAddPersonModel *model = [[CLAddPersonModel alloc] initWithDictionary:arr[i]];
                model.orderID = _orderId;
                [self.modelArr addObject:model];
                
                NSLog(@"-每个模型--%@", model.orderCount);
            }
            
            [_tableView reloadData];
        }
        
        
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
        
    } failure:^(NSError *error) {
        
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
    }];
}

- (void)headRefreshDo {
    
    if(_flage == 0) {
        
        _page = 1;
        self.modelArr = [[NSMutableArray alloc] init];
        [self httpWork];
    }else {
        
        _page = 1;
        self.modelArr = [[NSMutableArray alloc] init];
        [self httpWork2];
    }
}

- (void)footRefreshDo {
    
    
    if(_flage == 0) {
        
        _page++;
        
        [self httpWork];
    }else {
        
        _page++;
        [self httpWork2];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    
    return self.modelArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 125;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CLPersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[CLPersonTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    }
    
    if(self.modelArr.count > indexPath.row) {
    
        CLAddPersonModel *model = (CLAddPersonModel *)self.modelArr[indexPath.row];
        cell.model = model;
        NSLog(@"---老天保佑---%@", model.distance);
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GFDetailPeoViewController *VC = [[GFDetailPeoViewController alloc] init];
    VC.model = self.modelArr[indexPath.row];
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - 指定技师按钮
- (void)addPersonBtnClick:(UIButton *)button {

    CLAddPersonModel *person = _addPersonArray[button.tag];
//    NSLog(@"---指定技师---dictionary----%@------%@-",_orderId,person.personId);
    
    NSDictionary *dic = @{@"orderId":_orderId,@"techId":person.personId};
   
//    NSLog(@"---指定技师---dictionary----%@--",dic);
    
    [GFHttpTool postAppintTechForOrder:dic Success:^(NSDictionary *responseObject) {
//         NSLog(@"－－－%@--",responseObject);
        if ([responseObject[@"result"]integerValue]==1) {
            [self addAlertView:@"指派已完成"];
            _isAdd = YES;
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [self addAlertView:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
//       [self addAlertView:@"请求失败"];
    }];
    
     
}

- (void)searchBtnClick{
    //    NSLog(@"搜索按钮被点击了");
    [self.view endEditing:YES];
    
    
    _flage = 1;
    [_tableView.header beginRefreshing];
    
    /*
    [GFHttpTool getSearch:_searchbar.text Success:^(NSDictionary *responseObject) {
        if ([responseObject[@"result"]integerValue] == 1) {
            NSDictionary *dataDic = responseObject[@"data"];
            NSArray *listArray = dataDic[@"list"];
            [_addPersonArray removeAllObjects];
            if (listArray.count>0) {
                [listArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                    CLAddPersonModel *person = [[CLAddPersonModel alloc]init];
                    
                    extern NSString* const URLHOST;
                    if (![obj[@"avatar"] isKindOfClass:[NSNull class]] && ![obj[@"name"] isKindOfClass:[NSNull class]]) {
                        person.headImageURL = [NSString stringWithFormat:@"%@/%@",URLHOST,obj[@"avatar"]];
                        person.nameString = obj[@"name"];
                    }
                    person.phoneString = obj[@"phone"];
                    person.personId = obj[@"id"];
                    [_addPersonArray addObject:person];
                }];
                
            }else{
                [self addAlertView:@"技师不存在"];
            }
            [_tableView reloadData];
        }else{
            [self addAlertView:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        
        //        NSLog(@"-------查询技师失败－－－%@---",error);
        //
        //        [self addAlertView:@"请求失败"];
    }];
    */
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self searchBtnClick];
}

// 添加导航
- (void)setNavigation{
    
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"车邻邦" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [navView.rightBut addTarget:navView action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navView];
    
    
}
- (void)backBtnClick{
    /*
    if (_isAdd) {
        CLHomeOrderViewController *homeOrder = self.navigationController.viewControllers[0];
        [homeOrder headRefresh];
    }
     */
     
    [self.navigationController popViewControllerAnimated:YES];
    
}
// 更多按钮的响应方法
- (void)moreBtnClick{
//    NSLog(@"更多");
}

#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
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
