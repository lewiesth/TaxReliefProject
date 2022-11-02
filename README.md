# TaxReliefProject

## Description

This project was done to complete an automation assignment for testing a scenario which includes REST requests and web browser testing.
More details of the scenario and its background can be found here, as well as the .jar file to download and run locally - https://github.com/strengthandwill/oppenheimer-project-dev

For scripting the automated test cases, I had used python as my programming language of choice and mainly used RobotFramework - https://robotframework.org/
The test cases mainly covered functional testing due to a lack of capacity, but should also ideally cover non-functional scenarios like load and stress testing which will be elaborated further down this document


## How to run

Fork and clone this repository to your local machine and IDE of choice. Follow the steps on https://docs.github.com/en/get-started/quickstart/fork-a-repo if you are unsure on how to fork and clone from github

For the IDE, I had used PyCharm as it is convenient to use and to include needed packages

Ensure that the OppenheimerProjectDev.jar file is running before running any of the scripts

In the terminal of your IDE, navigate to the folder where your project is stored in. You can run the test scripts with the following commands

```
#Runs all the test cases in the project directory
robot .\

#Runs all the test cases in the project sub-directory
robot.\OppenheimerUS1

#Runs a specific test case
robot .\OppenheimerUS1\TC_01_Insert_Single_Person_VALID.robot

#Runs test cases with a specific tag
robot -i smoke .\OppenheimerUS1

#Runs test cases except those with specific tag
robot -e smoke .\OppenheimerUS1
```

After running the test cases, you can review all the test cases ran in the log.html file under venv with Right-click -> Open in -> Browser -> Chrome

## Improvements
### Non-functional testing
Ideally, non-functional testing should be done on both the REST requests and the web pages to evaluate performance.

For REST requests, SoapUI can be used to run concurrent threads to test multiple calls to each REST request to evaluate how well it performs under load and measure any deterioration in response times.
For the context of this project, having 10 threads calling each service 5 times a second should suffice as it is unlikely that it will be under heavy load as a non-commercial service

### Logging
Although I have mentioned the built-in logging by PyCharm above, it would be better and IDE agnostic to include a more robust logging framework such as Allure. This would allow us to generate reports regardless of where we run the tests and could support a larger range of users

### TestData
Currently, test data is being created manually and stored locally either within the codebase or on local machine. In an ideal scenario, I could create Python classes that could generate the data appropriately for both valid and invalid test cases on demand and remove the need to have test data stored in a disorderly manner

### Test cleanup
In many of the testcases, the validations and data manipulation would seem to be rather large chunks and repetitive. Given enough time, it would be good practise to store validations and formulas in keywords/classes to reduce the mess and keep the code more concise


## Packages and versions
| Packages | Versions |
| -------- | -------- |
| robotframwork | 6 |
| robotframework-requests | 0.9.4 |
| robotframework-jsonlibrary | 0.5 |
| robotframework-seleniumlibrary | 6.0.0 |
| requests | 2.28.1 |

| WebDrivers | Versions |
| ---------- | -------- |
| Chrome | 106.0.5249.61 |
| Gecko | 0.32.0 |
| Edge | 106.0.1370.52 |

Python - 3.11.0

### Testing tags
| Functional | Smoke | Logical | Portability-C | Portability-FF | Portability-E |


## Attached project charter that gives an overview of the tests conducted
### Total tests done - 100
### Tests Passed - 73
### Tests Failed - 27
