//
//  TOCController.m
//  AdvancedEpubReader
//
//  Created by Kudinov Denis on 22.10.15.
//  Copyright © 2015 Trinity Digital. All rights reserved.
//

#import "TOCController.h"

#import "TOCCell.h"

#import "TableOfContentsDelegate.h"

@interface TOCController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation TOCController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - NavigationItem Buttons
//-------------------------------------------------
// NavigationItem Buttons
//-------------------------------------------------

- (IBAction)closeTOC:(id)sender {
    [self closeTOCWithCompletion:nil];
}

- (void)closeTOCWithCompletion:(void(^)())completion {
    [self dismissViewControllerAnimated:YES completion:completion];
}

#pragma mark - TableView Delegate
//-------------------------------------------------
// TableView Delegate
//-------------------------------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tocDelegate toc].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TOCCell *cell = [tableView dequeueReusableCellWithIdentifier:[TOCCell className]];
    cell.navPoint = [self.tocDelegate toc][indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self closeTOCWithCompletion:nil];
//    [self closeTOCWithCompletion:^{
        [self.tocDelegate showPageAtIndex:indexPath.row];
//    }];
}

@end
