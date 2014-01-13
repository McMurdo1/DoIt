//
//  ViewController.m
//  DoIt
//
//  Created by Matthew Graham on 1/13/14.
//  Copyright (c) 2014 Matthew Graham. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIGestureRecognizerDelegate>
{
    
    __weak IBOutlet UITextField *myTextField;
    __weak IBOutlet UITableView *myTableView;
    __weak IBOutlet UIButton *editButton;
    BOOL editButtonStatus;
    NSMutableArray *items;
    NSMutableArray *itemColor;
    
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    items = [NSMutableArray arrayWithObjects:@"One", @"Two", @"Three", nil];
    itemColor = [NSMutableArray arrayWithObjects:[UIColor blackColor],[UIColor blackColor],[UIColor blackColor], nil];
    editButtonStatus = NO;
	// Do any additional setup after loading the view, typically from a nib.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myReuseIdentifier"];
    cell.textLabel.text = [items objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [itemColor objectAtIndex:indexPath.row];
     //UISwipeGestureRecognizer *swipedCell = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(cellSwipe:)];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    if (editButtonStatus == NO)
        {
            //selectedCell.textLabel.textColor = [UIColor greenColor];
            [itemColor replaceObjectAtIndex:indexPath.row withObject:[UIColor greenColor]];
            [myTableView reloadData];
        }
    else
    {
        
        [items removeObjectAtIndex:indexPath.row];
        [itemColor removeObjectAtIndex:indexPath.row];
        [myTableView reloadData];
    }
    
    
}

- (IBAction)onAddButtonPressed:(id)sender {
    [items addObject:myTextField.text];
    [itemColor addObject:[UIColor blackColor]];
    [myTableView reloadData];
    myTextField.text = nil;
}

- (IBAction)onEditButtonPressed:(id)sender {
    if (editButtonStatus == NO) {
        editButtonStatus = YES;
        [editButton setTitle:@"Done" forState:(UIControlStateNormal)];
        [editButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    else{
        editButtonStatus = NO;
        [editButton setTitle:@"Edit" forState:(UIControlStateNormal)];
        [editButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [myTextField resignFirstResponder];
    [items addObject:myTextField.text];
    [itemColor addObject:[UIColor blackColor]];
    [myTableView reloadData];
    myTextField.text = nil;
    return YES;
}

//- (IBAction)onSwipeLeft:(id)sender did
//{
//    UITableViewCell *swipedCell = [tableView ]
//}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [items removeObjectAtIndex:indexPath.row];
    [myTableView reloadData];
}




- (IBAction)onSwipeRight:(id)sender {
    NSLog(@"Swiped Right");
   // CGPoint point = [UISwipeGestureRecognizer CG];
    NSIndexPath *selectedIndexPath = [myTableView indexPathForSelectedRow];
    UITableViewCell *swipedCell = [myTableView cellForRowAtIndexPath:selectedIndexPath];
    swipedCell.textLabel.textColor = [UIColor yellowColor];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
