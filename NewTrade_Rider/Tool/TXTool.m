//
//  TXTool.m
//  NewTrade_Rider
//
//  Created by xph on 2024/2/19.
//

#import "TXTool.h"
#import <UIKit/UIKit.h>
@implementation TXTool
+ (NSAttributedString *)getHtmlStr:(NSString *)attrString {
/*

 */
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[attrString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];

    
    return attrStr;
}
@end
