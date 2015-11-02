//
//  BottomMenuController.m
//  AdvancedEpubReader
//
//  Created by Kudinov Denis on 22.10.15.
//  Copyright © 2015 Trinity Digital. All rights reserved.
//

#import "BottomMenuController.h"

#import "SliderNavigationDelegate.h"
#import "MainBookInfoDelegate.h"

@interface BottomMenuController ()

@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UILabel *pageCounter;

@end

@implementation BottomMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.slider setThumbImage:[UIImage imageNamed:@"thumb"] forState:UIControlStateNormal];
    [self.slider setThumbImage:[UIImage imageNamed:@"thumb"] forState:UIControlStateHighlighted];
    [self.slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchCancel];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sliderValueChanged:(UISlider *)slider {
    [self.readerController showPageAtPercent:slider.value];
    [self updateLabel];
}

- (void)updatePercent:(float)percent {
    [self.slider setValue:percent animated:YES];
    [self updateLabel];
}

- (void)updateLabel {
    NSInteger totalPages = [self.readerController spine].count;
    NSInteger currentPage = self.slider.value * totalPages;
    self.pageCounter.text = [NSString stringWithFormat:@"%@ из %@", @(currentPage + 1), @(totalPages)];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
