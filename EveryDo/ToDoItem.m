//
//  ToDoItem.m
//  EveryDo
//
//  Created by Daniel Grosman on 2017-11-14.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

#import "ToDoItem.h"

@implementation ToDoItem

- (instancetype) initWithTitle:(NSString *)title todoDescription:(NSString *)todoDescription priorityNumber:(NSInteger)priorityNuber isCompleted:(BOOL) isCompleted {
    if (self = [super init]) {
        _title = title;
        _todoDescription = todoDescription;
        _priorityNumber = priorityNuber;
        _isCompleted = isCompleted;
    }
    return self;
}

@end
