var Firebase = require("firebase");

var ref = new Firebase('https://fiery-inferno-2827.firebaseio.com/locations/holmesLounge/meanData');

for(i = 1; i < 6; i++){
	var day;
	switch (i) {
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

	for (j = 12; j < 20; j++){
		for(k = 0; k < 4; k++){
			var minute;
			var time;
			switch(k) {
			case 0:
				minute = 0;
				time = j+":"+minute+"0";
				break;
			case 1:
				minute = 15;
				time = j+":"+minute;
				break;
			case 2:
				minute = 30;
				time = j+":"+minute;
				break;
			case 3:
				minute = 45;
				time = j+":"+minute;
				break;
			}
			
			
			var timeRef = ref.child(day+"/"+time);
			timeRef.child("mean").set(50);
			timeRef.child("numDataPts").set(1);
		}
	}
}