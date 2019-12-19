//
//  QuestionViewController.m
//  HW5
//
//  Created by ydy on 2019/11/2.
//  Copyright © 2019 ydy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuestionViewController.h"
#import "FinishingViewController.h"
@interface QuestionViewController()
@property (nonatomic, strong) UILabel *titleLabel;
@property  NSString *chinese;
@property (nonatomic,copy) NSArray *dataSourceArray;
@property (nonatomic,strong)UIButton *button1;
@property (nonatomic,strong)UIButton *button2;
@property (nonatomic,strong)UIButton *button3;
@property (nonatomic,strong)UIButton *button4;
@property (nonatomic,strong)UIButton *confirm;
@property (nonatomic,strong)UIView * hint;
@property (nonatomic,strong)UILabel *hintword;
@property (nonatomic,strong)NSDictionary *dict;
@property (nonatomic,strong)NSArray *arr;
@property (nonatomic,strong)NSDictionary*dict1;
@property NSInteger current_question;
@property (nonatomic,strong)NSString* myanswer;
@property NSMutableArray *correct;

@end

@implementation QuestionViewController
- (void)viewDidLoad {
    self.correct =[NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0" , nil];

    self.current_question=0;
    [super viewDidLoad];
    self.view.backgroundColor=UIColor.whiteColor;
    self.chinese=[[NSString alloc]init];
    self.dataSourceArray=[[NSArray alloc]init];
    [self getQuestion];
    
    self.hint=[[UIView alloc]initWithFrame:CGRectMake(0, 1.2*self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height*0.2)];
    self.hint.backgroundColor=UIColor.greenColor;
    [self.view addSubview:self.hint];
    self.hintword=[[UILabel alloc]initWithFrame:CGRectMake(self.hint.frame.size.width*0.05, self.hint.frame.size.height*0.1, self.hint.frame.size.width*0.7, self.hint.frame.size.height*0.25)];
    self.hintword.textColor=UIColor.whiteColor;
    [self.hintword setFont: [UIFont systemFontOfSize: 23]];
    [self.hint addSubview:self.hintword];
    
    self.confirm=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.confirm.frame = CGRectMake( self.view.frame.size.width*0.15,self.view.frame.size.height*0.9, self.view.frame.size.width*0.7, 50);
    self.confirm.backgroundColor=UIColor.grayColor;
    [self.confirm setTitle:@"确认" forState:UIControlStateNormal];
    [self.confirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.confirm.titleLabel.font = [UIFont systemFontOfSize:24];
    [self.confirm addTarget:self action:@selector(pressConfirm:)  forControlEvents:UIControlEventTouchDown];
    [self.confirm.layer setCornerRadius:10];
    [self.view addSubview:self.confirm];
    self.confirm.enabled=false;
    
    self.button1 =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.button1.frame = CGRectMake( self.view.frame.size.width*0.15,self.view.frame.size.height*0.3, self.view.frame.size.width*0.7, 50);
    [self.button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.button1 setTintColor:[UIColor whiteColor]];
    self.button1 .titleLabel.font = [UIFont systemFontOfSize:24];
    [self.button1 addTarget:self action:@selector(pressBtn:)  forControlEvents:UIControlEventTouchDown];
    [self.button1.layer setBorderWidth:2];
    [self.button1.layer setCornerRadius:10];
    self.button1.tag=0;
    self.button2 =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.button2.frame = CGRectMake( self.view.frame.size.width*0.15,self.view.frame.size.height*0.4, self.view.frame.size.width*0.7, 50);
    [self.button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.button2 setTintColor:[UIColor whiteColor]];
    self.button2.titleLabel.font = [UIFont systemFontOfSize:24];
    [self.button2 addTarget:self action:@selector(pressBtn:)  forControlEvents:UIControlEventTouchDown];
    [self.button2.layer setBorderWidth:2];
    [self.button2.layer setCornerRadius:10];
    self.button2.tag=0;
    self.button3 =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.button3.frame = CGRectMake( self.view.frame.size.width*0.15,self.view.frame.size.height*0.5, self.view.frame.size.width*0.7, 50);
    [self.button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.button3 setTintColor:[UIColor whiteColor]];
    self.button3.titleLabel.font = [UIFont systemFontOfSize:24];
    [self.button3 addTarget:self action:@selector(pressBtn:)  forControlEvents:UIControlEventTouchDown];
    [self.button3.layer setBorderWidth:2];
    [self.button3.layer setCornerRadius:10];
    self.button3.tag=0;
    self.button4 =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.button4.frame = CGRectMake( self.view.frame.size.width*0.15,self.view.frame.size.height*0.6, self.view.frame.size.width*0.7, 50);
    [self.button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.button4 setTintColor:[UIColor whiteColor]];
    self.button4.titleLabel.font = [UIFont systemFontOfSize:24];
    [self.button4 addTarget:self action:@selector(pressBtn:)  forControlEvents:UIControlEventTouchDown];
    [self.button4.layer setBorderWidth:2];
    [self.button4.layer setCornerRadius:10];
    self.button4.tag=0;
    [self.button1.layer setBorderColor:UIColor.whiteColor.CGColor];
    [self.button2.layer setBorderColor:UIColor.whiteColor.CGColor];
    [self.button3.layer setBorderColor:UIColor.whiteColor.CGColor];
    [self.button4.layer setBorderColor:UIColor.whiteColor.CGColor];
    
}
- (void) pressBtn:(UIButton *) btn
{
    self.myanswer=btn.titleLabel.text;
    NSLog(self.myanswer);
    if(self.button1!=btn){
        [self.button1 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [self.button1.layer setBorderColor:UIColor.whiteColor.CGColor];
    }
    if(self.button2!=btn){
        [self.button2 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [self.button2.layer setBorderColor:UIColor.whiteColor.CGColor];
    }
    if(self.button3!=btn){
        [self.button3 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [self.button3.layer setBorderColor:UIColor.whiteColor.CGColor];
    }
    if(self.button4!=btn){
        [self.button4 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [self.button4.layer setBorderColor:UIColor.whiteColor.CGColor];
    }
    [self.confirm setBackgroundColor:[UIColor colorWithRed:0 green:0.7 blue:0 alpha:1]];
    [btn.layer setBorderColor:UIColor.greenColor.CGColor];
    [btn setTitleColor:UIColor.greenColor forState:UIControlStateNormal];
    self.confirm.enabled=true;
}

- (void) pressConfirm:(UIButton *) btn
{
    NSLog(btn.currentTitle);
    if(btn.currentTitle==@"确认"){
        [self getAnswer:self.current_question myanswer:self.myanswer];
        self.button1.enabled=false;
        self.button2.enabled=false;
        self.button3.enabled=false;
        self.button4.enabled=false;
        [btn setTitle:@"继续" forState:UIControlStateNormal];
    }else{
        self.button1.enabled=true;
        self.button2.enabled=true;
        self.button3.enabled=true;
        self.button4.enabled=true;
        self.current_question++;
        if(self.current_question<=3){
            self.dict1=self.arr[self.current_question];
            self.titleLabel.text=[self.dict1 objectForKey:@"question"];
            self.dataSourceArray=[self.dict1 objectForKey:@"choices"];
            [self.button1 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
            [self.button1.layer setBorderColor:UIColor.whiteColor.CGColor];
            [self.button2 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
            [self.button2.layer setBorderColor:UIColor.whiteColor.CGColor];
            [self.button3 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
            [self.button3.layer setBorderColor:UIColor.whiteColor.CGColor];
            [self.button4 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
            [self.button4.layer setBorderColor:UIColor.whiteColor.CGColor];
            [self.button1 setTitle:self.dataSourceArray[0] forState:UIControlStateNormal];
            [self.button2 setTitle:self.dataSourceArray[1] forState:UIControlStateNormal];
            [self.button3 setTitle:self.dataSourceArray[2] forState:UIControlStateNormal];
            [self.button4 setTitle:self.dataSourceArray[3] forState:UIControlStateNormal];
            self.confirm.backgroundColor=UIColor.grayColor;
            [self.confirm setTitle:@"确认" forState:UIControlStateNormal];
            self.confirm.enabled=false;
            [UIView animateWithDuration:0.5 animations:^{
                self.hint.frame = CGRectMake(0, 1.2*self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height*0.2);
            }];
        }else{
            FinishingViewController *nextController=[[FinishingViewController alloc]init];
        //    nextController.title=[NSString stringWithFormat:@"%@",_dataSourceArray[indexPath.row]];
            nextController.myCorrect=self.correct;
            [self.navigationController pushViewController:nextController animated:YES];
        }
    }
}


- (UILabel *)titleLabel {
    if(_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*0.2, self.view.frame.size.width, 30)];
        [_titleLabel setText:self.chinese];
        [_titleLabel setFont: [UIFont systemFontOfSize: 20]];
        [_titleLabel setTextColor: [UIColor blackColor]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

-(void)getAnswer:(NSInteger*)cq myanswer:(NSString*)ma{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject
                                                                      delegate: self
                                                                 delegateQueue: [NSOperationQueue mainQueue]];
    NSURL * url = [NSURL URLWithString:@"https://service-p12xr1jd-1257177282.ap-beijing.apigateway.myqcloud.com/release/HW5_api"];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    
    // 设置请求体为JSON
    NSDictionary *dic = @{@"unit": [NSString stringWithFormat: @"%ld", self.currentUnit], @"question": [NSString stringWithFormat: @"%ld", self.current_question], @"Answer": ma};
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [urlRequest setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
      NSMutableArray * array1 =[NSMutableArray arrayWithObjects:@"a",@"b",@"c" , nil];
    NSURLSessionDataTask * dataTask =[delegateFreeSession dataTaskWithRequest:urlRequest
                                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                                NSLog(@"Response:%@ %@\n", response, error);
                                                                if(error == nil) {
                                                                    NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                                                    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                                    self.hintword.text=[@"正确答案：" stringByAppendingString:[dict objectForKey:@"data"]];
                                                                    if([[dict objectForKey:@"message"] isEqual:@"wrong"]){
                                                                        NSLog(@"wrong");
                                                                        [self.correct replaceObjectAtIndex:self.current_question withObject:@"0"];
                                                                        NSLog(@"%@",self.correct);
                                                                        self.confirm.backgroundColor=[UIColor colorWithRed:0.7 green:0 blue:0 alpha:1];
                                                                        self.hint.backgroundColor=UIColor.redColor;
                                                                    }else{
                                                                        NSLog(@"correct");
                                                                        [self.correct replaceObjectAtIndex:self.current_question withObject:@"1"];
                                                                        NSLog(@"%@",self.correct);
                                                                        self.confirm.backgroundColor=[UIColor colorWithRed:0 green:0.7 blue:0 alpha:1];
                                                                        self.hint.backgroundColor=UIColor.greenColor;
                                                                    }
                                                                    [UIView animateWithDuration:0.5 animations:^{
                                                                        self.hint.frame = CGRectMake(0, 0.8*self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height*0.2);
                                                                    }];
                                                                    NSLog(@"Data = %@",text);
                                                                }
                                                            }];
    [dataTask resume];
}

-(void)getQuestion{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject
                                                                      delegate: self
                                                                 delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"https://service-p12xr1jd-1257177282.ap-beijing.apigateway.myqcloud.com/release/HW5_api?unit=%lu", self.currentUnit]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask * dataTask = [delegateFreeSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error == nil)
        {
  //          NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            self.dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.arr=[self.dict objectForKey:@"data"];
            self.dict1=self.arr[0];
            self.chinese=[self.dict1 objectForKey:@"question"];
            self.dataSourceArray=[self.dict1 objectForKey:@"choices"];
            [self.button1 setTitle:self.dataSourceArray[0] forState:UIControlStateNormal];
            [self.button2 setTitle:self.dataSourceArray[1] forState:UIControlStateNormal];
            [self.button3 setTitle:self.dataSourceArray[2] forState:UIControlStateNormal];
            [self.button4 setTitle:self.dataSourceArray[3] forState:UIControlStateNormal];
            [self.view addSubview:self.button1];
            [self.view addSubview:self.button2];
            [self.view addSubview:self.button3];
            [self.view addSubview:self.button4];
     //       [self.view addSubview: self.collectionView];
            [self.view addSubview: self.titleLabel];
        
        }
    }];
    [dataTask resume];
}
@end
