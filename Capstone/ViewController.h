//
//  ViewController.h
//  Capstone
//
//  Created by user on 11/15/13.
//  Copyright (c) 2013 Classroom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate,UITableViewDataSource, UITableViewDelegate >

@property (weak, nonatomic) IBOutlet UIPickerView *pcikerView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *testLabel;
@property (strong, nonatomic) NSMutableArray *arrayFood;
@property (strong, nonatomic) NSMutableArray *arrayFoodPrice;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
