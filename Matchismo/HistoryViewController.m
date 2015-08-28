//
//  HistoryViewController.m
//  Matchismo
//
//  Created by simon jenni on 28/08/2015.
//  Copyright (c) 2015 Acme. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.attributedText = self.text;
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.textView setAttributedText:self.text];
}

@end
