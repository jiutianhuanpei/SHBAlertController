//
//  ViewController.m
//  UIAlertController_Demo
//
//  Created by 沈红榜 on 15/11/20.
//  Copyright © 2015年 沈红榜. All rights reserved.
//

#import "ViewController.h"
#import "SHBAlertController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor yellowColor];
}


- (IBAction)showAlertView:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"转发给 医生" message:@"二货 的病历" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"留言";
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Send" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:true completion:nil];
    
}

- (IBAction)showCustomAlertView:(id)sender {
    SHBAlertController *alert = [[SHBAlertController alloc] initWithTitle:@"I wanna you" image:[UIImage imageNamed:@"9.jpg"] message:@"YES, I'll follow you"];
    [alert addAction:[SHBAction actionWithTitle:@"Cancel" action:^{
        
    }]];
    [alert addAction:[SHBAction actionWithTitle:@"Send" action:^{
        
        NSLog(@"%@", alert.content);
        
    }]];
    
    [alert show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
