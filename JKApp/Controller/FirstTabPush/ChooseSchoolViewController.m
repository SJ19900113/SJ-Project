//
//  ChooseSchoolViewController.m
//  JKApp
//
//  Created by Apple on 2020/2/20.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "ChooseSchoolViewController.h"
#import "ControllerFunc.h"
#import "MainViewController.h"

@interface ChooseSchoolViewController ()

@end

@implementation ChooseSchoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backButtonAction:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"提交后可以获得专属的学车咨询服务，确定要返回吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *conform = [UIAlertAction actionWithTitle:@"确定返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[ControllerFunc mainController] closeChooseSchoolViewController];
        }];
    //2.2 取消按钮
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"继续咨询" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了继续咨询");
    }];

    //2.3 还可以添加文本框 通过 alert.textFields.firstObject 获得该文本框
//    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//        textField.placeholder = @"请填写您的反馈信息";
//    }];
     
    //3.将动作按钮 添加到控制器中
    [alert addAction:conform];
    [alert addAction:cancel];
        
    //4.显示弹框
    [self presentViewController:alert animated:YES completion:nil];
}


@end
