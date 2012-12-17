#import "AFIncrementalStore.h"
#import "AFRestClient.h"

@interface TodoAPIClient : AFRESTClient <AFIncrementalStoreHTTPClient>

+ (TodoAPIClient *)sharedClient;

@end
