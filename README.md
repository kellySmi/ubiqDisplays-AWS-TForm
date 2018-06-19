# AWS API with a Lambda
### This is an AWS implementation of ubiquity displays
This implementation uses the AWS API gateway, Lambda and S3 to store the clients template, and image files. 
AWS Services used:

* Amazon API Gateway
* AWS Lambda
* Amazon S3
* Amazon CloudFront
This is the code that accompanies this [post](https://codesmith.life/?p=43&preview=true).

Our static content (React Web App) is stored in an S3 bucket served up to the client when called from the API gateway.
The client app calls the API gateway which calls the Lambdas to retrieve and respond with the display data stored in S3.
It uses AWS Cognito for user authentication, and AWSMobile hub which allows the serving of code from S3.

### installation
 ```bash
$ git clone
$ cd directory
$ npm install
 ```
