//
//  ViewController.m
//  DarwBoardDemo
//
//  Created by 彭平军 on 2017/5/31.
//  Copyright © 2017年 彭平军. All rights reserved.
//

#import "ViewController.h"
#import "DrawBoardView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DrawBoardView *view = [[DrawBoardView alloc] initWithFrame:self.view.frame];
    self.view = view;
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
