var Firebase = require("firebase");
var fs = require("fs");

console.log("hello");

var ref = new Firebase('https://fiery-inferno-2827.firebaseio.com/locations/holmesLounge');
var analyticsRef = ref.child("analytics");


/*
fs.readFile("../../public_html/437/target.txt", "utf8", function(error, text) {
  if (error)
    throw error;
  console.log("The file contained:", text);
});
*/

//called whenever userCount or hostCount changes	
analyticsRef.on("child_changed", function(snapshot){
	var hCount = snapshot.val().hostCount;
	var uCount = snapshot.val().userCount;

	//mean calculation
	var curMean = hCount + parseInt(uCount);
	console.log("current mean is " + curMean);	
	//set everything (could have been done in this fn)
	setThings(curMean);
});

function setThings(curMean)
{
	var date =  new Date();
	var hour = date.getHours();
	var min = date.getMinutes();
	var day = date.getDay();
	
	//convert from 0-6 to Sunday-Saturday
	switch (day) {
    case 0:
        day = "Sunday";
        break;
    case 1:
        day = "Monday";
        break;
    case 2:
        day = "Tuesday";
        break;
    case 3:
        day = "Wednesday";
        break;
    case 4:
        day = "Thursday";
        break;
    case 5:
        day = "Friday";
        break;
    case 6:
        day = "Saturday";
        break;
}
	//get correct period
	if (min < 15){
		min = 00;
	}
	else if (min < 30){
		min = 15;
	}
	else if (min < 45){
		min = 30;
	}
	else min = 45;
	
	var time = hour+":"+min;
	console.log("time is " + time);
	
	timeRef = ref.child("/meanData/"+day+"/"+time);
	timeRef.once("value", function(snapshot){		
		
		//if period we're in doesn't exist
		if (snapshot.val() == null){
			console.log("current period not defined for location");
			
			//used to add a period here, think I really want to
			//just say that the place is closed at that time
			/*
			console.log("adding new period");
			var meanRef = timeRef.child("mean");
			meanRef.set(curMean);
		
			var ptsRef = timeRef.child("numDataPts");
			ptsRef.set(1);	
			*/
		}
		//else period exists and has a mean value
		else {
			var oldMean = snapshot.val().mean;
			var numDataPts = snapshot.val().numDataPts;
			console.log("got old mean of " + oldMean);
			console.log("got " + numDataPts + " data point(s)");
			
			//recalculate mean using current mean
			var moarPts = numDataPts + 1;
			var newMean = (oldMean*numDataPts + curMean) / (moarPts);
			
			var meanRef = timeRef.child("mean");
			meanRef.set(newMean);
			
			var ptsRef = timeRef.child("numDataPts");
			ptsRef.set(moarPts);
		}		
			console.log("---  ---  ---  ---");
	});
}