//
//  ViewController.m
//  Calculator
//
//  Created by Rick on 2017/9/2.
//  Copyright © 2017年 Rick. All rights reserved.
//

#define MainScreenWidth [[UIScreen mainScreen]bounds].size.width
#define MainScreenHeight [[UIScreen mainScreen]bounds].size.height



#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"


@interface ViewController ()



@end

@implementation ViewController



//设置按下数字方法
-(void)num:(id)sender
{
    if ([_labelOperators.text isEqualToString:@" = "]) {
        [_display setString:@""];
        _labelOperators .text = @"";
    }
    [_display appendString:[sender currentTitle]];
    self.labelResult.text = [NSString stringWithString:_display];
    self.resultNum = [self.labelResult.text doubleValue];
    _leftNum = [_display doubleValue];
    NSLog(@"self.num1 is %f",self.resultNum) ;
}

-(void)numZero:(id)sender
{
    
    
    [_display appendString:[sender currentTitle]];
    
    if ([_display isEqualToString:@"0"]) {
        [_display setString:@""];
        self.labelResult.text = @"0";
    }
    else
    {
        self.labelResult.text = [NSString stringWithString:_display];
    }
    
    _leftNum = [_display doubleValue];
    self.resultNum = [self.labelResult.text doubleValue];
    NSLog(@"self.num1 is %f",self.resultNum) ;
}

-(void)point:(id)sender
{
    
    [_display appendString:[sender currentTitle]];
    
    if ([_display isEqualToString:@"."]) {
        [_display setString:@"0."];
        self.labelResult.text = @"0.";
        havePoint = YES;
        _leftNum = [_display doubleValue];
    }
    else if (havePoint)
    {
        NSRange deleteRange = {[_display length] -1,1};  //创建deleteRange
        [_display deleteCharactersInRange:deleteRange];
    }
    else
    {
        havePoint = YES;
    }
    // havePoint = NO;
    _leftNum = [_display doubleValue];
    
    NSLog(@"%@",_display);
    // [_display appendString:[sender currentTitle]];
    self.labelResult.text = [NSString stringWithString:_display];
    self.resultNum  = [self.labelResult.text doubleValue];
    NSLog(@"self.num1 is %f",self.resultNum) ;
}
/*
 //＋－×÷
 -(void)operators:(id)sender
 {
 
 havePoint = NO;
 
 
 
 if (!isFirstInput)
 {
 _labelOperators.text = [sender currentTitle];
 _leftNum = [_display doubleValue];
 _labelDisplay.text = [NSString stringWithString:_display];
 [_display setString:@""];
 self.labelResult.text = @"0";
 NSLog(@"self.num1 is %f",self.resultNum) ;
 isleftNum = YES;
 isFirstInput = YES;
 _haveChar = [sender currentTitle];
 }
 
 
 if ([[sender currentTitle] isEqualToString:@"＋"]) {
 
 _labelOperators.text = [sender currentTitle];
 _rightNum = [_display doubleValue];
 _labelDisplay.text = [NSString stringWithString:_display];
 [_display setString:@""];
 _resultNum = _leftNum + _rightNum;
 self.labelDisplay.text = [NSString stringWithFormat:@"%.9f",_resultNum];
 NSLog(@"self.num1 is %f",self.resultNum) ;
 _leftNum = 0;
 _resultNum = 0;
 isleftNum = NO;
 }
 else if ([[sender currentTitle] isEqualToString:@"－"])
 {
 isMinus = YES;
 }
 else if ([[sender currentTitle] isEqualToString:@"×"])
 {
 isMultiply = YES;
 }
 else if ([[sender currentTitle] isEqualToString:@"÷"])
 {
 isDivide = YES ;
 }
 
 
 
 }
 */



-(void) operators:(id)sender
{
    havePoint = NO;
    NSLog(@"chara%@",_haveChar);
    
    if ([_haveChar isEqualToString:@""])
    {
        if ([_display isEqualToString:@""]) {
            return;
        }
        _haveChar = [sender currentTitle];
        _rightNum = _leftNum;
        NSLog(@"self.num2 is %f",_rightNum);
        
        _labelDisplay.text = [NSString stringWithString:_display];
        [_display setString:@""];
        _labelOperators.text = [sender currentTitle];
        _labelResult.text = @"0";
        
    }
    else if([_display isEqualToString:@"0"] && ![_haveChar isEqualToString:@""])
    {
        if ([_haveChar isEqualToString:@"＋"] | [_haveChar isEqualToString:@"－"] | [_haveChar isEqualToString:@"×"] | [_haveChar isEqualToString:@"÷"] )
        {
            _haveChar = @"";
        }
    }
    else
    {
        
        
        
        
        if ([[sender currentTitle] isEqualToString:@"＋"]) {
            _haveChar = [sender currentTitle];
            //把新输入的_string加入到_num1中
            _leftNum = [_labelResult.text doubleValue];
            //计算结果Num3
            _resultNum = _rightNum +_leftNum ;
            _rightNum = _resultNum ;
            NSLog(@"aaaaa%f",_resultNum);
            
            _lengthString = [NSString stringWithFormat:@"%f", _rightNum];
            
            _length = [_lengthString length];
            for(int i = 0; i<=5; i++)
            {
                NSString *subString = [_lengthString substringFromIndex:_length - i];
                if([subString isEqualToString:@"0"])
                {
                    _lengthString = [_lengthString substringToIndex:_length - i];
                }
                
            }
            
            [_display setString:@""];
            _labelOperators.text = [sender currentTitle];
            _labelResult.text = @"0";
            _leftNum = 0;
            [_labelDisplay setText:_lengthString];
        }
        
        if ([[sender currentTitle] isEqualToString:@"－"]) {
            _haveChar = [sender currentTitle];
            //把新输入的_string加入到_num1中
            _leftNum = [_labelResult.text doubleValue];
            //计算结果Num3
            _resultNum = _rightNum -_leftNum ;
            _rightNum = _resultNum ;
            NSLog(@"aaaaa%f",_resultNum);
            
            _lengthString = [NSString stringWithFormat:@"%f", _rightNum];
            
            _length = [_lengthString length];
            for(int i = 0; i<=5; i++)
            {
                NSString *subString = [_lengthString substringFromIndex:_length - i];
                if([subString isEqualToString:@"0"])
                {
                    _lengthString = [_lengthString substringToIndex:_length - i];
                }
                
            }
            
            [_display setString:@""];
            _labelOperators.text = [sender currentTitle];
            _labelResult.text = @"0";
            _leftNum = 0;
            [_labelDisplay setText:_lengthString];
        }
        
        if ([[sender currentTitle] isEqualToString:@"×"]) {
            NSLog(@"%@",_haveChar);
            _haveChar = [sender currentTitle];
            //把新输入的_string加入到_num1中
            _leftNum = [_labelResult.text doubleValue];
            //计算结果Num3
            _resultNum = _rightNum *_leftNum ;
            _rightNum = _resultNum ;
            NSLog(@"aaaaa%f",_resultNum);
            
            _lengthString = [NSString stringWithFormat:@"%f", _rightNum];
            
            _length = [_lengthString length];
            for(int i = 0; i<=5; i++)
            {
                NSString *subString = [_lengthString substringFromIndex:_length - i];
                if([subString isEqualToString:@"0"])
                {
                    _lengthString = [_lengthString substringToIndex:_length - i];
                }
                
            }
            
            [_display setString:@""];
            _labelOperators.text = [sender currentTitle];
            _labelResult.text = @"0";
            _leftNum = 0;
            [_labelDisplay setText:_lengthString];
        }
        
        if ([[sender currentTitle] isEqualToString:@"÷"])
        {
            
            if ([_display isEqualToString:@"0"] | [_display isEqualToString:@"0."]) {
                _haveChar = @"÷";
            }
            else
            {
                _haveChar = [sender currentTitle];
                //把新输入的_string加入到_num1中
                _leftNum = [_labelResult.text doubleValue];
                //计算结果Num3
                _resultNum = _rightNum / _leftNum ;
                _rightNum = _resultNum ;
                NSLog(@"aaaaa%f",_resultNum);
                
                _lengthString = [NSString stringWithFormat:@"%f", _rightNum];
                
                _length = [_lengthString length];
                for(int i = 0; i<=5; i++)
                {
                    NSString *subString = [_lengthString substringFromIndex:_length - i];
                    if([subString isEqualToString:@"0"])
                    {
                        _lengthString = [_lengthString substringToIndex:_length - i];
                    }
                    
                }
                
                [_display setString:@""];
                _labelOperators.text = [sender currentTitle];
                _labelResult.text = @"0";
                _leftNum = 0;
                [_labelDisplay setText:_lengthString];
            }
        }
        
    }
}




-(void)run:(id)sender
{
    if ([_haveChar isEqualToString:@""])
    {
        
    }
    else if (![_haveChar isEqualToString:@""])
    {
        if ([_haveChar isEqualToString:@"÷"]) {
            _leftNum = [_labelResult.text doubleValue];
            //计算结果Num3
            _resultNum = _rightNum / _leftNum ;
            _rightNum = _resultNum ;
            NSLog(@"aaaaa%f",_resultNum);
            _lengthString = [NSString stringWithFormat:@"%f", _resultNum];
            _length = [_lengthString length];
            for(int i = 0; i<=5; i++)
            {
                NSString *subString = [_lengthString substringFromIndex:_length - i];
                if([subString isEqualToString:@"0"])
                {
                    _lengthString = [_lengthString substringToIndex:_length - i];
                }
                
            }
            _haveChar = @"";
            _labelResult.text = [NSString stringWithString: _lengthString];
        }else if ([_haveChar isEqualToString:@"＋"])
        {
            _leftNum = [_labelResult.text doubleValue];
            //计算结果Num3
            _resultNum = _rightNum + _leftNum ;
            _rightNum = _resultNum ;
            NSLog(@"aaaaa%f",_resultNum);
            _lengthString = [NSString stringWithFormat:@"%f", _resultNum];
            _length = [_lengthString length];
            for(int i = 0; i<=5; i++)
            {
                NSString *subString = [_lengthString substringFromIndex:_length - i];
                if([subString isEqualToString:@"0"])
                {
                    _lengthString = [_lengthString substringToIndex:_length - i];
                }
                
            }
            _haveChar = @"";
            _labelResult.text = [NSString stringWithString: _lengthString];
        }else if ([_haveChar isEqualToString:@"－"])
        {
            _leftNum = [_labelResult.text doubleValue];
            //计算结果Num3
            _resultNum = _rightNum - _leftNum ;
            _rightNum = _resultNum ;
            NSLog(@"aaaaa%f",_resultNum);
            _lengthString = [NSString stringWithFormat:@"%f", _resultNum];
            _length = [_lengthString length];
            for(int i = 0; i<=5; i++)
            {
                NSString *subString = [_lengthString substringFromIndex:_length - i];
                if([subString isEqualToString:@"0"])
                {
                    _lengthString = [_lengthString substringToIndex:_length - i];
                }
                
            }
            _haveChar = @"";
            _labelResult.text = [NSString stringWithString: _lengthString];
        }
        else if ([_haveChar isEqualToString:@"×"])
        {
            _leftNum = [_labelResult.text doubleValue];
            //计算结果Num3
            _resultNum = _rightNum * _leftNum ;
            _rightNum = _resultNum ;
            NSLog(@"aaaaa%f",_resultNum);
            _lengthString = [NSString stringWithFormat:@"%f", _resultNum];
            _length = [_lengthString length];
            for(int i = 0; i<=5; i++)
            {
                NSString *subString = [_lengthString substringFromIndex:_length - i];
                if([subString isEqualToString:@"0"])
                {
                    _lengthString = [_lengthString substringToIndex:_length - i];
                }
                
            }
            _haveChar = @"";
            _labelResult.text = [NSString stringWithString: _lengthString];
        }
        _labelOperators.text = @" = ";
        _labelDisplay.text = @"";
        
        isFinish = YES;
    }
}

-(void)clean:(id)sender
{
    _lengthString = @"";
    _resultNum = 0;
    _rightNum = 0;
    _leftNum = 0;
    _length = 0;
    [_display setString:@""];
    _labelDisplay.text = @"";
    _labelOperators.text = @"";
    _labelResult.text = @"0";
    _haveChar = @"";
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化可变字符串，分配内存
    self.display=[NSMutableString stringWithCapacity:10];
    _haveChar = @"";
    
    
    //MARK1 : -总体UI搭建和相关设置
    
    //设置按钮区域总宽高，显示label总宽高，单个按钮宽高
    float ButtonWidth = MainScreenWidth/4;
    float ButtonHeight = ButtonWidth;
    float ButtonRectHeight = ButtonHeight*5;
    float ButtonRectWidth = MainScreenWidth ;
    float ResultLabelRectHeight = MainScreenHeight-ButtonRectHeight;
    float ResultLabelRectWidth = MainScreenWidth ;
    
    //获取屏幕高度/宽度
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    _DeviceScreenWidth = size.width;
    _DeviceScreenHeight = size.height;
    
    NSString * DeviceVersion ;
    
    //判断机型，设置全局Button字体
    if (_DeviceScreenWidth == 320 && _DeviceScreenHeight == 480)
    {
        DeviceVersion = @"IPhone4";
        _fontSize = 26;
    }
    else if (_DeviceScreenWidth == 320 && _DeviceScreenHeight == 568)
    {
        DeviceVersion = @"IPhone5/5s" ;
        _fontSize = 32 ;
    }
    else if (_DeviceScreenWidth == 375 && _DeviceScreenHeight == 667)
    {
        DeviceVersion = @"IPhone6/7" ;
        _fontSize = 36 ;
    }
    else if (_DeviceScreenWidth == 414 && _DeviceScreenHeight == 736)
    {
        DeviceVersion = @"IPhone6P/7P" ;
        _fontSize = 40 ;
    }
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UILabel *labelRect = [[UILabel alloc]initWithFrame:CGRectMake(0, ResultLabelRectHeight, ButtonWidth*3, ButtonHeight)];
    labelRect.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:labelRect];
    
    
    //搭建UI
    
    //创建ResultLabel1
    self.labelResult = [[UILabel alloc]initWithFrame:CGRectMake(0, ResultLabelRectHeight/2, ResultLabelRectWidth-20, ResultLabelRectHeight/2)] ;
    [self.view addSubview:_labelResult] ;
    self.labelResult.backgroundColor = [UIColor blackColor] ;
    self.labelResult.textColor = [UIColor whiteColor] ;
    self.labelResult.textAlignment = NSTextAlignmentRight;
    self.labelResult.font = [UIFont systemFontOfSize:_fontSize] ;
    self.labelResult.text = @"0";
    
    //创建ResultlabelDisplay
    _labelDisplay = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, ResultLabelRectWidth-20, ResultLabelRectHeight/2)];
    [self.view addSubview:_labelDisplay];
    self.labelDisplay.backgroundColor = [UIColor blackColor] ;
    self.labelDisplay.textColor = [UIColor whiteColor] ;
    self.labelDisplay.textAlignment = NSTextAlignmentRight;
    self.labelDisplay.font = [UIFont systemFontOfSize:_fontSize-15] ;
    
    
    //创建ResultlabelOperators
    _labelOperators = [[UILabel alloc]initWithFrame:CGRectMake(0, ButtonWidth+30, ButtonWidth/2, ButtonHeight-30)];
    [self.view addSubview:_labelOperators];
    self.labelOperators.backgroundColor = [UIColor blackColor] ;
    self.labelOperators.textColor = [UIColor whiteColor] ;
    self.labelOperators.textAlignment = NSTextAlignmentCenter;
    self.labelOperators.font = [UIFont systemFontOfSize:_fontSize-6] ;
    
    //添加1-9数字
    NSArray * array = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil] ;
    int n = 0 ;
    for (int i = 1 ; i<4; i++)
    {
        for (int j = 0; j<3; j++)
        {
            self.button = [UIButton buttonWithType:UIButtonTypeCustom] ;
            self.button.frame = CGRectMake(0+ButtonRectWidth/4*j, ResultLabelRectHeight+ButtonRectHeight/5*i, ButtonWidth, ButtonHeight);
            [self.button setBackgroundImage:[UIImage imageNamed:@"keypad_button_darker_background"] forState:UIControlStateNormal];
            [self.button setTitle:[array objectAtIndex:n++] forState:UIControlStateNormal] ;
            [self.button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            
            //设置字体
            self.button.titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:_fontSize];
            
            //设置边框粗细颜色
            [self.button.layer setMasksToBounds:YES];
            self.button.layer.cornerRadius = 0.0 ;
            self.button.layer.borderWidth = 0.5 ;
            self.button.layer.borderColor = [[UIColor darkGrayColor]CGColor];
            self.button.tag = n;
            
            [self.view addSubview:_button] ;
            [self.button addTarget:self action:@selector(num:) forControlEvents:UIControlEventTouchUpInside] ;
        }
    }
    
    
    //添加数字 ”0“
    UIButton *button0 = [UIButton buttonWithType:UIButtonTypeCustom];
    button0.frame = CGRectMake(ButtonWidth, ResultLabelRectHeight+ButtonRectHeight/5*4, ButtonWidth, ButtonHeight);
    
    //设置字体
    button0.titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:_fontSize];
    
    //设置按钮边框
    [button0.layer setMasksToBounds:YES];
    button0.layer.cornerRadius = 0.0;
    button0.layer.borderWidth = 0.5;
    [button0.layer setBorderColor:[[UIColor darkGrayColor]CGColor]];
    
    [button0 setTitle:@"0" forState:UIControlStateNormal];
    [button0 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button0 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    button0.tag = 0;
    [button0 setBackgroundImage:[UIImage imageNamed:@"keypad_button_darker_background"] forState:UIControlStateNormal];
    [button0 addTarget:self action:@selector(numZero:) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:button0] ;
    
    
    //添加 “.” 小数点
    UIButton *buttonPoint = [UIButton buttonWithType:UIButtonTypeCustom] ;
    [buttonPoint setFrame:CGRectMake(0, ResultLabelRectHeight+ButtonRectHeight/5*4, ButtonWidth, ButtonHeight)];
    [buttonPoint setBackgroundImage:[UIImage imageNamed:@"keypad_button_darker_background"] forState:UIControlStateNormal];
    [buttonPoint setTitle:@"." forState:UIControlStateNormal] ;
    [buttonPoint setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [buttonPoint setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    buttonPoint.titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:_fontSize];
    
    buttonPoint.tag = 10;
    
    [buttonPoint.layer setMasksToBounds:YES];
    buttonPoint.layer.borderWidth = 0.5;
    [buttonPoint.layer setBorderColor:[[UIColor darkGrayColor]CGColor]] ;
    
    
    [buttonPoint addTarget:self action:@selector(point:) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:buttonPoint] ;
    
    
    
    //添加运算符：
    NSArray *array1 = [NSArray arrayWithObjects:@"＋",@"－",@"×",@"÷", nil] ;
    for (int i = 0; i<4; i++)
    {
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button1 setFrame:CGRectMake(ButtonWidth*3, ResultLabelRectHeight+ButtonHeight*i, ButtonWidth, ButtonWidth)] ;
        [button1 setTitle:[array1 objectAtIndex:i] forState:UIControlStateNormal];
        [button1 setBackgroundImage:[UIImage imageNamed:@"keypad_button_colored_background"] forState:UIControlStateNormal];
        [button1 setTintColor:[UIColor whiteColor]];
        
        
        [button1.layer setMasksToBounds:YES];
        [button1.layer setCornerRadius:0.0];
        [button1.layer setBorderWidth:.5];
        [button1.layer setBorderColor:[[UIColor darkGrayColor]CGColor]];
        
        [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        button1.titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:_fontSize] ;
        [self.view addSubview: button1] ;
        [button1 addTarget:self action:@selector(operators:) forControlEvents:UIControlEventTouchUpInside] ;
    }
    
    //添加 “=” 号 EqualSign
    UIButton *buttonEqualSign = [UIButton buttonWithType:UIButtonTypeCustom] ;
    [buttonEqualSign setFrame:CGRectMake(ButtonWidth*3, ResultLabelRectHeight+ButtonRectHeight/5*4,ButtonWidth, ButtonHeight)] ;
    [buttonEqualSign setTitle:@"＝" forState:UIControlStateNormal] ;
    [buttonEqualSign setBackgroundImage:[UIImage imageNamed:@"keypad_button_colored_background"] forState:UIControlStateNormal];
    
    [buttonEqualSign setTintColor:[UIColor whiteColor]];
    
    [buttonEqualSign.layer setMasksToBounds:YES];
    [buttonEqualSign.layer setCornerRadius:0.0];
    [buttonEqualSign.layer setBorderWidth:.5];
    [buttonEqualSign.layer setBorderColor:[[UIColor darkGrayColor]CGColor]];
    
    buttonEqualSign.titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:_fontSize];
    
    [buttonEqualSign addTarget:self action:@selector(run:) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:buttonEqualSign] ;
    
    //添加”AC“建 clean
    UIButton * buttonClean = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
    [buttonClean setFrame:CGRectMake(0, ResultLabelRectHeight, ButtonWidth, ButtonHeight)] ;
    [buttonClean setTitle:@"AC" forState:UIControlStateNormal] ;
    [buttonClean setTintColor:[UIColor whiteColor]];
    
    [buttonClean.layer setMasksToBounds:YES];
    [buttonClean.layer setCornerRadius:.0];
    [buttonClean.layer setBorderWidth:.5];
    [buttonClean.layer setBorderColor:[[UIColor grayColor]CGColor]];
    
    buttonClean.titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:_fontSize];
    [buttonClean addTarget:self action:@selector(clean:) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:buttonClean] ;
    
    
    //添加“back”按钮
    UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeCustom] ;
    [buttonBack setFrame:CGRectMake(ButtonWidth*2, ResultLabelRectHeight+ButtonHeight*4, ButtonWidth, ButtonHeight)] ;
    [buttonBack setImage:[UIImage imageNamed:@"erase_symbol"]forState:UIControlStateNormal];
    [buttonBack setBackgroundImage:[UIImage imageNamed:@"keypad_button_darker_background"] forState:UIControlStateNormal];
    [buttonBack setTintColor:[UIColor blackColor]];
    
    [buttonBack.layer setMasksToBounds:YES];
    [buttonBack.layer setCornerRadius:.0];
    [buttonBack.layer setBorderWidth:.5];
    [buttonBack.layer setBorderColor:[[UIColor grayColor]CGColor]];
    
    [buttonBack addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:buttonBack] ;
    
    //添加“+/-”按钮
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button3 setFrame:CGRectMake(ButtonWidth*2, ResultLabelRectHeight, ButtonWidth, ButtonHeight)];
    [button3 setTitle:@"±" forState:UIControlStateNormal];
    [button3 setTintColor:[UIColor whiteColor]];
    
    
    [button3.layer setMasksToBounds:YES];
    [button3.layer setCornerRadius:.0];
    [button3.layer setBorderWidth:.5];
    [button3.layer setBorderColor:[[UIColor grayColor]CGColor]];
    
    [button3.layer setMasksToBounds:YES];
    [button3.layer setBorderWidth:.5];
    [button3.layer setBorderColor:[[UIColor grayColor]CGColor]];
    
    button3.titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:_fontSize];
    [button3 addTarget:self action:@selector(overTern:) forControlEvents:UIControlStateNormal];
    [self.view addSubview:button3];
    
    
    //添加“%” 按钮
    UIButton *buttonPercent = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonPercent setFrame:CGRectMake(ButtonWidth*1, ResultLabelRectHeight, ButtonWidth, ButtonHeight)];
    [buttonPercent setTitle:@"％" forState:UIControlStateNormal];
    [buttonPercent setTintColor:[UIColor whiteColor]];
    
    
    [buttonPercent.layer setMasksToBounds:YES];
    [buttonPercent.layer setCornerRadius:.0];
    [buttonPercent.layer setBorderWidth:.5];
    [buttonPercent.layer setBorderColor:[[UIColor grayColor]CGColor]];
    
    [buttonPercent.layer setMasksToBounds:YES];
    [buttonPercent.layer setBorderWidth:.5];
    [buttonPercent.layer setBorderColor:[[UIColor grayColor]CGColor]];
    
    buttonPercent.titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:_fontSize];
    [buttonPercent addTarget:self action:@selector(percent:) forControlEvents:UIControlStateNormal];
    [self.view addSubview:buttonPercent];
    //以上完成UI搭建
    
    
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
