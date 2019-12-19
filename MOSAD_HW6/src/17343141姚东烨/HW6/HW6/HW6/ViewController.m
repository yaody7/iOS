//
//  ViewController.m
//  HW6
//
//  Created by ydy on 2019/11/17.
//  Copyright © 2019 ydy. All rights reserved.
//

#import "ViewController.h"
#import "MyCell.h"
@interface ViewController ()
@property(nonatomic,strong) UILabel*titleLabel;
@property(nonatomic) UICollectionView *collectionView;
@property(nonatomic,strong) UIButton* left;
@property(nonatomic,strong) UIButton* middle;
@property(nonatomic,strong) UIButton* right;
@property (nonatomic,copy) NSMutableArray *dataSourceArray;
@property (nonatomic,copy) NSMutableArray *fileSourceArray;
@property (nonatomic,strong) NSFileManager *fileManager;
@property (nonatomic) BOOL Clicked;


@property(nonatomic,strong) NSIndexPath* myIndex;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSourceArray=[NSMutableArray arrayWithArray:@[@"https://hbimg.huabanimg.com/d8784bbeac692c01b36c0d4ff0e072027bb3209b106138-hwjOwX_fw658",
                                                          @"https://hbimg.huabanimg.com/6215ba6f9b4d53d567795be94a90289c0151ce73400a7-V2tZw8_fw658",
                                                          @"https://hbimg.huabanimg.com/834ccefee93d52a3a2694535d6aadc4bfba110cb55657-mDbhv8_fw658",
                                                          @"https://hbimg.huabanimg.com/f3085171af2a2993a446fe9c2339f6b2b89bc45f4e79d-LacPMl_fw658",
                                                          @"https://hbimg.huabanimg.com/e5c11e316e90656dd3164cb97de6f1840bdcc2671bdc4-vwCOou_fw658"]];
    self.Clicked=false;
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.titleLabel];
    self.middle =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.middle.frame = CGRectMake( self.view.frame.size.width*0.375,self.view.frame.size.height*0.925, self.view.frame.size.width*0.25, self.view.frame.size.height*0.04);
    [self.middle setBackgroundColor:UIColor.greenColor];
    [self.middle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.middle setTintColor:[UIColor whiteColor]];
    self.middle .titleLabel.font = [UIFont systemFontOfSize:22];
    [self.middle addTarget:self action:@selector(middleEvent:)  forControlEvents:UIControlEventTouchDown];
    [self.middle.layer setBorderWidth:0];
    [self.middle.layer setCornerRadius:10];
    [self.middle setTitle:@"清空" forState:normal];
    [self.view addSubview:self.middle];
    self.left =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.left.frame = CGRectMake( self.view.frame.size.width*0.05,self.view.frame.size.height*0.925, self.view.frame.size.width*0.25, self.view.frame.size.height*0.04);
    [self.left setBackgroundColor:UIColor.greenColor];
    [self.left setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.left setTintColor:[UIColor whiteColor]];
    self.left .titleLabel.font = [UIFont systemFontOfSize:22];
    [self.left addTarget:self action:@selector(leftEvent:)  forControlEvents:UIControlEventTouchDown];
    [self.left.layer setBorderWidth:0];
    [self.left.layer setCornerRadius:10];
    [self.left setTitle:@"加载"  forState:normal];
    [self.view addSubview:self.left];
    self.right =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.right.frame = CGRectMake( self.view.frame.size.width*0.7,self.view.frame.size.height*0.925, self.view.frame.size.width*0.25, self.view.frame.size.height*0.04);
    [self.right setBackgroundColor:UIColor.greenColor];
    [self.right setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.right setTintColor:[UIColor whiteColor]];
    self.right .titleLabel.font = [UIFont systemFontOfSize:22];
    [self.right addTarget:self action:@selector(rightEvent:)  forControlEvents:UIControlEventTouchDown];
    [self.right.layer setBorderWidth:0];
    [self.right.layer setCornerRadius:10];
    [self.right setTitle:@"删除缓存"
                forState:normal];
    [self.view addSubview:self.right];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    self.fileManager = [NSFileManager defaultManager];
    self.fileSourceArray=[NSMutableArray arrayWithArray:@[[cachePath stringByAppendingPathComponent:[NSString stringWithFormat: @"%d.png", 0]],
                                                          [cachePath stringByAppendingPathComponent:[NSString stringWithFormat: @"%d.png", 1]],
                                                          [cachePath stringByAppendingPathComponent:[NSString stringWithFormat: @"%d.png", 2]],
                                                          [cachePath stringByAppendingPathComponent:[NSString stringWithFormat: @"%d.png", 3]],
                                                          [cachePath stringByAppendingPathComponent:[NSString stringWithFormat: @"%d.png", 4]]]];
}
- (void) leftEvent:(UIButton *) btn
{
    NSOperationQueue *queue =[[NSOperationQueue alloc]init];
    for(int i=0;i<5;i++){
        NSDictionary*dict= [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d",i] forKey:@"key"];
        NSInvocationOperation *op=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(downloadImg:) object: dict];
        [queue addOperation:op];
    }
}

- (void) middleEvent:(UIButton *)btn{
    self.Clicked=false;
    [self.collectionView reloadData];
}

- (void) rightEvent:(UIButton *) btn
{
    for(int i=0;i<5;i++){
        [self.fileManager removeItemAtPath:self.fileSourceArray[i] error:nil];
    }
}

- (void) downloadImg:(NSDictionary*)dict
{
    self.Clicked=true;
    NSLog(@"%@",[dict valueForKey:@"key"]);
    NSString* temp=[dict valueForKey:@"key"];
    int value = [temp intValue];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject
                                                                      delegate: self
                                                                 delegateQueue: [NSOperationQueue mainQueue]];
    NSLog(self.dataSourceArray[value]);
    NSURL *url = [NSURL URLWithString:self.dataSourceArray[value]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask * dataTask = [delegateFreeSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error == nil)
        {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            NSString *cachePath = [paths objectAtIndex:0];
            NSString *filePath = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat: @"%ld.png", value]];
            [UIImagePNGRepresentation([UIImage imageWithData:[NSData dataWithContentsOfURL:url]]) writeToFile:filePath atomically:YES];
            NSOperationQueue *queue =[NSOperationQueue mainQueue];
            NSInvocationOperation *op=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(rd) object: NULL];
            [queue addOperation:op];
        }
    }];
    [dataTask resume];
}

- (void)rd{
    [self.collectionView reloadData];
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%d",indexPath.item);
    MyCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    if(self.Clicked==false){
        cell.imageView.image=NULL;
        return cell;
    }
    else{
        if([self.fileManager fileExistsAtPath:self.fileSourceArray[indexPath.section]]==false){
            NSLog(@"Download not complete");
            cell.imageView.image=[UIImage imageNamed:@"loading.png"];
        }else{
            cell.imageView.image=[UIImage imageWithContentsOfFile:self.fileSourceArray[indexPath.item]];
         //   cell.imageView.image=[UIImage imageNamed:@"loading.png"];
        }
    }
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return self.view.frame.size.width*0.06;
}
// 返回cell之间列间隙
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return self.view.frame.size.width*0.3;
}

// 返回cell的尺寸大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width*0.9, self.view.frame.size.width*0.6);
}


- (UILabel *)titleLabel{
    if(_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*0.03, self.view.frame.size.width, self.view.frame.size.height*0.07)];
        [_titleLabel setText:@"Pictures"];
        [_titleLabel setFont: [UIFont systemFontOfSize: 30]];
        [_titleLabel setTextColor: [UIColor blackColor]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

- (UICollectionView *)collectionView {
    if(_collectionView==nil){
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        layout.itemSize=CGSizeMake(30,40);
        self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height*0.1,self.view.frame.size.width,self.view.frame.size.height*0.8)collectionViewLayout:layout];
        self.collectionView.backgroundColor=UIColor.whiteColor;
        // 设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        // 注册cell
        [_collectionView registerClass:[MyCell class] forCellWithReuseIdentifier:@"MyCell"];
    }
    return _collectionView;
}

@end
