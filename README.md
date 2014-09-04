baseball_tracker
================
brianarenz@gmail.com
9/2014

Coding exercise for On-Life

This command-line application demonstrates Ruby 2.1.1, Activerecord, and sqlite3 in an experimental mock "MVC"

SETUP:
    
    run "bundle install"
        "rake db:schema:dump"
        "rake db:migrate"
        "rake db:test:prepare"

TESTS:
    
    run "rake"

USAGE:

    run "ruby baseballtraker.rb" from project root

    Enter command "4" to import players
        Enter "data/Master-small.csv" as path to players file
        "Exit"

    Enter command "5" to import batting stats
        Enter "data/Batting-07-12.csv" as path to stats file
        "Exit"

    Enter "1" to get most improved player by date range

    Enter "2" to get slugging average by year

    Enter "3" to get triple crown winners by year

ENJOY

