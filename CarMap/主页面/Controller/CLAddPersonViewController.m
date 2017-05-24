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
    
    NSInteger _flage;       //收藏距离切换
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
    
//    UIButton *button1 = [[UIButton alloc]init];
//    [button1 setTitle:@"距离" forState:UIControlStateNormal];
//    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.view addSubview:button1];
//    button1.frame = CGRectMake(-1, 64, self.view.frame.size.width/2+1, 30);
//    button1.layer.borderWidth = 0.5;
//    button1.layer.borderColor = [UIColor blackColor].CGColor;
//    button1.titleLabel.font = [UIFont systemFontOfSize:15];
//    
//    UIButton *button2 = [[UIButton alloc]init];
//    [button2 setTitle:@"收藏" forState:UIControlStateNormal];
//    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.view addSubview:button2];
//    button2.frame = CGRectMake(self.view.frame.size.width/2, 64, self.view.frame.size.width/2+1, 30);
//    button2.alpha = 0.5;
//    button2.layer.borderWidth = 0.5;
//    button2.layer.borderColor = [UIColor blackColor].CGColor;
//    button2.titleLabel.font = [UIFont systemFontOfSize:15];
    
    _searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(20, 74, self.view.frame.size.width-100, 30)];
//    searchbar.backgroundColor = [UIColor whiteColor];
    _searchbar.barTintColor = [UIColor whiteColor];
//    searchbar.barStyle = UIBarStyleDefault;
    _searchbar.layer.cornerRadius = 15;
    _searchbar.layer.borderWidth = 1.0;
    _searchbar.layer.borderColor = [[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]CGColor];
    
    [self.view addSubview:_searchbar];
    _searchbar.delegate = self;
    _searchbar.clipsToBounds = YES;
    
    
    UIButton *searchButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-80, 74 , 60, 30)];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [searchButton addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    searchButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:searchButton];
    
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.frame = CGRectMake(0, 110 , self.view.frame.size.width, self.view.frame.size.height-110);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 添加刷新
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefreshDo)];
    _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefreshDo)];
    [self.view addSubview:_tableView];
    
    [_tableView.header beginRefreshing];
}

- (void)getCollectList{
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    mDic[@"page"] = @(_page);
    mDic[@"pageSize"] = @(_pageSize);
    if (_searchbar.text.length > 0) {
        mDic[@"query"] = _searchbar.text;
    }
    
    [GFHttpTool favoriteTechnicianGetWithParameters:mDic success:^(id responseObject) {
        ICLog(@"===%@", responseObject);
        NSArray *arr = responseObject[@"list"];
        for(int i=0; i<arr.count; i++) {
            NSDictionary *dic = arr[i];
            CLAddPersonModel *model = [[CLAddPersonModel alloc] initWithDictionary:dic[@"technician"]];
            [self.modelArr addObject:model];
        }
        
        [_tableView reloadData];
        
        
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
        
    } failure:^(NSError *error) {
        
        
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
    }];
}

#pragma mark - 获取按照距离排序的技师列表
- (void)getDistanceList {
    
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    mDic[@"page"] = @(_page);
    mDic[@"pageSize"] = @(_pageSize);
    if (_searchbar.text.length > 0) {
        mDic[@"query"] = _searchbar.text;
    }
    
    [GFHttpTool jishiListGetWithParameters:mDic success:^(id responseObject) {
        if([responseObject[@"status"] integerValue] == 1) {
            
            NSDictionary *dic = responseObject[@"message"];
            NSArray *arr = dic[@"content"];
            ICLog(@"===%@", arr);
            for(int i=0; i<arr.count; i++) {
            
                CLAddPersonModel *model = [[CLAddPersonModel alloc] initWithDictionary:arr[i]];
                [self.modelArr addObject:model];
                model.orderID = _orderId;
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

#pragma mark - 获取模糊搜索的技师列表
- (void)getSearchList {
    
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    mDic[@"page"] = @(_page);
    mDic[@"pageSize"] = @(_pageSize);
    if (_searchbar.text.length > 0) {
        mDic[@"query"] = _searchbar.text;
    }
    
    [GFHttpTool jishiMohuGetWithParameters:mDic success:^(id responseObject) {
        if([responseObject[@"status"] integerValue] == 1) {
            
            NSDictionary *dic = responseObject[@"message"];
            NSArray *arr = dic[@"content"];
            ICLog(@"===%@", arr);
            for(int i=0; i<arr.count; i++) {
                
                CLAddPersonModel *model = [[CLAddPersonModel alloc] initWithDictionary:arr[i]];
                [self.modelArr addObject:model];
                model.orderID = _orderId;
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
    
    _page = 1;
    self.modelArr = [[NSMutableArray alloc] init];
    
    if (_flage == 0) {
        if (_searchbar.text.length > 0) {
            [self getSearchList];
        }else{
            [self getDistanceList];
        }
        _tableView.frame = CGRectMake(0, 110 , self.view.frame.size.width, self.view.frame.size.height-110);
    }else{
        [self getCollectList];
        _tableView.frame = CGRectMake(0, 64 , self.view.frame.size.width, self.view.frame.size.height-110);
    }
    
    
}

- (void)footRefreshDo {
    
    _page++;
    if (_flage == 0) {
        if (_searchbar.text.length > 0) {
            [self getSearchList];
        }else{
            [self getDistanceList];
        }
    }else{
        [self getCollectList];
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
        model.orderID = _orderId;
        cell.model = model;
//        NSLog(@"---老天保佑---%@", model.distance);
        if (_flage == 0) {//所有
            cell.danshuLab.hidden = NO;
            cell.jvliImgView.hidden = NO;
            cell.jvliLab.hidden = NO;
        }else{// 收藏
            cell.danshuLab.hidden = YES;
            cell.jvliImgView.hidden = YES;
            cell.jvliLab.hidden = YES;
        }
        
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
    
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:@" " withRightImgHightName:@"收藏" withCenterTitle:@"指定技师" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView.rightBut addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    navView.rightBut.titleLabel.font = [UIFont systemFontOfSize:15];
    [navView.rightBut setTitle:@"收藏" forState:UIControlStateNormal];
    [navView.rightBut setTitle:@"距离" forState:UIControlStateSelected];
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
- (void)moreBtnClick:(UIButton *)button{
    
    button.selected = !button.selected;
    if (button.selected) {
        _flage = 1;
    }else{
        _flage = 0;
    }
    [_tableView.header beginRefreshing];
    
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
