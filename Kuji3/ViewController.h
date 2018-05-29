//
//  ViewController.h
//  Kuji3
//
//  Created by SONE MASANORI on 2014/04/15.
//  Copyright (c) 2014年 SONE MASANORI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    IBOutlet UILabel *lbl;
    NSTimer *timer;
    
    bool timeflg;
    
    int counter;
    int hit_idx;
    
    NSMutableArray *ar;
    
}

@property (nonatomic, strong) IBOutlet UILabel *lbl;
@property (nonatomic, strong) IBOutlet UIButton *bt_start;
@property (nonatomic, strong) IBOutlet UIButton *bt_reset;

@property (nonatomic, strong) IBOutlet UILabel *textDisplay;
@property (nonatomic, strong) IBOutlet UITextField *textInit;
@property (nonatomic, strong) IBOutlet UISwitch *switch_dup;

- (void)onTimer;
- (IBAction)start_touchdown:(id)sender;
- (IBAction)reset_down:(id)sender;
- (IBAction)text_change:(id)sender;

@end