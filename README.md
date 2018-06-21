# AWS API with a Lambda
### This is an AWS implementation of ubiquity displays
This implementation uses the AWS API gateway, Lambda and S3 to store the clients template, and image files.
AWS Services used:
* Amazon API Gateway
* AWS Lambda
* Amazon S3
* Amazon CloudFront

This is the code that accompanies this [post](: https://codesmith.life/2018/06/19/full-signage-display-system-pt-1/).
This project requires the [display application project](https://github.com/kellySmi/display-app.git) that runs on the Raspberry Pi. It is a node application that retrieves it's display information from this application.
This application is an API that delivers JSON formatted data containing the HTML/JS/CSS template, and images that are used by the template.

Our static content (React Web App) is stored in an S3 bucket served up to the client when called from the API gateway.
The client app calls the API gateway which calls the Lambdas to retrieve and respond with the display data stored in S3.
It uses AWS Cognito for user authentication, and AWSMobile hub which allows the serving of code from S3.
