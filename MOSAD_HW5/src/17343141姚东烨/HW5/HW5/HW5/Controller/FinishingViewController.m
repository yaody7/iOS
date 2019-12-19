//
//  FinishingViewController.m
//  HW5
//
//  Created by ydy on 2019/11/3.
//  Copyright © 2019 ydy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FinishingViewController.h"
@interface FinishingViewController()

@property UILabel* myTitle;
@property UILabel* score;
@property NSInteger currentScore;
@property (strong, nonatomic) UIImageView *star1;
@property (strong, nonatomic) UIImageView *star2;
@property (strong, nonatomic) UIImageView *star3;
@property (strong, nonatomic) UIImageView *star4;
@property (strong, nonatomic) UIButton *fanhui;
@end

@implementation FinishingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentScore=0;
    self.view.backgroundColor=UIColor.whiteColor;
    self.myTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0.2*self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height*0.1)];
    [self.myTitle setText: @"正确数"];
    [self.myTitle setFont: [UIFont systemFontOfSize: 20]];
    [self.myTitle setTextColor: [UIColor blackColor]];
    [self.myTitle setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.myTitle];
    
    self.score=[[UILabel alloc]initWithFrame:CGRectMake(0, 0.3*self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height*0.2)];
    [self.score setText:[NSString stringWithFormat: @"%ld", self.currentScore]];
    [self.score setFont: [UIFont systemFontOfSize: 60]];
    [self.score setTextColor: [UIColor blackColor]];
    [self.score setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.score];
    
    self.star1= [[UIImageView alloc] initWithFrame:CGRectMake(0.2*self.view.frame.size.width,0.5*self.view.frame.size.height,self.view.frame.size.width*0.14,self.view.frame.size.width*0.14)];
    self.star1.layer.masksToBounds = YES;
    self.star1.layer.cornerRadius = 20;
    [self.view addSubview:self.star1];
    [self.star1 setImage:[UIImage imageNamed:@"Star0.png"]];
    
    self.star2= [[UIImageView alloc] initWithFrame:CGRectMake(0.35*self.view.frame.size.width,0.5*self.view.frame.size.height,self.view.frame.size.width*0.14,self.view.frame.size.width*0.14)];
    self.star2.layer.masksToBounds = YES;
    self.star2.layer.cornerRadius = 20;
    [self.view addSubview:self.star2];
    [self.star2 setImage:[UIImage imageNamed:@"Star0.png"]];
    
    self.star3= [[UIImageView alloc] initWithFrame:CGRectMake(0.5*self.view.frame.size.width,0.5*self.view.frame.size.height,self.view.frame.size.width*0.14,self.view.frame.size.width*0.14)];
    self.star3.layer.masksToBounds = YES;
    self.star3.layer.cornerRadius = 20;
    [self.view addSubview:self.star3];
    [self.star3 setImage:[UIImage imageNamed:@"Star0.png"]];
    
    self.star4= [[UIImageView alloc] initWithFrame:CGRectMake(0.65*self.view.frame.size.width,0.5*self.view.frame.size.height,self.view.frame.size.width*0.14,self.view.frame.size.width*0.14)];
    self.star4.layer.masksToBounds = YES;
    self.star4.layer.cornerRadius = 20;
    [self.view addSubview:self.star4];
    [self.star4 setImage:[UIImage imageNamed:@"Star0.png"]];
    
    self.fanhui=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.fanhui.frame = CGRectMake( self.view.frame.size.width*0.15,self.view.frame.size.height*0.9, self.view.frame.size.width*0.7, 50);
    self.fanhui.backgroundColor=UIColor.greenColor;
    [self.fanhui setTitle:@"返回" forState:UIControlStateNormal];
    [self.fanhui setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.fanhui.titleLabel.font = [UIFont systemFontOfSize:24];
    [self.fanhui addTarget:self action:@selector(goback:)  forControlEvents:UIControlEventTouchDown];
    [self.fanhui.layer setCornerRadius:10];
    [self.view addSubview:self.fanhui];
    
    [self getAnswer];
    
}
- (void) goback:(UIButton *) btn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void) getAnswer{
    [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations: ^{
            self.star1.frame = CGRectMake(0.19*self.view.frame.size.width, 0.49*self.view.frame.size.height, self.view.frame.size.width*0.16, self.view.frame.size.width*0.16);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations: ^{
            self.star1.frame = CGRectMake(0.2*self.view.frame.size.width,0.5*self.view.frame.size.height,self.view.frame.size.width*0.14,self.view.frame.size.width*0.14);
        }];
    } completion:^(BOOL finished) {
        if([self.myCorrect[0] isEqual:@"1"]){
            self.currentScore++;
            self.score.text=[NSString stringWithFormat:@"%lu",self.currentScore];
            [self.star1 setImage:[UIImage imageNamed:@"Star1.png"]];
        }
        [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations: ^{
                self.star2.frame = CGRectMake(0.34*self.view.frame.size.width, 0.49*self.view.frame.size.height, self.view.frame.size.width*0.16, self.view.frame.size.width*0.16);
            }];
            [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations: ^{
                self.star2.frame = CGRectMake(0.35*self.view.frame.size.width,0.5*self.view.frame.size.height,self.view.frame.size.width*0.14,self.view.frame.size.width*0.14);
            }];
        } completion:^(BOOL finished) {
            if([self.myCorrect[1] isEqual:@"1"]){
                self.currentScore++;
                self.score.text=[NSString stringWithFormat:@"%lu",self.currentScore];
                [self.star2 setImage:[UIImage imageNamed:@"Star1.png"]];
            }
            [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
                [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations: ^{
                    self.star3.frame = CGRectMake(0.49*self.view.frame.size.width, 0.49*self.view.frame.size.height, self.view.frame.size.width*0.16, self.view.frame.size.width*0.16);
                }];
                [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations: ^{
                    self.star3.frame = CGRectMake(0.5*self.view.frame.size.width,0.5*self.view.frame.size.height,self.view.frame.size.width*0.14,self.view.frame.size.width*0.14);
                }];
            } completion:^(BOOL finished) {
                if([self.myCorrect[2] isEqual:@"1"]){
                    self.currentScore++;
                    self.score.text=[NSString stringWithFormat:@"%lu",self.currentScore];
                    [self.star3 setImage:[UIImage imageNamed:@"Star1.png"]];
                }
                [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
                    [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations: ^{
                        self.star4.frame = CGRectMake(0.64*self.view.frame.size.width, 0.49*self.view.frame.size.height, self.view.frame.size.width*0.16, self.view.frame.size.width*0.16);
                    }];
                    [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations: ^{
                        self.star4.frame = CGRectMake(0.65*self.view.frame.size.width,0.5*self.view.frame.size.height,self.view.frame.size.width*0.14,self.view.frame.size.width*0.14);
                    }];
                } completion:^(BOOL finished) {
                    if([self.myCorrect[3] isEqual:@"1"]){
                        self.currentScore++;
                        self.score.text=[NSString stringWithFormat:@"%lu",self.currentScore];
                        [self.star4 setImage:[UIImage imageNamed:@"Star1.png"]];
                    }
                    [UIView animateKeyframesWithDuration:0.1 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
                        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations: ^{
                            self.star4.frame = CGRectMake(0.65*self.view.frame.size.width, 0.5*self.view.frame.size.height, self.view.frame.size.width*0.1400001, self.view.frame.size.width*0.1400001);
                        }];
                        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations: ^{
                            self.star4.frame = CGRectMake(0.65*self.view.frame.size.width,0.5*self.view.frame.size.height,self.view.frame.size.width*0.14,self.view.frame.size.width*0.14);
                        }];
                    } completion:^(BOOL finished) {

                    }];
                }];
            }];
        }];
    }];
    /*
    

*/
}

@end
