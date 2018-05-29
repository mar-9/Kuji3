//
//  ViewController.m
//  Kuji3
//
//  Created by SONE MASANORI on 2014/04/15.
//  Copyright (c) 2014年 SONE MASANORI. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize lbl;
@synthesize textDisplay;
@synthesize bt_start;
@synthesize bt_reset;
@synthesize textInit;
@synthesize switch_dup;

- (void)viewDidLoad
{
    [super viewDidLoad];
    timeflg = FALSE;
    counter = 40;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:(0.1) target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
    
    ar = [NSMutableArray array];
    
    for(int i = 0; i <counter; i++){
        [ar insertObject:[NSString stringWithFormat:@"%d", i+1] atIndex:i];
    }
    
    self.switch_dup.on = NO;
    self.textInit.text = [NSString stringWithFormat:@"%d", counter];
    self.lbl.text = [NSString stringWithFormat:@"%d", counter];
    self.textDisplay.text = @"";
    [self.bt_start setTitle:@"スタート" forState:UIControlStateNormal];
    [self.bt_reset setTitle:@"リセット" forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onTimer
{
    if(timeflg){
        
        if(counter > 0){
            hit_idx = rand() % counter;
            self.lbl.text = [ar objectAtIndex:hit_idx];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textInit resignFirstResponder];
}

- (IBAction)start_touchdown:(id)sender
{
    if(!timeflg){
        
        [self.bt_start setTitle:@"ストップ" forState:UIControlStateNormal];
        srand(time(NULL));
        timeflg = TRUE;
        
    }else{
        
        [self.bt_start setTitle:@"スタート" forState:UIControlStateNormal];
        if(counter > 0){
            
            NSString *hit_number = [ar objectAtIndex:hit_idx];
            
            // 重複を許容しない場合は配列から取り除く
            if(!self.switch_dup.on){
                counter--;
                [ar removeObjectAtIndex:hit_idx];
            }
            
            // すでに使用した番号のメモを表示するための処理
            NSString *newbuffer =  [[hit_number stringByAppendingString:@"\n"]
                                    stringByAppendingString:self.textDisplay.text];
            CGSize size = [newbuffer
                           sizeWithFont:textDisplay.font
                           constrainedToSize:CGSizeMake(textDisplay.bounds.size.width, 2000)
                           lineBreakMode:NSLineBreakByCharWrapping];
            textDisplay.frame = CGRectMake(textDisplay.frame.origin.x,
                                           textDisplay.frame.origin.y,
                                           textDisplay.bounds.size.width,
                                           size.height);
            self.textDisplay.text =  newbuffer;
            
        }
        
        timeflg = FALSE;
    }
}

- (IBAction)reset_down:(id)sender
{
    [self text_change:self.textInit];
}

- (IBAction)text_change:(id)sender
{
    timeflg = FALSE;
    self.textDisplay.text = @"";
    
    @try {
        counter = [textInit.text intValue];
    }
    @catch (NSException *exception) {
        counter = 0;
    }
    
    self.lbl.text = textInit.text;
    for(int i = 0; i <counter; i++){
        [ar insertObject:[NSString stringWithFormat:@"%d", i+1] atIndex:i];
    }
}

@end

