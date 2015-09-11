//
//  SERegularExpressionsTests.m
//  SEStringUtilities
//
//  Created by Brian Nickel on 1/7/15.
//  Copyright (c) 2015 Stack Exchange, Inc. All rights reserved.
//

@import XCTest;
@import SEStringUtilities;

@interface SERegularExpressionsTests : XCTestCase

@end

@implementation SERegularExpressionsTests

- (void)testReplacePatternWithTemplate
{
    NSString *string = [@"0 - A B - M N - Y Z" SE_stringByReplacingPattern:@"(\\w) (\\w)" options:0 withTemplate:@"$2<--$1"];
    XCTAssertEqualObjects(@"0 - B<--A - N<--M - Z<--Y", string);
}

- (void)testReplaceFirstOccurranceOfPatternWithTemplate
{
    NSString *string = [@"0 - A B - M N - Y Z" SE_stringByReplacingFirstOccuranceOfPattern:@"(\\w) (\\w)" options:0 withTemplate:@"$2<--$1"];
    XCTAssertEqualObjects(@"0 - B<--A - M N - Y Z", string);
}

- (void)testReplacePatternWithBlock
{
    NSString *string = [@"0 - A B - M N - Y Z" SE_stringByReplacingPattern:@"(\\w) (\\w)" options:0 withBlock:^NSString * _Nonnull(NSArray<NSString *> * _Nonnull matches, NSRange range, NSString * _Nonnull string) {
        return [NSString stringWithFormat:@"(%@ ~= %@+%@)", [matches[0] lowercaseString], matches[1], matches[2]];
    }];
    XCTAssertEqualObjects(@"0 - (a b ~= A+B) - (m n ~= M+N) - (y z ~= Y+Z)", string);
}

- (void)testReplaceFirstOccurranceOfPatternWithBlock
{
    NSString *string = [@"0 - A B - M N - Y Z" SE_stringByReplacingFirstOccuranceOfPattern:@"(\\w) (\\w)" options:0 withBlock:^NSString * _Nonnull(NSArray<NSString *> * _Nonnull matches, NSRange range, NSString * _Nonnull string) {
        return [NSString stringWithFormat:@"(%@ ~= %@+%@)", [matches[0] lowercaseString], matches[1], matches[2]];
    }];
    XCTAssertEqualObjects(@"0 - (a b ~= A+B) - M N - Y Z", string);
}

- (void)testBlockStringArgument
{
    NSString *string = [@"a b c" SE_stringByReplacingPattern:@"[abc]" options:0 withBlock:^NSString * _Nonnull(NSArray<NSString *> * _Nonnull matches, NSRange range, NSString * _Nonnull string) {
        return string;
    }];
    XCTAssertEqualObjects(@"a b c a b c a b c", string);
}

- (void)testBlockOffsetArgument
{
    NSString *string = [@"a b c" SE_stringByReplacingPattern:@"[abc]" options:0 withBlock:^NSString * _Nonnull(NSArray<NSString *> * _Nonnull matches, NSRange range, NSString * _Nonnull string) {
        return [NSString stringWithFormat:@"%ld %@", (long)range.location, string];
    }];
    XCTAssertEqualObjects(@"0 a b c 2 a b c 4 a b c", string);
}


- (void)testFirstOccuranceOfString
{
    NSString *string = [@"Hello my friends" SE_firstOccuranceOfPattern:@"\\b\\w{1,4}\\b" options:0];
    XCTAssertEqualObjects(@"my", string);
    NSString *noString = [string SE_firstOccuranceOfPattern:@"q" options:0];
    XCTAssertNil(noString);
}

- (void)testMatchesPattern
{
    XCTAssertTrue([@"Hello my friends" SE_matchesPattern:@"\\b\\w{1,4}\\b" options:0]);
    XCTAssertFalse([@"my" SE_matchesPattern:@"q" options:0]);
}

- (void)testReplaceThrowsExceptionOnBadPattern
{
    XCTAssertThrows([@"" SE_stringByReplacingPattern:@"[[]" options:0 withTemplate:@""]);
}

- (void)testFirstOccuranceThrowsExceptionOnBadPattern
{
    XCTAssertThrows([@"" SE_firstOccuranceOfPattern:@"[[]" options:0]);
}

- (void)testMatchesThrowsExceptionOnBadPattern
{
    XCTAssertThrows([@"" SE_matchesPattern:@"[[]" options:0]);
}

@end
