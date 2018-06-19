var AWS = require('aws-sdk');
var s3 = new AWS.S3();

exports.handler = async (event,context,callback) => {
  context.callbackWaitsForEmptyEventLoop = false;
  //console.log(event);
  var response = {
    statusCode: '200',
    body: getImage(event.queryStringParameters),
   //body: event,
    headers: {
        'Content-Type': 'application/json',
      }
  }
 // console.log("event:",event);
  callback(null,response);
};

function getImage(e){

  var params = {
      Bucket : "ubiq-client-images",
      Key : e.client_id+"/display01.jpg"
  };
  //s3.getObject(params,function(err,data ){
  s3.getObjectAcl(params, function(err, data) {
    		if(err){
          console.log("errrrr",err); // an error occurred
        return JSON.stringify(err);
        }else{
          console.log("dattta");
          return JSON.stringify(data);
        }
  });
  //return JSON.stringify(params);
}
