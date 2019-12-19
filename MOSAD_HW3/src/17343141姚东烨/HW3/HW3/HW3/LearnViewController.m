//
//  LearnViewController.m
//  HW3
//
//  Created by ydy on 2019/10/6.
//  Copyright © 2019 ydy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LearnViewController.h"

@interface LearnViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) UITableView *tableView;
@property (nonatomic,copy) NSMutableArray *dataSourceArray;
@property (nonatomic,copy) NSMutableArray *nameSourceArray;
@end

@implementation LearnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
}

//配置每个section(段）有多少row（行） cell
//默认只有一个section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 8;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"TOUR %d",section+1];
}
//每行显示什么东西
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //给每个cell设置ID号（重复利用时使用）
    static NSString *cellID = @"cellID";
    
    //从tableView的一个队列里获取一个cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    //判断队列里面是否有这个cell 没有自己创建，有直接使用
    if (cell == nil) {
        //没有,创建一个
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    //使用cell
    cell.textLabel.text = [NSString stringWithFormat:@"unit %d",indexPath.row+1];
    return cell;
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
@end
