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

To utilise allure reporting, run the allure-robot listener in conjunction with the robot commands above. You need to have allure commandline application downloaded and your system variable PATH set to the downloaded .bin file to run allure. Step by step instructions can be found here https://docs.qameta.io/allure/

```

# Runs allure-robotframework listener with robot for sub-directory OppenheimerUS1
robot --listener allure_robotframework ./OppenheimerUS1/

```

After running the above command, allure creates a directory in your project under ./output/allure which contains the json output files.
You can either access the allure report using the json files, or create an index.html file and accessing it using Right-click -> Open in -> Browser -> Chrome

```

#Creates and directs you to the allure report that is hosted locally
#It stops working if you cancel the terminal process
allure serve {ProjectDirectory}\TaxReliefProject\output\allure

#Creates an folder under Project Directory named allure-report with reporting data and index.html file
allure generate {ProjectDirectory}\TaxReliefProject\output\allure

```

## Improvements
### Non-functional testing
Ideally, non-functional testing should be done on both the REST requests and the web pages to evaluate performance.

For REST requests, SoapUI can be used to run concurrent threads to test multiple calls to each REST request to evaluate how well it performs under load and measure any deterioration in response times.
For the context of this project, having 10 threads calling each service 5 times a second should suffice as it is unlikely that it will be under heavy load as a non-commercial service

### Logging
Allure has been added into this project as a test report tool to support better user readability and make it more intuitive to understand test results. However, due to the nature of allure-robotframework, it can be clunky as the results can only be viewed when having the allure output files from running the test cases which can be in large numbers and difficult to share results between machines. It would be better if the reports could be stored and distributed as a standalone file, which could be possible with allure integration with docker containers.

### Reuseability of code
To accomodate a large range of data inputs for the same test scenario, I had used the Template keyword in Userstory 4 to reuse testcases and format code in a readable format. While this makes the code easier to read and more efficient to run, it has the downside of being hard to pinpoint any failures in test scenarios. Should a single data input cause a Failed scenario, the entire suite of test data is considered to have failed and may consume more capacity in diagnosing the root cause.

It may then be more prudent to seperate test input data to individual test cases as done in Userstory 1 and 2, such that any failures can be easily identified and handled. It would be up to the individual and their team to determine the appropriate approach to code reuseability.

### Service improvements
The webservice for both UI and API usecases can be further refined to be more robust and resilient to handle a larger range of input data and datatypes. Suggestions and defects identified can be found in the Testing Documentation.xlsx file for more information, but largely consists of having constraints regarding range of data and datatypes.

## Packages and versions
| Packages | Versions |
| -------- | -------- |
| robotframework | 6.0.1 |
| robotframework-requests | 0.9.4 |
| robotframework-jsonlibrary | 0.5 |
| robotframework-seleniumlibrary | 6.0.0 |
| requests | 2.28.1 |
| allure-robotframework | 2.12.0 |

| WebDrivers | Versions |
| ---------- | -------- |
| Chrome | 108.0.5359.71 |
| Gecko | 0.32.0 |
| Edge | 108.0.1462.54 |

Python - 3.11.1

### Testing tags
| Functional | Smoke | Portability-C | Portability-FF | Portability-E |

Tags are used to run tests based on their categories. For running all test cases, tags should be omitted in the command as instructued in How to run section of this read me.

Functional - Run tests that are deemed to be testing functional capabilities of the testware
Smoke - Run tests on the critical functionality of the testware. Can be considered a subset of functional tests to be run when time is tight
Portability - Run tests to check useability of testware on different platforms, especially for web testing. Portability-C/FF/E refers to Chrome/FireFox/Edge respectively

## Attached project charter that gives an overview of the tests conducted
### Total tests done - 90
### Tests Passed - 60
### Tests Failed - 30


![Allure report snapshot 9Jan](https://user-images.githubusercontent.com/44538479/211273452-85fad899-3d7e-40f7-894c-f6b332251d17.PNG)

To explore the results further using allure reporting tool, ensure you have followed the instructions on running allure under the How to run section. 

Refer to Testing Documentation.xlsx for test charter details, including test description, test steps, input data and comments regarding test case failing
