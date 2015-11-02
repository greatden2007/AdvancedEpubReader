//
//  TopMenuController.m
//  AdvancedEpubReader
//
//  Created by Kudinov Denis on 22.10.15.
//  Copyright © 2015 Trinity Digital. All rights reserved.
//

#import "TopMenuController.h"

#import "TOCController.h"

#import "TableOfContentsDelegate.h"

@interface TopMenuController ()

@end

@implementation TopMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    id dvc = [segue destinationViewController];
    if ([dvc isKindOfClass:[UINavigationController class]]) {
        if ([[dvc viewControllers][0] isKindOfClass:[TOCController class]]) {
            TOCController *tocvc = (TOCController *)[dvc viewControllers][0];
            [tocvc setTocDelegate:self.readerController];
        }
    }
}


- (IBAction)back:(id)sender {
    [self.readerController back];
}


@end
