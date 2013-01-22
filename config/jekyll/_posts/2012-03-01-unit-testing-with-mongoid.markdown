---
layout: post
title: Unit testing with Mongoid
date: 2012-03-01 12:01
categories: [ruby, mongoid, rails]
author: Stuart
sharing: true
footer: true
---

Since MongoDB has no transactions you need to the clearing up for data after each unit test manually, here is a tip to make that a lot easier. In file test_helper.rb in class ActiveSupport::TestCase add the following  

    teardown :clean_mongodb
    def clean_mongodb
       Mongoid.database.collections.each do |collection|
         unless collection.name =~ /^system\./
           collection.remove
         end
      end
    end
