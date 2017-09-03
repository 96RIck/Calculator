//
//  ViewController.h
//  Calculator
//
//  Created by Rick on 2017/9/2.
//  Copyright © 2017年 Rick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(nonatomic,retain) UIButton *button ;
@property(nonatomic,retain) UILabel *label ;
@property(nonatomic,retain) NSMutableString *string;
@property(nonatomic,assign) double num1,num2,num3;
@property(nonatomic,assign) NSString *str;

@end

