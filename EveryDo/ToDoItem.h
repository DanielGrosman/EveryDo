//
//  ToDoItem.h
//  EveryDo
//
//  Created by Daniel Grosman on 2017-11-14.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *todoDescription;
@property (nonatomic, assign) NSInteger priorityNumber;
@property (nonatomic, strong) NSDate *deadline;
@property (nonatomic) BOOL isCompleted;

- (instancetype) initWithTitle:(NSString *)title todoDescription:(NSString *)todoDescription priorityNumber:(NSInteger)priorityNuber deadline:(NSDate *)deadline isCompleted:(BOOL) isCompleted;

@end
