# DateCalculator
BCG Digital Ventures Developer Test 5314819

## Explanation
For calculating the numbers of full days in between two given dates we need to subtract dates. So, we need to convert dates to something that can be subtractable and what could be better than _Julian Day Number_ in this case? 

The Julian Day Number (JDN) is the integer assigned to a whole solar day in the Julian day count starting from noon Greenwich Mean Time, with Julian day number 0 assigned to the day starting at noon on January 1, 4713 BC. For more information about JDN take a look at https://en.wikipedia.org/wiki/Julian_day

Now that we have two numbers subtracting them calculates the number of full days in between. The only thing that should be taken to account is validating the dates and JDNs.

## Continuous Integration

The main goal of CI is proving this fact that the changes applied by different developers all work together. Also all tests cases pass. In general, it is an automated way to make sure the application is in a good condition and all parts are working together.

There are several systems and services could be used for CI. Most of them have a config file in which the application language and some other properties that are needed for build or test are declared. Then after changing the source that service will try to run the tests and build the application to make sure those changes have not broken anything in the app.

For this application I'm using Travis CI as continuous integration service. The config file .travis.yml describe what should be done in other to build/test the app. So, I can make sure the app is always in a good condition.

![Travis CI](/travis.png)
