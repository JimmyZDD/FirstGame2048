//
//  ViewController.m
//  UIGame2048Demo
//
//  Created by zhao on 15/12/28.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
#pragma mark - 代码比较low

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _labelTagArray = [[NSMutableArray alloc]initWithCapacity:0];
    _labelArray1 = [[NSMutableArray alloc]initWithCapacity:0];
    _labelTextArray = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i = 0; i<16; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(7+(i%4)*100, 50+i/4*100, 90, 90)];
        label.tag = i+2001;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:20];
        label.layer.borderColor = [[UIColor blackColor]CGColor];
        label.layer.borderWidth = 2.0;
        label.layer.cornerRadius = 10;
        label.clipsToBounds = YES;
        label.backgroundColor = [UIColor lightGrayColor];
        [_labelTagArray addObject:label];
        [self.view addSubview:label];
    }
    for (int i = 0; i<2; i++) {
        int a = arc4random()%_labelTagArray.count;
        ((UILabel *)_labelTagArray[a]).text = @"2";
        [_labelTagArray removeObject:(UILabel *)_labelTagArray[a]];
    }
    for (int i = 0; i<4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.center = CGPointMake(cos(i*90/180.0*M_PI)*80+self.view.center.x, sin(i*90/180.0*M_PI)*80+580);
        button.bounds = CGRectMake( 0, 0, 50*(i%2)+80*((i+1)%2), 50*((i+1)%2)+80*(i%2));
        button.backgroundColor = [UIColor orangeColor];
        button.tag = i+1001;
        button.layer.cornerRadius = 30;
        button.clipsToBounds = YES;
        [button addTarget:self action:@selector(clickDown:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    _scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 666, 80, 50)];
    _scoreLabel.layer.cornerRadius = 10;
    _scoreLabel.clipsToBounds = YES;
    _scoreLabel.numberOfLines = 0;
    _scoreLabel.backgroundColor = [UIColor lightGrayColor];
    _scoreLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_scoreLabel];
}

- (void)clickDown:(UIButton *)sender {
    static int e = 0;
    e++;
    switch (sender.tag) {
        case 1004:
            for (int i = 0; i<4; i++) {
                [self addSame:(UILabel *)[self.view viewWithTag:2001+i] :(UILabel *)[self.view viewWithTag:2005+i] :(UILabel *)[self.view viewWithTag:2009+i] :(UILabel *)[self.view viewWithTag:2013+i]];
            }
            break;
        case 1003:
            for (int i = 0; i<4; i++) {
                [self addSame:[self.view viewWithTag:2001+i*4] :[self.view viewWithTag:2002+i*4] :[self.view viewWithTag:2003+i*4] :[self.view viewWithTag:2004+i*4]];
            }
            break;
        case 1002:
            for (int i = 0; i<4; i++) {
                [self addSame:[self.view viewWithTag:2013+i] :[self.view viewWithTag:2009+i] :[self.view viewWithTag:2005+i] :[self.view viewWithTag:2001+i]];
            }
            break;
        case 1001:
            for (int i = 0; i<4; i++) {
                [self addSame:[self.view viewWithTag:2004+i*4] :[self.view viewWithTag:2003+i*4] :[self.view viewWithTag:2002+i*4] :[self.view viewWithTag:2001+i*4]];
            }
            break;
        default:
            break;
    }
    _scoreLabel.text = [NSString stringWithFormat:@"分数\n%d",_b];
    if (_labelTagArray.count != 0) {
        _a = arc4random()%_labelTagArray.count;
        ((UILabel *)_labelTagArray[_a]).text = @"2";
        ((UILabel *)_labelTagArray[_a]).backgroundColor = [UIColor lightGrayColor];
        [_labelTagArray removeObject:(UILabel *)_labelTagArray[_a]];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            nil;
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"重玩" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            for (int i = 0; i<16; i++) {
                ((UILabel *)[self.view viewWithTag:2001+i]).text = nil;
                ((UILabel *)[self.view viewWithTag:2001+i]).backgroundColor = [UIColor lightGrayColor];
                [_labelTagArray addObject:(UILabel *)[self.view viewWithTag:2001+i]];
            }
            for (int i = 0; i<2; i++) {
                int a = arc4random()%_labelTagArray.count;
                ((UILabel *)_labelTagArray[a]).text = @"2";
                [_labelTagArray removeObject:(UILabel *)_labelTagArray[a]];
            }

        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:true completion:nil];
      }
}
- (void)addSame:(UILabel *)label1 :(UILabel *)label2 :(UILabel *)label3 :(UILabel *)label4  {
    static int d = 0;
    d++;
    [_labelArray1 addObject:label1];
    [_labelArray1 addObject:label2];
    [_labelArray1 addObject:label3];
    [_labelArray1 addObject:label4];
    NSLog(@"输出label数组 －－－ %@",_labelArray1);
    for (UILabel *label in _labelArray1) {
        if (label.text == nil) {
            NSLog(@"xiaolian");
        } else {
            [_labelTextArray addObject:label.text];
            label.text = nil;
            [_labelTagArray addObject:label];
        }
    }
    NSLog(@"输出label.Text数组 －－－ %@",_labelTextArray);
    if (_labelTextArray.count == 0) {
        //[_labelTextArray removeAllObjects];
        [_labelArray1 removeAllObjects];
        return;
    }else if (_labelTextArray.count == 1){
        ((UILabel *)_labelArray1[0]).text = _labelTextArray[0];
        [_labelTagArray removeObject:(UILabel *)_labelArray1[0]];
    } else {
        for (int i = 0; i<_labelTextArray.count; i++) {
            if (i<_labelTextArray.count-1) {
                if ([_labelTextArray[i] isEqualToString:_labelTextArray[i+1]]) {
                    _b += 2*([_labelTextArray[i] intValue]);
                    ((UILabel *)_labelArray1[i]).text = [NSString stringWithFormat:@"%d",2*([_labelTextArray[i] intValue])];
                    [_labelTagArray removeObject:(UILabel *)_labelArray1[i]];
                    [_labelTextArray removeObjectAtIndex:i+1];
                } else {
                    ((UILabel *)_labelArray1[i]).text = _labelTextArray[i];
                    [_labelTagArray removeObject:(UILabel *)_labelArray1[i]];
                }
            } else {
                ((UILabel *)_labelArray1[_labelTextArray.count-1]).text = _labelTextArray[_labelTextArray.count-1];
                [_labelTagArray removeObject:(UILabel *)_labelArray1[_labelTextArray.count-1]];
            }
        }
    }
    [_labelTextArray removeAllObjects];
    [_labelArray1 removeAllObjects];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
