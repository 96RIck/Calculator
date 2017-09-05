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
-(void)shuzi:(id)sender
{
    [self.string appendString:[sender currentTitle]];       //数字追加到string
    
    //初始化ResultString
    _resultString = _string;
   
    
    
    
    
//MARK: -控制输入数字时“.”的出现次数为1次。检测到点的个数超过一个时，删除掉最后一个

    if (notAppendPoint == YES)
    {
        
        
        if ([[sender currentTitle] isEqualToString:@"."])   //判断最新追加的字符是为“.”
        {
            if ([_label1.text isEqualToString:@"0"] | [_label1.text isEqualToString:@"0."] | [_string isEqualToString:@"."])        //判断是否直接追加各位为0的小数
            {
                //如果直接输入小数点，则显示0.
                [_string setString:@"0."];
            }
            else if ((_num1 == 0) && [_label1.text isEqualToString:@"."])
            {
                NSRange deleteRange = {[_string length] -1,1};  //创建deleteRange
                [_string deleteCharactersInRange:deleteRange];//将NSMutaleString多余添加的"."删除
            }
            
            havePoint = YES;
        }
    }
    
    if ([[sender currentTitle] isEqualToString:@"."]) //判断输入的字符是否为"."
    {
        NSString *str1 = @".";
        [_resultString stringByAppendingString:str1];
        notAppendPoint = YES;                                      //将不在追加“.”
    }
    
    //打印bool值 NSLog(@"appendPoint value: %@" ,notAppendPoint?@"YES":@"NO");
    //显示数值
    NSLog(@"AAAAAAA%@",_string);
    self.label1.text = [NSString stringWithString:_resultString];
    self.num1 = [self.label1.text doubleValue];
    NSLog(@"self.num1 is %Lf",self.num1) ;
    
}

-(void) run:(id)sender
{
    if ([_characterStr isEqualToString:@""])
    {
        _characterStr = [sender currentTitle];
        _num2 = _num1;
        NSLog(@"self.num2 is %Lf",_num2);
        
        _label2.text = [NSString stringWithString:_string];
        [_string setString:@""];
        _label3.text = [sender currentTitle];
        _label1.text = @"0";
        
    }
    else
    {
        if ([_characterStr isEqualToString:@"＋"]) {
            _characterStr = [sender currentTitle];
            //把新输入的_string加入到_num1中
            _num1 = [_label1.text doubleValue];
            //计算结果Num3
            _num3 = _num2 +_num1 ;
            _num2 = _num3 ;
            NSLog(@"aaaaa%Lf",_num3);
            
            _lengthString = [NSString stringWithFormat:@"%Lf", _num3];
            
            _length = [_lengthString length];
            for(int i = 0; i<=5; i++)
            {
                NSString *subString = [_lengthString substringFromIndex:_length - i];
                if([subString isEqualToString:@"0"])
                {
                    _lengthString = [_lengthString substringToIndex:_length - i];
                }
                
            }
            
            [_string setString:@""];
            _label3.text = [sender currentTitle];
            _label1.text = @"0";
            _num1 = 0;
            [_label2 setText:_lengthString];
        }
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];

    //初始化可变字符串，分配内存
    self.string=[NSMutableString stringWithCapacity:10];
    self.characterStr = [[NSString alloc]init];
    

    
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
    
    NSLog(@"appendPoint value: %@" ,notAppendPoint?@"YES":@"NO");

    
    //搭建UI
    
    //创建ResultLabel1
    self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, ResultLabelRectHeight/2, ResultLabelRectWidth-20, ResultLabelRectHeight/2)] ;
    [self.view addSubview:_label1] ;
    self.label1.backgroundColor = [UIColor blackColor] ;
    self.label1.textColor = [UIColor whiteColor] ;
    self.label1.textAlignment = NSTextAlignmentRight;
    self.label1.font = [UIFont systemFontOfSize:_fontSize] ;
    self.label1.text = @"0";
    
    
    //创建ResultLabel2
    _label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, ResultLabelRectWidth-20, ResultLabelRectHeight/2)];
    [self.view addSubview:_label2];
    self.label2.backgroundColor = [UIColor blackColor] ;
    self.label2.textColor = [UIColor whiteColor] ;
    self.label2.textAlignment = NSTextAlignmentRight;
    self.label2.font = [UIFont systemFontOfSize:_fontSize-15] ;
    
    
    //创建ResultLabel3
    _label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, ButtonWidth+30, ButtonWidth/2, ButtonHeight-30)];
    [self.view addSubview:_label3];
    self.label3.backgroundColor = [UIColor blackColor] ;
    self.label3.textColor = [UIColor whiteColor] ;
    self.label3.textAlignment = NSTextAlignmentCenter;
    self.label3.font = [UIFont systemFontOfSize:_fontSize-6] ;
    
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
            
            [self.view addSubview:_button] ;
            [self.button addTarget:self action:@selector(shuzi:) forControlEvents:UIControlEventTouchUpInside] ;
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
    
    [button0 setBackgroundImage:[UIImage imageNamed:@"keypad_button_darker_background"] forState:UIControlStateNormal];
    [button0 addTarget:self action:@selector(shuzi:) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:button0] ;
    
    
    //添加 “.” 小数点
    UIButton *buttonPoint = [UIButton buttonWithType:UIButtonTypeCustom] ;
    [buttonPoint setFrame:CGRectMake(0, ResultLabelRectHeight+ButtonRectHeight/5*4, ButtonWidth, ButtonHeight)];
    [buttonPoint setBackgroundImage:[UIImage imageNamed:@"keypad_button_darker_background"] forState:UIControlStateNormal];
    [buttonPoint setTitle:@"." forState:UIControlStateNormal] ;
    [buttonPoint setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [buttonPoint setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    buttonPoint.titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:_fontSize];
    
    [buttonPoint.layer setMasksToBounds:YES];
    buttonPoint.layer.borderWidth = 0.5;
    [buttonPoint.layer setBorderColor:[[UIColor darkGrayColor]CGColor]] ;
    
    
    [buttonPoint addTarget:self action:@selector(shuzi:) forControlEvents:UIControlEventTouchUpInside] ;
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
        [button1 addTarget:self action:@selector(run:) forControlEvents:UIControlEventTouchUpInside] ;
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
