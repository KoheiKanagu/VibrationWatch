//
//  ViewController.m
//  VibrationWatch
//
//  Created by Kohei on 2014/07/19.
//  Copyright (c) 2014年 KoheiKanagu. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    countStartTimesArray = [[NSMutableArray alloc]init];
}



-(IBAction)setButton:(id)sender
{
    NSDate *date = myDatePicker.date;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *dateStr = [formatter stringFromDate:date];
    
    [countStartTimesArray addObject:dateStr];
    [myTableview reloadSections:[NSIndexSet indexSetWithIndex:0]
               withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self setLocalNotification:date];
}


-(void)setLocalNotification:(NSDate *)date
{
    [self setNotification:date
                 interval:1800
                     body:@"30分経過"
                   action:nil];
    [self setNotification:date
                 interval:1802
                     body:nil
                   action:nil];
    
    [self setNotification:date
                 interval:2700
                     body:@"45分経過"
                   action:nil];
    [self setNotification:date
                 interval:2702
                     body:nil
                   action:nil];
    [self setNotification:date
                 interval:2704
                     body:nil
                   action:nil];
}

-(void)setNotification:(NSDate *)date interval:(NSInteger )interval body:(NSString *)bodyString action:(NSString *)actionString
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [date dateByAddingTimeInterval:interval];
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.alertBody = bodyString;
    notification.alertAction = actionString;
    notification.soundName = UILocalNotificationDefaultSoundName;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}



-(IBAction)removeButton:(id)sender
{
    NSArray *array = [[UIApplication sharedApplication] scheduledLocalNotifications];
    
    for(UILocalNotification *notification in array){
        [[UIApplication sharedApplication] cancelLocalNotification:notification];
    }
    
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"確認", nil)
                                                message:[NSString stringWithFormat:@"Removed %ld", array.count]
                                               delegate:nil
                                      cancelButtonTitle:NSLocalizedString(@"閉じる", nil)
                                      otherButtonTitles:nil, nil];
    [av show];
    
    [countStartTimesArray removeAllObjects];
    [myTableview reloadData];
}



#pragma mark - TableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return countStartTimesArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"
                                                            forIndexPath:indexPath];
    cell.textLabel.text = countStartTimesArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [tableView beginUpdates];
        
//        NSString *removeObjectName = countStartTimesArray[indexPath.row];
        
        [countStartTimesArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationRight];
        
        [tableView endUpdates];
    }
}


@end
