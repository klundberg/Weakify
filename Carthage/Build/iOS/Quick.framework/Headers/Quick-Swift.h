// Generated by Apple Swift version 2.0 (swiftlang-700.0.57.3 clang-700.0.72)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if defined(__has_include) && __has_include(<uchar.h>)
# include <uchar.h>
#elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
#endif

typedef struct _NSZone NSZone;

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted) 
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
#endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
#if defined(__has_feature) && __has_feature(modules)
@import ObjectiveC;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"


/// An object encapsulating the file and line number at which a particular example is defined.
SWIFT_CLASS("_TtC5Quick8Callsite")
@interface Callsite : NSObject

/// The absolute path of the file in which an example is defined.
@property (nonatomic, readonly, copy) NSString * __nonnull file;

/// The line number on which an example is defined.
@property (nonatomic, readonly) NSUInteger line;
@end

@class Example;
@class ExampleMetadata;


/// A configuration encapsulates various options you can use to configure Quick's behavior.
SWIFT_CLASS("_TtC5Quick13Configuration")
@interface Configuration : NSObject

/// Run all examples if none match the configured filters. True by default.
@property (nonatomic) BOOL runAllWhenEverythingFiltered;

/// Registers an inclusion filter.
///
/// All examples are filtered using all inclusion filters.
/// The remaining examples are run. If no examples remain, all examples are run.
///
/// \param filter A filter that, given an example, returns a value indicating
/// whether that example should be included in the examples
/// that are run.
- (void)include:(BOOL (^ __nonnull)(Example * __nonnull))filter;

/// Registers an exclusion filter.
///
/// All examples that remain after being filtered by the inclusion filters are
/// then filtered via all exclusion filters.
///
/// \param filter A filter that, given an example, returns a value indicating
/// whether that example should be excluded from the examples
/// that are run.
- (void)exclude:(BOOL (^ __nonnull)(Example * __nonnull))filter;

/// Identical to Quick.Configuration.beforeEach, except the closure is provided with metadata on the example that the closure is being run prior to.
- (void)beforeEachWithMetadata:(void (^ __nonnull)(ExampleMetadata * __nonnull))closure;

/// Like Quick.DSL.beforeEach, this configures Quick to execute the given closure before each example that is run. The closure passed to this method is executed before each example Quick runs, globally across the test suite. You may call this method multiple times across mulitple +[QuickConfigure configure:] methods in order to define several closures to run before each example.
///
/// Note that, since Quick makes no guarantee as to the order in which
/// +[QuickConfiguration configure:] methods are evaluated, there is no
/// guarantee as to the order in which beforeEach closures are evaluated
/// either. Mulitple beforeEach defined on a single configuration, however,
/// will be executed in the order they're defined.
///
/// \param closure The closure to be executed before each example
/// in the test suite.
- (void)beforeEach:(void (^ __nonnull)(void))closure;

/// Identical to Quick.Configuration.afterEach, except the closure is provided with metadata on the example that the closure is being run after.
- (void)afterEachWithMetadata:(void (^ __nonnull)(ExampleMetadata * __nonnull))closure;

/// Like Quick.DSL.afterEach, this configures Quick to execute the given closure after each example that is run. The closure passed to this method is executed after each example Quick runs, globally across the test suite. You may call this method multiple times across mulitple +[QuickConfigure configure:] methods in order to define several closures to run after each example.
///
/// Note that, since Quick makes no guarantee as to the order in which
/// +[QuickConfiguration configure:] methods are evaluated, there is no
/// guarantee as to the order in which afterEach closures are evaluated
/// either. Mulitple afterEach defined on a single configuration, however,
/// will be executed in the order they're defined.
///
/// \param closure The closure to be executed before each example
/// in the test suite.
- (void)afterEach:(void (^ __nonnull)(void))closure;

/// Like Quick.DSL.beforeSuite, this configures Quick to execute the given closure prior to any and all examples that are run. The two methods are functionally equivalent.
- (void)beforeSuite:(void (^ __nonnull)(void))closure;

/// Like Quick.DSL.afterSuite, this configures Quick to execute the given closure after all examples have been run. The two methods are functionally equivalent.
- (void)afterSuite:(void (^ __nonnull)(void))closure;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end



/// Examples, defined with the it function, use assertions to demonstrate how code should behave. These are like "tests" in XCTest.
SWIFT_CLASS("_TtC5Quick7Example")
@interface Example : NSObject

/// A boolean indicating whether the example is a shared example; i.e.: whether it is an example defined with itBehavesLike.
@property (nonatomic) BOOL isSharedExample;

/// The site at which the example is defined. This must be set correctly in order for Xcode to highlight the correct line in red when reporting a failure.
@property (nonatomic) Callsite * __nonnull callsite;
@property (nonatomic, readonly, copy) NSString * __nonnull description;

/// The example name. A name is a concatenation of the name of the example group the example belongs to, followed by the description of the example itself.
///
/// The example name is used to generate a test method selector
/// to be displayed in Xcode's test navigator.
@property (nonatomic, readonly, copy) NSString * __nonnull name;

/// Executes the example closure, as well as all before and after closures defined in the its surrounding example groups.
- (void)run;
@end



/// Example groups are logical groupings of examples, defined with the describe and context functions. Example groups can share setup and teardown code.
SWIFT_CLASS("_TtC5Quick12ExampleGroup")
@interface ExampleGroup : NSObject
@property (nonatomic, readonly, copy) NSString * __nonnull description;

/// Returns a list of examples that belong to this example group, or to any of its descendant example groups.
@property (nonatomic, readonly, copy) NSArray<Example *> * __nonnull examples;
@end



/// A class that encapsulates information about an example, including the index at which the example was executed, as well as the example itself.
SWIFT_CLASS("_TtC5Quick15ExampleMetadata")
@interface ExampleMetadata : NSObject

/// The example for which this metadata was collected.
@property (nonatomic, readonly) Example * __nonnull example;

/// The index at which this example was executed in the test suite.
@property (nonatomic, readonly) NSInteger exampleIndex;
@end



/// A namespace for filter flag keys, defined primarily to make the keys available in Objective-C.
SWIFT_CLASS("_TtC5Quick6Filter")
@interface Filter : NSObject

/// Example and example groups with [Focused: true] are included in test runs, excluding all other examples without this flag. Use this to only run one or two tests that you're currently focusing on.
+ (NSString * __nonnull)focused;

/// Example and example groups with [Pending: true] are excluded from test runs. Use this to temporarily suspend examples that you know do not pass yet.
+ (NSString * __nonnull)pending;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

#pragma clang diagnostic pop
