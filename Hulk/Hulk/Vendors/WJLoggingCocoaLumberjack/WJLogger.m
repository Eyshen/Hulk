//
//  WJLogger.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by 吴云海 on 15-12-13.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import "WJLogger.h"

@implementation WJLogger

-(void) error:(NSString*) func format:(NSString*) format, ... {
    va_list args;
    if (format) {
        va_start(args, format);
        NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
        DDLogError(@"[ERROR] %@ %@",func, message);
        va_end(args);
    }
}

-(void) warn:(NSString*) func format:(NSString*) format, ... {
    va_list args;
    if (format) {
        va_start(args, format);
        NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
        DDLogWarn(@"[WARN] %@ %@",func, message);
        va_end(args);
    }
}

-(void) info:(NSString*) func format:(NSString*) format, ... {
    va_list args;
    if (format) {
        va_start(args, format);
        NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
        DDLogInfo(@"[INFO] %@ %@",func, message);
        va_end(args);
    }
}

-(void) debug:(NSString*) func format:(NSString*) format, ... {
    va_list args;
    if (format) {
        va_start(args, format);
        NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
        DDLogDebug(@"[DEBUG] %@ %@",func, message);
        va_end(args);
    }
}

-(void) verbose:(NSString*) func format:(NSString*) format, ... {
    va_list args;
    if (format) {
        va_start(args, format);
        NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
        DDLogVerbose(@"[VERBOSE] %@ %@",func, message);
        va_end(args);
    }
}
@end
