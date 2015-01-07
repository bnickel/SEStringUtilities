//
//  SETokenReplacementTests.m
//  SEStringUtilities
//
//  Created by Brian Nickel on 1/7/15.
//  Copyright (c) 2015 Stack Exchange, Inc. All rights reserved.
//

@import XCTest;
@import SEStringUtilities;

@interface SETokenReplacementTests : XCTestCase

@end

@implementation SETokenReplacementTests

- (void)testSimpleStringReplacement
{
    NSString *friend = @"World";
    XCTAssertEqualObjects(@"Hello World.", [@"Hello {friend}." SE_stringByReplacingTokensWithValues:NSDictionaryOfVariableBindings(friend)]);
}
- (void)testFailedStringReplacement
{
    NSString *friend = @"World";
    XCTAssertEqualObjects(@"Hello World. {story}", [@"Hello {friend}. {story}" SE_stringByReplacingTokensWithValues:NSDictionaryOfVariableBindings(friend)]);
}

- (void)testMultipleStringReplacements
{
    NSString *friend = @"World";
    NSString *oldFriend = @"Earth";
    NSString *transformedString = [@"Hello {friend}. Are you related to {oldFriend}? {friend} is a similar name." SE_stringByReplacingTokensWithValues:NSDictionaryOfVariableBindings(friend, oldFriend)];
    XCTAssertEqualObjects(@"Hello World. Are you related to Earth? World is a similar name.", transformedString);
}

- (void)testSimpleAttributedStringReplacement
{
    NSAttributedString *friend = [[NSAttributedString alloc] initWithString:@"World" attributes:@{@"FooStyle": @"Orange"}];
    NSAttributedString *transformedString = [@"Hello {friend}." SE_attributedStringByReplacingTokensWithValues:NSDictionaryOfVariableBindings(friend)];
    
    NSMutableAttributedString *concatenatedString = [[NSMutableAttributedString alloc] initWithString:@"Hello "];
    [concatenatedString appendAttributedString:friend];
    [concatenatedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"."]];
    
    XCTAssertEqualObjects([concatenatedString copy], transformedString);
}

- (void)testFailedAttributedStringReplacement
{
    NSAttributedString *friend = [[NSAttributedString alloc] initWithString:@"World" attributes:@{@"FooStyle": @"Orange"}];
    NSAttributedString *transformedString = [@"Hello {friend}. {story}" SE_attributedStringByReplacingTokensWithValues:NSDictionaryOfVariableBindings(friend)];
    
    NSMutableAttributedString *concatenatedString = [[NSMutableAttributedString alloc] initWithString:@"Hello "];
    [concatenatedString appendAttributedString:friend];
    [concatenatedString appendAttributedString:[[NSAttributedString alloc] initWithString:@". {story}"]];
    
    XCTAssertEqualObjects([concatenatedString copy], transformedString);
}

- (void)testMultipleAttributedStringReplacements
{
    NSAttributedString *friend = [[NSAttributedString alloc] initWithString:@"World" attributes:@{@"FooStyle": @"Orange"}];
    NSString *oldFriend = @"Earth";
    NSAttributedString *transformedString = [@"Hello {friend}. Are you related to {oldFriend}? {friend} is a similar name." SE_attributedStringByReplacingTokensWithValues:NSDictionaryOfVariableBindings(friend, oldFriend)];
    
    NSMutableAttributedString *concatenatedString = [[NSMutableAttributedString alloc] initWithString:@"Hello "];
    [concatenatedString appendAttributedString:friend];
    [concatenatedString appendAttributedString:[[NSAttributedString alloc] initWithString:@". Are you related to "]];
    [concatenatedString appendAttributedString:[[NSAttributedString alloc] initWithString:oldFriend]];
    [concatenatedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"? "]];
    [concatenatedString appendAttributedString:friend];
    [concatenatedString appendAttributedString:[[NSAttributedString alloc] initWithString:@" is a similar name."]];
    
    XCTAssertEqualObjects([concatenatedString copy], transformedString);
}

@end
