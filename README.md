# ShanBayTagListView

##install
```
drag all the '*.h/m' files in the 'Classes' path into your project
```

##usage  
* first:import header  

```
#import "SBTagListView.h"
```
* second: add protocol      

```
@interface yourviewcontroller()<SBTagListViewDelegate>  
```  
* third: alloc and init it with given width and given strings    

```
NSMutableArray *array = [NSMutableArray arrayWithArray:@[@"This",@"is",@"SBTagListView,",@"use",@"it",@"and",@"enjoy",@"your",@"self"]];
self.list = [[SBTagListView alloc] initWithWidth:300 contentArray:array];  
```  
* then add it into your view and you'll see it