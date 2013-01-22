---
layout: post
title: "TDD, CoreData and Magical Record"
date: 2012-08-30 11:08
comments: true
categories: [ios, coredata, tdd, magical record, unit tests]
author: Stuart
---
As part of our push to do more TDD I have been wrestling with what to do for one of our classes that is responsible for persisting business objects.  It is using Core Data for storage so other than checking for manadatory parameters I thought there was not much else that could be tested. I did consider wrapping all the Core Data access in my own class which would allow for mocking but it didn't feel right.  As a last option I did some [searches](https://www.google.co.uk/search?q=coredata+tdd&sugexp=chrome,mod=14&sourceid=chrome&ie=UTF-8).  

This led me to a [CIMGF](http://www.cimgf.com/) [article](http://www.cimgf.com/2012/05/15/unit-testing-with-core-data/). It gives a solution to my problem, instead of mocking all the Core Data calls, just use normal CoreData but set your persistent store to be in-memory.  The beauty of this is that your test execution isn't slowed down and you have a fresh clean database for each test. The article suggests using [Magical Record](https://github.com/magicalpanda/magicalrecord) to wrap up your Core Data access and be responsible for creating the in-memory store.

By using a combination of the CIMGF article and the Magical Record documentation I was able to get a method of our application implemented and tested in a few hours. Obviously things might change when we use it more but so far I think it is a great, low impact way of testing Core Data reliant code.  The TDD purist out there probably won't like it but I am happy.

Note: I had to add our xcdatamodeld file into the tests target to get it working, this isn't mentioned anywhere in the documentation so might just be something odd about our project set up.

Below is an example of one of the test

  - (void)testShouldStoreFileItemAsOffline {
      File *item = [[File alloc] init];
      item.name = @"My Test Item";
      store.context = [NSManagedObjectContext MR_defaultContext];
      [store markItemAsOffline:item forProvider:[[Provider alloc] init] success:nil failure:nil];
      
      NSArray *items = [FileData MR_findAll];
      
      STAssertNotNil(items, @"Should have returned items");
      STAssertTrue([items count] == 1, @"Should have returned a single item");
      STAssertEqualObjects(((FileData *)[items objectAtIndex:0]).name, item.name, @"Should have saved the supplied item");
  }

Here are some other article that I found on my travels

[http://stackoverflow.com/questions/6880739/how-to-use-core-data-for-dependency-injection](http://stackoverflow.com/questions/6880739/how-to-use-core-data-for-dependency-injection)  
[http://yannickloriot.com/2012/03/magicalrecord-how-to-make-programming-with-core-data-pleasant/](http://yannickloriot.com/2012/03/magicalrecord-how-to-make-programming-with-core-data-pleasant/)  
[http://iamleeg.blogspot.co.uk/2009/09/unit-testing-core-data-driven-apps.html](http://iamleeg.blogspot.co.uk/2009/09/unit-testing-core-data-driven-apps.html)  