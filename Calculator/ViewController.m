//
//  ViewController.m
//  Calculator
//
//  Created by Rick on 2017/9/2.
//  Copyright © 2017年 Rick. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //创建标签
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(90, 40, 200, 50)] ;
    [self.view addSubview:_label] ;
    self.label.backgroundColor = [UIColor greenColor] ;
    self.label.textColor = [UIColor blackColor] ;
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont systemFontOfSize:32.4] ;
    
    //添加1-9数字
    NSArray * array = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil] ;
    int n = 0 ;
    for (int i = 0 ; i<3; i++)
    {
        for (int j = 0; j<3; j++)
        {
            self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
            self.button.frame = CGRectMake(30+65*j, 150+65*i, 60, 60);
            [self.button setTitle:[array objectAtIndex:n++] forState:UIControlStateNormal] ;
            [self.view addSubview:_button] ;
            [self.button addTarget:self action:@selector(shuzi:) forControlEvents:UIControlEventTouchUpInside] ;
        }
    }
    
    //添加数字 ”0“
    UIButton *button0 = [UIButton buttonWithType:UIButtonTypeCustom] ;
    button0.frame = CGRectMake(30, 345, 60, 60);
    [button0 setTitle:@"0" forState:UIControlStateNormal];
    button0.titleLabel.textColor = [UIColor blackColor] ;
    [button0 addTarget:self action:@selector(shuzi:) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:button0] ;
    
    //添加 “.” 小数点
    UIButton *buttonPoint = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
    [buttonPoint setFrame:CGRectMake(95, 345, 60, 60)];
    [buttonPoint setTitle:@"." forState:UIControlStateNormal] ;
    [buttonPoint addTarget:self action:@selector(shuzi:) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:buttonPoint] ;
    
    
    //添加运算符：
    NSArray *array1 = [NSArray arrayWithObjects:@"+",@"_",@"*",@"/", nil] ;
    for (int i = 0; i<4; i++)
    {
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button1 setFrame:CGRectMake(225, 150+65*i, 60, 60)] ;
        [button1 setTitle:[array1 objectAtIndex:i] forState:UIControlStateNormal] ;
        [self.view addSubview: button1] ;
        [button1 addTarget:self action:@selector(run:) forControlEvents:UIControlEventTouchUpInside] ;
    }
    
    //添加 “=” 号 EqualSign
    UIButton *buttonEqualSign = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
    [buttonEqualSign setFrame:CGRectMake(160, 410, 125, 35)] ;
    [buttonEqualSign setTitle:@"=" forState:UIControlStateNormal] ;
    [buttonEqualSign addTarget:self action:@selector(run:) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:buttonEqualSign] ;
    
    //添加”AC“建 clean
    UIButton * buttonClean = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
    [buttonClean setFrame:CGRectMake(30, 410, 125, 35)] ;
    [buttonClean setTitle:@"AC" forState:UIControlStateNormal] ;
    [buttonClean addTarget:self action:@selector(clean:) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:buttonClean] ;
    
    //添加“back”按钮
    UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
    [buttonBack setFrame:CGRectMake(160, 345, 60, 60)] ;
    [buttonBack setTitle:@"<——" forState:UIControlStateNormal] ;
    [buttonBack addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:buttonBack] ;
    
    
    self.string = [[NSMutableString alloc]init] ;
    self.str = [[NSString alloc]init];
    
}

-(void)shuzi:(id)sender
{
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
