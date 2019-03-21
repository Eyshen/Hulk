//
//  HomeViewController.m
//  Hulk
//
//  Created by 张学超 on 2018/10/18.
//  Copyright © 2018年 张学超. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeItemTableViewCell.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *refTableView;
@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.wjNavTitle = @"首页";
    if(_refTableView == nil){
        UITableView *tableview = [[UITableView alloc]initWithFrame:self.view.bounds];
        tableview.delegate = self;
        tableview.dataSource = self;
        [self.wjView addSubview:tableview];
        _refTableView = tableview;
        [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@0);
            make.top.mas_equalTo(@0);
            make.width.mas_equalTo(@(WJ_SCREEN_WIDTH));
            make.height.mas_equalTo(@(WJ_SCREEN_HEIGHT-64-49));//-34-22
        }];
    }
    [self.refTableView registerClass:[HomeItemTableViewCell class] forCellReuseIdentifier:@"HomeItemTableViewCell"];
    
    [self.refTableView reloadData];
}
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    
}

#pragma mark UITableViewDataSource
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WJ_SCREEN_WIDTH, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WJ_SCREEN_WIDTH, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeItemTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"HomeItemTableViewCell"];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 375, 100)];
    descLabel.text = @"cell   cell    cell    cell";
    descLabel.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:descLabel];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




@end
