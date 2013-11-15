//
//  ViewController.m
//  Capstone
//
//  Created by user on 11/15/13.
//  Copyright (c) 2013 Classroom. All rights reserved.
//

#import "ViewController.h"
#import "Food.h"

@interface ViewController ()

@end

@implementation ViewController

//- (void)getJson:(NSURL *)url json_p:(NSArray **)json_p
//{
//    NSData *data = [NSData dataWithContentsOfURL:url];
//   
//    if (data != nil) {
//        
//        NSError *error ;
//        
//        
//        *json_p = [NSJSONSerialization JSONObjectWithData:data
//                                                  options:NSJSONReadingAllowFragments
//                                                    error:&error];
//        if(error != nil ){
//            NSLog(@"error connecting to the url %@", [error description]);
//        }
//    }
//}


- (id)getJson2:(NSURL *)url
{
    NSData *data = [NSData dataWithContentsOfURL:url];
    id jsonObject;
    
    if (data != nil) {
        
        NSError *error ;
        
        
         jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                  options:NSJSONReadingAllowFragments
                                                    error:&error];
        if(error != nil ){
            NSLog(@"error connecting to the url %@", [error description]);
        }
        
    }
    return jsonObject;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSURL *url = [NSURL URLWithString:@"http://northwind.accelebrate.com/product"];

    NSArray *jsonArray;
    id jsonObject = [self getJson2:url];
    jsonArray = jsonObject;
    
    self.arrayFood = [NSMutableArray arrayWithCapacity:8];
        
    for (NSDictionary *diction in jsonArray) {
            NSString *item = [diction objectForKey:@"ID"];
            NSString *name = [diction objectForKey:@"Name"];
        
            Food *food = [[Food alloc]init];
            food.num = [item intValue];
            food.name = name;
        
        
            NSLog(@"food: %@", food.name);

            [self.arrayFood addObject:food];
            
    }
  
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.arrayFood.count;
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    Food *food       = [self.arrayFood objectAtIndex:row];
    return food.name;
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    Food    *food   = [self.arrayFood objectAtIndex:row];
    NSString *urlString = [NSString stringWithFormat:@"http://northwind.accelebrate.com/product/%d",food.num];
  
    NSLog(@"url is %@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];

    id jsonObject = [self getJson2:url];
    NSDictionary *dictionary = jsonObject;
    NSArray *products = [dictionary objectForKey:@"Products"];
    self.arrayFoodPrice = products;
    NSLog(@"Item details %@", products[0] );

  
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.arrayFoodPrice.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell *cell =  [self.tableView dequeueReusableCellWithIdentifier:@"cellView"];
    cell.textLabel.text = [[self.arrayFoodPrice objectAtIndex:indexPath.row] objectForKey:@"Name"];
    return cell;
}
@end
