function parseIntegers(val) {
	var output = parseInt(val);
	if(!(output > 0)){
		output = '';
	}
	
	return output;
}
function calculateBMI(){
	var ids = new Array('bmi_1a', 'bmi_1b','bmi_2a', 'bmi_2b','bmi_3a', 'bmi_3b','bmi_4a', 'bmi_4b');
	var ids_ct = ids.length;
	for(i=0; i < ids_ct; i++){
		$(ids[i]).removeClassName('highlight')
	}
	
	var form = document.forms.bmi;

	var height = parseIntegers(form.height.value);
	var weight = parseIntegers(form.weight.value);
	
	var error = false;
	var emessage = "The Following errors were found in this form.\n";
	
	emessage += "Please correct them before trying to calculate again.\n";
	emessage += "-------------------------------------\n";
	if(weight=="") {
		emessage += "Weight - please enter your weight in pounds\n";
		error = true;
	}
	if(height=="") {
		emessage += "Height - please enter your height in inches\n";
		error = true;
	}
	if(error) {
		alert(emessage);
		return !error;
	}

	// Calculates, and rounds to 2 decimals
	var bmicalc = Math.round(( (weight/( height * height ))  * 703 ) * 100)/100;
	
	var outputStr = "At " + height + "\" tall and " + weight + "lbs your BMI is: <strong>" + bmicalc + "</strong>";
	
	document.getElementById('BMIoutput').innerHTML=outputStr;
		
	if(bmicalc < 18.5){
		$('bmi_1a').addClassName('highlight')
		$('bmi_1b').addClassName('highlight')
	} else if (bmicalc < 24.9){
		$('bmi_2a').addClassName('highlight')
		$('bmi_2b').addClassName('highlight')
	} else if (bmicalc < 29.9){
		$('bmi_3a').addClassName('highlight')
		$('bmi_3b').addClassName('highlight')
	} else {
		$('bmi_4a').addClassName('highlight')
		$('bmi_4b').addClassName('highlight')
	}
	
}