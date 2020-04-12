//
//  ControllerFunc.m
//  JKApp
//
//  Created by Apple on 2020/2/20.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "ControllerFunc.h"
#import "AppDelegate.h"
#import "SecondViewController.h"

@implementation ControllerFunc

+ (AppDelegate *)appDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

+ (MainViewController *)mainController {
    return self.appDelegate.mainController;
}

+ (SecondViewController *)secondController {
    return self.appDelegate.secondController;
}

+ (Ke1ViewController *)secondK1Controller {
    return self.secondController.ke1VC;
}


@end


@implementation NSSortDescriptor (JKHelper)

+ (NSArray *)sortDescriptorsWithKeys:(NSArray *)keys {
    NSMutableArray *array = [NSMutableArray array];
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSSortDescriptor * sort = [NSSortDescriptor sortDescriptorWithKey:obj ascending:YES];
        [array addObject:sort];
    }];
    return array;
}

+ (NSArray *)sortDescriptorsDescendingWithKeys:(NSArray *)keys {
    NSMutableArray * array = [NSMutableArray array];
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSSortDescriptor * sort = [NSSortDescriptor sortDescriptorWithKey:obj ascending:NO];
        [array addObject:sort];
    }];
    return array;
}

@end
