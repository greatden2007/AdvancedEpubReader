//
//  ReaderController.h
//  AdvancedEpubReader
//
//  Created by Kudinov Denis on 30.09.15.
//  Copyright © 2015 Trinity Digital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReaderController : UIViewController

// расчёт на вызов после viewDidLoad (например при инициализации через сториборд (initiateInitialViewController:))
// при инициализации через segue такой метод не прокатит (можете допилить самостоятельно)
// пока такой нужды нет
- (void)setEpubName:(NSString *)epubName;

@end
