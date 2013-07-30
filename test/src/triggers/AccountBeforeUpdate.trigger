trigger AccountBeforeUpdate on Account (before update) {
	if (trigger.new[0].Name == 'BadUpdate'){
		trigger.new[0].Description = 'Invalid Description Update';
	}
	else {
		trigger.new[0].Description = trigger.new[0].Name;
	}
	
	if (trigger.new[0].Fax == null && trigger.new[0].Phone == null){
		trigger.new[0].Description = 'Missing Phone Number';
	}
	
}