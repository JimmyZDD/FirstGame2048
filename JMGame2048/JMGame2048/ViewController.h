//
//  ViewController.h
//  UIGame2048Demo
//
//  Created by zhao on 15/12/28.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    int               _a,_b,_c;
    NSMutableArray    *_labelTagArray;
    NSMutableArray    *_labelTextArray;
    NSMutableArray    *_labelArray1;
    UILabel           *_scoreLabel;
}


@end

