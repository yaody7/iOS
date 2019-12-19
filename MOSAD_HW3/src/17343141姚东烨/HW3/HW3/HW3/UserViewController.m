//
//  UserViewController.m
//  HW3
//
//  Created by ydy on 2019/10/7.
//  Copyright © 2019 ydy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserViewController.h"

@interface UserViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIButton* button;
@property(nonatomic,strong)UISegmentedControl* seg;
@property (nonatomic) UITableView *leftTable;
@property (nonatomic)UITableView *rightTable;
@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //UIButton
    self.button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.button.frame=CGRectMake(0.5*(self.view.frame.size.width-110), 0.25*self.view.frame.size.height,110,110);
    self.button.backgroundColor=[UIColor blueColor];
    self.button.layer.cornerRadius=55;
    self.button.titleLabel.font=[UIFont systemFontOfSize:40];
    [self.button setTitle:@"Login" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.button setTintColor:[UIColor whiteColor]];
    [self.view addSubview:self.button];
    

    
    //UISeg
    NSArray *array=[NSArray arrayWithObjects:@"用户信息",@"用户设置", nil];
    self.seg=[[UISegmentedControl alloc]initWithItems:array];
    self.seg.tintColor=[UIColor blueColor];
    self.seg.frame=CGRectMake(0,0.4*self.view.frame.size.height, self.view.frame.size.width,30);
    self.seg.selectedSegmentIndex = 0;
    self.seg.backgroundColor=[UIColor whiteColor];
    [self.seg addTarget:self action:@selector(segmentedChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.seg];
    [self.navigationItem setTitleView:self.seg];
    
    //Tableview
    _leftTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0.48*self.view.frame.size.height, self.view.frame.size.width, 500) style: UITableViewCellStyleValue1];
    _leftTable.delegate=self;
    _leftTable.dataSource=self;
 //   [_leftTable registerNib:[UINib nibWithNibName:@"AnswerCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AnswerReuseId"];
    _leftTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_leftTable];
    
    _rightTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0.48*self.view.frame.size.height, self.view.frame.size.width, 500) style: UITableViewCellStyleValue1];
    _rightTable.delegate = self;
    _rightTable.dataSource = self;
 //   [_rightTable registerNib:[UINib nibWithNibName:@"AnswerCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AnswerReuseId"];
    _rightTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_rightTable];
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.seg.selectedSegmentIndex==0){
        
        //判断队列里面是否有这个cell 没有自己创建，有直接使用
        UITableViewCell*cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell1"];
        if(indexPath.row==0){
            [cell.textLabel setText:@"用户名"];
            
            [cell.detailTextLabel
             setTextColor:[UIColor
                           colorWithWhite:0.52
                           alpha:1.0]];
            
            [cell.detailTextLabel
             setText:@"未输入"];

        }
        else{
            cell.textLabel.text=@"邮箱";
            [cell.detailTextLabel
             setTextColor:[UIColor
                           colorWithWhite:0.52
                           alpha:1.0]];
            
            [cell.detailTextLabel
             setText:@"未输入"];

        }
        return cell;
    }
    else{
        UITableViewCell*cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
        
    
        if(indexPath.row==0){
            cell.textLabel.text = @"返回语言选择";
            cell.textLabel.textAlignment=NSTextAlignmentCenter;
            [cell.detailTextLabel
             setTextColor:[UIColor
                           colorWithWhite:0.52
                           alpha:1.0]];
            
        }
        else{
            cell.textLabel.text=@"退出登录";
            cell.textLabel.textAlignment=NSTextAlignmentCenter;
            [cell.detailTextLabel
             setTextColor:[UIColor
                           colorWithWhite:0.52
                           alpha:1.0]];
            


        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.seg.selectedSegmentIndex==1){
        if(indexPath.row==0){
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}

-(void)segmentedChanged:(UISegmentedControl*)sender{
    UISegmentedControl*control=(UISegmentedControl*)sender;
    NSInteger selectIndex=sender.selectedSegmentIndex;
    switch (selectIndex) {
        case 0:
            _leftTable.hidden=NO;
            _rightTable.hidden=YES;
            sender.selectedSegmentIndex=0;
            [_leftTable reloadData];
            break;
        case 1:
            _rightTable.hidden=NO;
            _leftTable.hidden=YES;
            sender.selectedSegmentIndex=1;
            [_rightTable reloadData];
            break;
        default:
            break;
    }
}
     
@end
