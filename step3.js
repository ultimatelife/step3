var http = require('http');
var fs = require('fs');

var file = fs.createWriteStream("file.csv");
var request = http.get("http://www.data.go.kr/comm/file/download.do?atchFileId=FILE_000000001347635&fileDetailSn=1", function(response) {
    response.pipe(file);
});
