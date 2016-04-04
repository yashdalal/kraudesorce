var Firebase = require("firebase");
var XMLHttpRequest = require("xmlhttprequest").XMLHttpRequest;

var ref = new Firebase('https://fiery-inferno-2827.firebaseio.com/locations/holmesLounge');
console.log("hello");

var xmlHttp = new XMLHttpRequest();
xmlHttp.open("GET", "http://ec2-54-209-170-153.compute-1.amazonaws.com/~bbishop/437/nmap_output.xml", true);
xmlHttp.send(null);
xmlHttp.onreadystatechange = setHostNum;

function setHostNum()
{
    if (xmlHttp.readyState == 4) {
        console.log("in readyState");
        xmlDoc = xmlHttp.responseXML.documentElement;
        var host_tag = xmlDoc.getElementsByTagName("hosts")[0];
        var host_val = host_tag.getAttribute("up");
        
        var hostsRef = ref.child("hostCount");
        hostsRef.set(host_val);
    }
    var host_val1 = 79;
    
    //print out values of user and host counts
ref.on("value", function(snapshot) {
    var hCount = snapshot.val().hostCount;
    var uCount = snapshot.val().userCount;
    console.log("Num hosts is: " + hCount);
    console.log("Num current users is: " + uCount);
}, function (errorObject) {
  console.log("The read failed: " + errorObject.code);
});

}
