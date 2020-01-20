//
//  ListView.m
//  FinalProject
//
//  Created by lucky_li on 2019/12/16.
//  Copyright © 2019 lucky_li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListView.h"
#import "Listcell.h"

@interface ListView ()<UITableViewDelegate, UITableViewDataSource, NSURLSessionDataDelegate>

@end

@implementation ListView

- (void)viewDidLoad {
    
    NSLog(@" got name %@", _username);
    _heightcollection =[NSMutableArray array];
    _data1 =[NSMutableArray array];
    _data2 =[NSMutableArray array];
    _myids = [NSMutableArray array];
    for(int i=0 ;i< 100;i++){
        [_heightcollection addObject:[NSNumber numberWithFloat:0.00]];
        [_data1 addObject:@""];
        [_data2 addObject:@""];
        [_myids addObject:@""];
    }
    [_ut reloadData];
    NSLog(@"i am there:%@",_data1);
    
    [_ut registerClass:[Listcell class] forCellReuseIdentifier:@"listcell"];
    
    for( NSString *strFamilyName in [UIFont familyNames] ) {
        for( NSString *strFontName in [UIFont fontNamesForFamilyName:strFamilyName] ) {
            NSLog(@"%@", strFontName);
        }
    }
    
    self.navigationItem.title = @"";
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setValue:@(YES) forKeyPath:@"hidesShadow"];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    UILabel *Label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 90)];
    Label1.font = [UIFont fontWithName:@"DINCondensed-Bold" size:36];
    Label1.textColor=[UIColor colorWithRed:100.0f/255.0f
                                     green:149.0f/255.0f
                                      blue:237.0f/255.0f
                                     alpha:1.0f];
    Label1.text = @" Remainder";
    [self.view addSubview:Label1];
    self.navigationController.toolbarHidden = YES;
    
    
    UIButton *addbutton=[[UIButton alloc] init];
    addbutton.frame=CGRectMake(10, 760, 32, 30);
    //    addbutton.backgroundColor=[UIColor redColor];
    [addbutton setImage:[UIImage imageNamed:@"buttonimg.jpg"] forState:UIControlStateNormal];
    addbutton.adjustsImageWhenHighlighted=NO;
    [addbutton addTarget:self
                  action:@selector(add)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addbutton];
    
    UILabel *addlabel = [[UILabel alloc] init ];
    addlabel.frame=CGRectMake(50, 765, 200, 30);
    addlabel.text=@"New issue";
    addlabel.font = [UIFont fontWithName:@"DINCondensed-Bold" size:24];
    addlabel.textColor=[UIColor colorWithRed:100.0f/255.0f
                                       green:149.0f/255.0f
                                        blue:237.0f/255.0f
                                       alpha:1.0f];
    [self.view addSubview:addlabel];
    
    _input1 = [[UITextField alloc] init ];
    _input1.frame=CGRectMake(150, 762, 80, 30);
    _input1.layer.cornerRadius=5;
    _input1.backgroundColor=[UIColor colorWithRed:230.0f/255.0f
                                            green:230.0f/255.0f
                                             blue:230.0f/255.0f
                                            alpha:1.0f];
    _input1.font = [UIFont fontWithName:@"DINCondensed-Bold" size:24];
    _input1.textColor=[UIColor colorWithRed:100.0f/255.0f
                                      green:149.0f/255.0f
                                       blue:237.0f/255.0f
                                      alpha:1.0f];
    
    _input2 = [[UITextField alloc] init ];
    _input2.frame=CGRectMake(240, 762, 135, 30);
    _input2.layer.cornerRadius=5;
    _input2.backgroundColor=[UIColor colorWithRed:230.0f/255.0f
                                            green:230.0f/255.0f
                                             blue:230.0f/255.0f
                                            alpha:1.0f];
    _input2.font = [UIFont fontWithName:@"DINCondensed-Bold" size:24];
    _input2.textColor=[UIColor colorWithRed:100.0f/255.0f
                                      green:149.0f/255.0f
                                       blue:237.0f/255.0f
                                      alpha:1.0f];
    
    
    [self.view addSubview:_input1];
    [self.view addSubview:_input2];
    
    //Set your tabBar items to the new array
    
    
    _ut=[[[UITableView alloc] init] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    _ut.backgroundColor=[UIColor whiteColor];
    _ut.frame=self.view.bounds;
    CGRect frame = _ut.frame;
    frame.origin.y = frame.origin.y + 80;
    frame.size.height = frame.size.height - 230;
    _ut.frame = frame;
    _ut.dataSource=self;
    _ut.delegate=self;
    _ut.allowsMultipleSelection=YES;
    _ut.separatorColor = [UIColor clearColor];
    _ut.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_ut];
    
    
    UIImage *myimg1 = [UIImage imageNamed:@"buttonimg.jpg"];
    if (myimg1 == nil){
        NSLog(@"nil");
    }
    else{
        NSLog(@"none nil");
    }
    [self getinfo];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setToolbarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setToolbarHidden:NO];
}

- (void) add{
    NSString *input1 = _input1.text;
    NSString *input2 = _input2.text;
    NSLog(@"input was '%@' and '%@'", input1, input2);
    NSLog(@"add here");
    if([input1 isEqualToString:@""]){
        return;
    }
    if([input2 isEqualToString:@""]){
        return;
    }
    [_heightcollection  replaceObjectAtIndex:0 withObject:[NSNumber numberWithFloat:50.00]];
    [_ut reloadData];
    
    
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    
    NSString *tstring = [NSString stringWithFormat:@"http://localhost:8001/api/user/%@/todo", _username];
    
    NSURL * url = [NSURL URLWithString:tstring];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    
    // 设置请求体为JSON
    NSDictionary *dic = @{@"taskname": _input1.text, @"deadline": _input2.text};
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [urlRequest setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[delegateFreeSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"Response:%@ %@\n", response, error);
        if(error == nil) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"xxx: %@",[dict objectForKey:@"status"]);
            if([[dict objectForKey:@"status"] isEqual:@"success"]){
                [self->_data1 replaceObjectAtIndex:[self->_mytotal intValue] withObject:self->_input1.text];
                [self->_data2 replaceObjectAtIndex:[self->_mytotal intValue] withObject:self->_input2.text];
                [self getinfo];
            }
        }
    }];
    [dataTask resume];
}

- (void) minusSign{
    NSLog(@"he");
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    Listcell *m=[[Listcell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"listcell"];
    if (nil==m){
        m=(Listcell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID1"];
    }
    else{
        CGRect tf1 = m.frame;
        tf1.size.width = tf1.size.width + 50;
        //        if(indexPath.row>4){
        //            tf1.size.height=0;
        //        }
        m.frame=tf1;
        UILabel *myButton=[[UILabel alloc] initWithFrame:CGRectMake(5, 12, 20, 20)];
        myButton.backgroundColor=[UIColor whiteColor];
        myButton.layer.borderColor = [UIColor grayColor].CGColor;
        myButton.layer.borderWidth = 1.5;
        myButton.layer.masksToBounds = YES;
        myButton.layer.cornerRadius = 10;
        m->myButton = myButton;
        [m.contentView addSubview:m->myButton];
        UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, m.bounds.size.width - 100, m.bounds.size.height-10)];
        myLabel.backgroundColor = [UIColor whiteColor];
        myLabel.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:18];
        myLabel.text=[_data1 objectAtIndex:indexPath.row];
        m->myLabel = myLabel;
//        NSLog(@"label1: %@",myLabel.text);
        [m.contentView addSubview:m->myLabel];
        UILabel *myLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(310,5, 100,m.bounds.size.height-10)];
        myLabel2.backgroundColor = [UIColor whiteColor];
        myLabel2.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:12];
        //        myLabel2.text=@"2019-12-31 15:00";
        myLabel2.text=[_data2 objectAtIndex:indexPath.row];;
        m->myLabel2 = myLabel2;
        [m.contentView addSubview:m->myLabel2];
        
        m->myborder=[CALayer layer];
        m->myborder.frame = CGRectMake(30.0f, m.frame.size.height - 1, m.layer.frame.size.width, 1.0f);
        m->myborder.backgroundColor = [UIColor grayColor].CGColor;
        [m.layer addSublayer:m->myborder];
        
        
        m.selectionStyle = UITableViewCellSelectionStyleNone;
        [m setClipsToBounds:YES];
        return m;
    }
    
    UILabel *myButton=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    myButton.backgroundColor=[UIColor colorWithRed:100.0f/255.0f
                                             green:149.0f/255.0f
                                              blue:237.0f/255.0f
                                             alpha:1.0f];
    myButton.layer.borderColor = [UIColor grayColor].CGColor;
    myButton.layer.borderWidth = 3.0;
    myButton.layer.masksToBounds = YES;
    myButton.layer.cornerRadius = 10;
    [m.contentView addSubview:myButton];
    
    m.backgroundColor=[UIColor whiteColor];
    NSLog(@"%ld,%ld", (long)indexPath.row, (long)indexPath.section);
    if(indexPath.row==0)
        m.textLabel.text=@"unit 1";
    else if(indexPath.row==1)
        m.textLabel.text=@"unit 2";
    else if(indexPath.row==2)
        m.textLabel.text=@"unit 3";
    else if(indexPath.row==3)
        m.textLabel.text=@"unit 4";
    return m;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld", (long)indexPath.row);
    Listcell *mycell=[self.ut cellForRowAtIndexPath:indexPath];
    //    mycell.accessoryType=UITableViewCellAccessoryCheckmark;
    //    mycell.selectionStyle=UITableViewCellSelectionStyleNone;
    mycell->myButton.backgroundColor=[UIColor colorWithRed:100.0f/255.0f
                                                     green:149.0f/255.0f
                                                      blue:237.0f/255.0f
                                                     alpha:1.0f];
    
    
    dispatch_time_t popTime1 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC));
    dispatch_after(popTime1, dispatch_get_main_queue(), ^(void){
        
        
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
        
        
        
        NSLog(@"myids:  %d",[[self->_myids objectAtIndex:indexPath.row] intValue]);
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"http://localhost:8001/api/deleteTodo/ID/%d", [[self->_myids objectAtIndex:indexPath.row] intValue]]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        NSURLSessionDataTask * dataTask = [delegateFreeSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if(error == nil) {
                NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                NSLog(@"Data = %@",text);
            }
        }];
        
        [dataTask resume];
        
        dispatch_time_t popTime1 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC));
        dispatch_after(popTime1, dispatch_get_main_queue(), ^(void){
            [self getinfo];
        });
    });
    
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    Listcell *mycell=[self.ut cellForRowAtIndexPath:indexPath];
    //    mycell.accessoryType=UITableViewCellAccessoryNone;
    mycell->myButton.backgroundColor=[UIColor whiteColor];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    return 50;
    //    return 0;
    return [[_heightcollection objectAtIndex:indexPath.row] floatValue];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *sectionName;
    //    sectionName=NSLocalizedString(@"mySectionName", @"mySectionName");
    if(section==0)
        sectionName=@"TOUR 1";
    else if(section==1)
        sectionName=@"TOUR 2";
    else if(section==2)
        sectionName=@"TOUR 3";
    else if(section==3)
        sectionName=@"TOUR 4";
    else if(section==4)
        sectionName=@"TOUR 5";
    else if(section==5)
        sectionName=@"TOUR 6";
    else if(section==6)
        sectionName=@"TOUR 7";
    else if(section==7)
        sectionName=@"TOUR 8";
    return sectionName;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

//111111
-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"http://localhost:8001/api/deleteTodo/ID/%d", [[self->_myids objectAtIndex:indexPath.row] intValue]]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLSessionDataTask * dataTask = [delegateFreeSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if(error == nil) {
                NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                NSLog(@"Data = %@",text);
            }
        }];
        [dataTask resume];
        dispatch_time_t popTime1 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC));
        dispatch_after(popTime1, dispatch_get_main_queue(), ^(void){
            [self getinfo];
        });
    }];
    //    button.backgroundColor = [UIColor greenColor]; //arbitrary color
    //    UITableViewRowAction *button2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Button 2" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
    //                                     {
    //                                         NSLog(@"Action to perform with Button2!");
    //                                     }];
    //    button2.backgroundColor = [UIColor blueColor]; //arbitrary color
    //
    return @[button,]; //array with all the buttons you want. 1,2,3, etc...
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // you need to implement this method too or nothing will work:
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES; //tableview must be editable or nothing will work...
}
//1111111

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (void) getinfo{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:self delegateQueue: [NSOperationQueue mainQueue]];
    
    NSString *tstring = [NSString stringWithFormat:@"http://localhost:8001/api/user/%@/todo", _username];
    
    
    NSURL *url = [NSURL URLWithString:tstring];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask * dataTask = [delegateFreeSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error == nil) {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            NSArray *myarray = [dictionary objectForKey:@"items"];
            for(int i=0;i<100;i++){
                [self->_heightcollection  replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:0.00]];
            }
            for(int i=0 ;i< myarray.count;i++){
                [self->_data1 replaceObjectAtIndex:i withObject:[[myarray objectAtIndex:i] objectForKey:@"taskname"]];
                [self->_data2 replaceObjectAtIndex:i withObject:[[myarray objectAtIndex:i] objectForKey:@"deadline"]];
                [self->_myids replaceObjectAtIndex:i withObject:[[myarray objectAtIndex:i] objectForKey:@"id"]];
                [self->_heightcollection  replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:50.00]];
            }
            self->_mytotal=[NSNumber numberWithInteger:myarray.count];
            [self->_ut reloadData];
        }
    }];
    
    
    [dataTask resume];
}


@end

//待做点击之后会触发reload并且post删除，加号点击之后会创建新的并且post创建，再刷新
